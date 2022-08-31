//
//  AuthViewModel.swift
//  MyRandomRecipes
//
//  Created by Juan Silva on 30/08/2022.
//

import Foundation

final class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var messageError: String?
    @Published var showError = false
    @Published var userLogged: Int? = nil
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository = AuthRepository()) {
        self.authRepository = authRepository
    }
    
    func createNewUser(email: String, password: String) {
        authRepository.createNewUser(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newUser):
                self.user = newUser
                self.userLogged = 1
            case .failure(let error):
                self.messageError = error.localizedDescription
                self.showError = true
            }
        }
    }
    
    func login(email: String, password: String) {
        authRepository.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.user = user
                self.userLogged = 1
            case .failure(let error):
                self.messageError = error.localizedDescription
                self.showError = true
            }
        }
    }
    
    func getCurrentUser() {
        self.user = authRepository.getCurrentUser()
    }
    
    func logout() {
        do {
            try authRepository.logout()
            self.user = nil
        } catch {
            print("Error logout")
        }
    }
}
