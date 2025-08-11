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
    
    //MARK: Variables for control
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.colorScheme) private var colorScheme
    
 
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var repeatPass: String = ""
    
    
    @State private var isError: Bool = false
    @State private var errorMessage: String = ""
    
    // Controll Focus
    enum FocusField: Hashable {
        case name, password, repeatPassword
    }
    @FocusState private var focusedField: FocusField?
    
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
                    VStack(spacing: 20) {
                        // Поле имени
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundStyle(colorsText)
                            Text("Name").font(.headline)
                                .fontWeight(.medium)
                                .foregroundStyle(colorsText)
                            TextField("Enter your name", text: $name)
                                .focused($focusedField, equals: .name)
                                .onTapGesture {
                                    focusedField = .name
                                }
                        }
                        .authInputStyle()
                        
                        // Поле пароля
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundStyle(colorsText)
                            Text("Password").font(.headline)
                                .fontWeight(.medium)
                                .foregroundStyle(colorsText)
                            SecureField("Enter password", text: $password)
                                .focused($focusedField, equals: .password)
                                .onTapGesture {
                                    focusedField = .password
                                }
                        }
                        .authInputStyle()
                        
                        // Повтор пароля
                        HStack {
                            Image(systemName: "lock.circle.fill")
                                .foregroundStyle(colorsText)
                            Text("Repeat").font(.headline)
                                .fontWeight(.medium)
                                .foregroundStyle(colorsText)
                            SecureField("Repeat password", text: $repeatPass)
                                .focused($focusedField, equals: .repeatPassword)
                                .onTapGesture {
                                    focusedField = .repeatPassword
                                }
                        }
                        .authInputStyle()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 30)
                    
                    // MARK: - Error Display
                    if isError {
                        Text(errorMessage)
                            .font(.callout)
                            .padding(.top, 10)
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
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color.primary)
        .onTapGesture {
            // Скрываем клавиатуру только если какое-то поле в фокусе
            if focusedField != nil {
                focusedField = nil
            }
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
            let existingUsers = try managedObjectContext.fetch(fetchRequest)
            if !existingUsers.isEmpty {
                showError("User with this name already exists")
                return
            }
            
            // Создание нового пользователя
            let newItem = Item(context: managedObjectContext)
            newItem.name = name
            newItem.password = hashPassword(password)  // Храним хэш!
            
            try managedObjectContext.save()
            
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
}

// MARK: - View Modifier для стилизации полей ввода
extension View {
    func authInputStyle() -> some View {
        self
            .padding(15)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
    }
}

// MARK: - Preview
struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
