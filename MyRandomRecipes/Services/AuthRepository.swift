//
//  AuthRepository.swift
//  MyRandomRecipes
//
//  Created by Juan Silva on 30/08/2022.
//

import Foundation

final class AuthRepository {
    private let authDatasource: AuthDatasource
    
    init(authDatasource: AuthDatasource = AuthDatasource()) {
        self.authDatasource = authDatasource
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        authDatasource.createNewUser(email: email,
                                     password: password,
                                     completionBlock: completionBlock)
    }
    
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        authDatasource.login(email: email,
                             password: password,
                             completionBlock: completionBlock)
    }
    
    func getCurrentUser() -> User? {
        authDatasource.getCurrentUser()
    }
    
    func logout() throws {
        try authDatasource.logout()
    }
}
