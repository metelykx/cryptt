//
//  StartView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI
import CoreData

struct StartView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContextt
    @Environment(\.colorScheme) private var colorScheme
    
    private var colors: Color {
        colorScheme == .dark ? .black : .white
    }
    
    private var colorsText: Color {
        colorScheme == .dark ? .black : .white
    }
    
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var isError: String? = nil
    @State private var isAuth: Bool = false
    
    // Управление фокусом
    enum FocusField: Hashable {
        case name, password
    }
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    
                    Circle1View(size: geometry.size)
                    Circle2View(size: geometry.size)
                    
                    VStack(alignment: .center) {
                        Spacer()
                        
                        HStack(alignment: .center) {
                            Text("Crypto")
                                .font(.title)
                                .bold()
                                .fontWidth(.compressed)
                                .foregroundStyle(colors)
                            
                            Image(systemName: "bitcoinsign.bank.building.fill")
                                .resizable()
                                .frame(width: geometry.size.width / 10, height: geometry.size.height / 20)
                                .foregroundStyle(.yellow)
                        }
                        
                        // MARK: - Updated Input Fields
                        VStack(spacing: 20) {
                            // Поле имени
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundStyle(colorsText)
                                Text("Name")
                                    .font(.headline)
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
                                Text("Password")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    .foregroundStyle(colorsText)
                                SecureField("Enter password", text: $password)
                                    .focused($focusedField, equals: .password)
                                    .onTapGesture {
                                        focusedField = .password
                                    }
                            }
                            .authInputStyle()
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 30)
                        
                        NavigationLink {
                            AuthView()
                        } label: {
                            Text("Sign Up")
                                .foregroundStyle(colors)
                        }
                        .padding(.top, 10)
                        
                        // MARK: - Error Display
                        if let error = isError {
                            Text(error)
                                .font(.callout)
                                .padding(.top, 10)
                                .foregroundColor(.red)
                        }
                       
                        Button {
                            auth()
                        } label: {
                            Text("Sign In")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, geometry.size.height * 0.03)
                                .foregroundColor(.white)
                        }
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal, geometry.size.width * 0.2)
                        .padding(.top, geometry.size.height * 0.03)
                        
                        Spacer()
                    }
                }
            }
            .background(Color.primary)
            .onTapGesture {
                if focusedField != nil {
                    focusedField = nil
                }
            }
        }
        .navigationDestination(isPresented: $isAuth) {
            MainView()
        }
    }
    
    // MARK: Functions
    private func auth() {
        guard !name.isEmpty else {
            isError = "Name cannot be empty"
            return
        }
        guard !password.isEmpty else {
            isError = "Password cannot be empty"
            return
        }
        
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.predicate = NSPredicate(
            format: "name == %@ AND password == %@",
                name,
                password
            )
        
        do {
            let users = try managedObjectContextt.fetch(request)
                
            if users.isEmpty {
                isError = "Invalid credentials"
            } else {
                isError = nil
                isAuth = true
            }
        } catch {
            isError = "Database error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    StartView()
}
