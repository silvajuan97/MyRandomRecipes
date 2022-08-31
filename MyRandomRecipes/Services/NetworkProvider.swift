//
//  NetworkProvider.swift
//  MyRandomRecipes
//
//  Created by Juan Silva on 25/08/2022.
//

import Foundation
import Alamofire

final class NetworkProvider {
    let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
    let randomRecipe = "random.php"
    let specificRecipe = "lookup.php?i="
    
    func getRandomRecipe(success: @escaping (Recipe?) -> Void,
                         failure: @escaping (Error?) -> Void) {
        let url = baseUrl + randomRecipe
        AF
            .request(url, method: .get, encoding:  URLEncoding.default)
            .validate()
            .responseDecodable(of: Meals.self) { response in
                
                switch response.result {
                case .success(let result):
                    success(result.meals.first)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func getRecipeById(id: String,
                       success: @escaping (Recipe?) -> Void,
                       failure: @escaping (Error?) -> Void) {
        let url = baseUrl + specificRecipe + id
        AF
            .request(url, method: .get, encoding:  URLEncoding.default)
            .validate()
            .responseDecodable(of: Meals.self) { response in
                switch response.result {
                case .success(let result):
                    success(result.meals.first)
                case .failure(let error):
                    failure(error)
                }
            }
    }
}
