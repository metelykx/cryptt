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
        colorScheme == .dark ? .white : .black
    }
    
    @State var name: String = ""
    @State var password: String = ""
    @State var isError: String? = nil
    @State var isAuth: Bool = false
    
   
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    
                    Circle1View(size: geometry.size)
                    Circle2View(size: geometry.size)
                    
                    VStack(alignment: .center){
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
                        
                        ZStack{
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: geometry.size.width/1.1, height: geometry.size.height/6)
                                .cornerRadius(20)
                            
                            VStack {
                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundStyle(colors)
                                    Text("Name")
                                        .foregroundStyle(colors)
                                        .font(.headline)
                                    TextField("", text: $name)
                                    
                                }.padding(.bottom)
                                    .padding(.horizontal)
                                    .padding(.leading)
                                    .padding(.trailing)
                                
                                HStack {
                                    Image(systemName: "lock.fill").foregroundStyle(colors)
                                    Text("Password")
                                        .foregroundStyle(colors)
                                        .font(.headline)
                                    SecureField("", text: $password)
                                    
                                }
                                .padding(.bottom)
                                .padding(.horizontal)
                                .padding(.leading)
                                .padding(.trailing)
                          
                            }
                           
                        }
                        NavigationLink {
                            AuthView()
                        } label: {
                            Text("Sign Up")
                        }.padding(.top, -geometry.size.height / 50)
                        .padding(.top)
                        
                        //MARK: Mistake
                        if let error = isError {
                            Text(error)
                                .font(.callout)
                                .padding(.top)
                                .foregroundStyle(.red)
                        }
                       
                        
                        Button {
                            auth()
                        } label: {
                            Text("Sign In")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, geometry.size.height * 0.03)
                        }
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                        .padding(.horizontal, geometry.size.width * 0.2)
                        .padding(.top, geometry.size.height * 0.03)
                        
                        Spacer()
                    }.padding(.top, -geometry.size.height * 0.2)
                    
                }
                
            }
        }
        .navigationDestination(isPresented: $isAuth) {
            MainView()
        }
    }
    
    //MARK: Functions
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
        
        //do request
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
