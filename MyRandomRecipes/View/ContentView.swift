//
//  ContentView.swift
//  MyRandomRecipes
//
//  Created by Juan Silva on 25/08/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State var recipe = Meal()
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    WelcomeText()
                        .padding(.bottom, 80)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(red: 0.95, green: 0.95, blue: 0.95, opacity: 1.0))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(red: 0.95, green: 0.95, blue: 0.95, opacity: 1.0))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    HStack {
                        NavigationLink(destination: RecipeDetailView(authViewModel: authViewModel),
                                       tag: 1,
                                       selection: $authViewModel.userLogged) {
                            Button(action: { authViewModel.login(email: email,
                                                                 password: password) }) {
                                Text("Login")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity, idealHeight: 60)
                                    .background(Color.green)
                                    .cornerRadius(15.0)
                            }
                        }
                        Spacer()
                        NavigationLink(destination: RecipeDetailView(authViewModel: authViewModel),
                                       tag: 1,
                                       selection: $authViewModel.userLogged) {
                            Button(action: { authViewModel.createNewUser(email: email,
                                                                         password: password) }) {
                                Text("Register")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity, idealHeight: 60)
                                    .background(Color.blue)
                                    .cornerRadius(15.0)
                            }
                        }
                    }
                    .padding()
                    .alert(isPresented: $authViewModel.showError) {
                        Alert(title: Text("Error"),
                              message: Text(authViewModel.messageError ?? "error"),
                              dismissButton: .cancel())
                    }
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    email = ""
                    password = ""
                }
            }.background(
                Image("LoginBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height))
            
            
        }.navigationBarBackButtonHidden(<#T##hidesBackButton: Bool##Bool#>)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(authViewModel: AuthViewModel())
    }
}

struct WelcomeText: View {
    var body: some View {
        Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(20)
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
            .clipShape(Capsule())
        
    }
}
