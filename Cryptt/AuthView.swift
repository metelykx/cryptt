//
//  AuthView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI
import CoreData
import CryptoKit

struct AuthView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContextt
    @Environment(\.colorScheme) private var colorScheme
    
    // Состояния для ввода данных
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var repeatPass: String = ""
    
    // Состояния для обработки ошибок
    @State private var isError: Bool = false
    @State private var errorMessage: String = ""
    
   
    
    private var colorsText: Color {
        colorScheme == .dark ? .black : .white
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                
                // MARK: - Circles
                Circle1View(size: geometry.size)
                Circle2View(size: geometry.size)
                
                VStack {
                    Spacer()
                    
                    // MARK: - Header
                    HeaderView(sizes: geometry.size)
                    
                    // MARK: - Input Fields
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: geometry.size.width/1.1, height: geometry.size.height/4)
                            .cornerRadius(20)
                        
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundStyle(colorsText)
                                Text("Name")
                                    .foregroundStyle(colorsText)
                                    .font(.headline)
                                TextField("", text: $name)
                                    .onChange(of: name) { _ in
                                        resetError()
                                    }
                                    
                            }
                            .padding(.top, geometry.size.height / 30)
                            .padding(.bottom)
                            .padding(.horizontal)
                            
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundStyle(colorsText)
                                Text("Password")
                                    .foregroundStyle(colorsText)
                                    .font(.headline)
                                SecureField("", text: $password)
                                    .onChange(of: password) { _ in
                                        resetError()
                                    }
                            }
                            .padding(.bottom)
                            .padding(.horizontal)
                            
                            HStack {
                                Image(systemName: "lock.circle.fill")
                                    .foregroundStyle(colorsText)
                                Text("Repeat")
                                    .foregroundStyle(colorsText)
                                    .font(.headline)
                                SecureField("", text: $repeatPass)
                                    .onChange(of: repeatPass) { _ in
                                        resetError()
                                    }
                            }
                            .padding(.bottom)
                            .padding(.horizontal)
                            
                        } .padding(.bottom)
                            .padding(.horizontal)
                            .padding(.leading)
                            .padding(.trailing)
                    }
                    
                    
                    // MARK: - Error Display
                    if isError {
                        Text(errorMessage)
                            .font(.callout)
                            .padding(.top)
                            .foregroundColor(.red)
                            .transition(.opacity)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    withAnimation {
                                        isError = false
                                    }
                                }
                            }
                    }
                    
                    // MARK: - Auth Button
                    Button(action: authorization) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.top, 20)
                    }
                    
                    Spacer()
                }
                .padding(.bottom, geometry.size.height * 0.15)
            }
        }
        .background(.primary)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    // MARK: - Functions
    
    private func resetError() {
        withAnimation {
            isError = false
        }
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        withAnimation {
            isError = true
        }
    }
    
    private func authorization() {
        // Валидация полей
        guard !name.isEmpty else {
            showError("Please enter your name")
            return
        }
        
        guard !password.isEmpty else {
            showError("Please enter password")
            return
        }
        
        guard password.count >= 8 else {
            showError("Password must be at least 8 characters")
            return
        }
        
        guard !repeatPass.isEmpty else {
            showError("Please repeat password")
            return
        }
        
        guard password == repeatPass else {
            showError("Passwords do not match")
            return
        }
        
        // Проверка существования пользователя
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let existingUsers = try managedObjectContextt.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                showError("User with this name already exists")
                return
            }
            
            // Создание нового пользователя
            let newItem = Item(context: managedObjectContextt)
            newItem.name = name
            newItem.password = hashPassword(password)  // Храним хэш!
            
            try managedObjectContextt.save()
            
            // Успешная регистрация
            print("User registered successfully!")
            
        } catch {
            showError("Registration failed: \(error.localizedDescription)")
        }
    }
    
    private func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

// MARK: - Preview
#Preview {
    AuthView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
