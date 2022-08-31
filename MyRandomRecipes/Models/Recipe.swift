//
//  Recipe.swift
//  MyRandomRecipes
//
//  Created by Juan Silva on 25/08/2022.
//

import Foundation

class Recipe: Codable {
    let idMeal: String?
    let strMeal: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strYoutube: String?
    var strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5: String?
    var strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10: String?
    var strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15: String?
    var strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20: String?
    var strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5: String?
    var strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10: String?
    var strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15: String?
    var strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20: String?
    
    init(idMeal: String? = nil, strMeal: String? = nil, strInstructions: String? = nil, strMealThumb: String? = nil, strYoutube: String? = nil,
         strIngredient1: String? = nil, strIngredient2: String? = nil, strIngredient3: String? = nil, strIngredient4: String? = nil, strIngredient5: String? = nil,
         strIngredient6: String? = nil, strIngredient7: String? = nil, strIngredient8: String? = nil, strIngredient9: String? = nil, strIngredient10: String? = nil,
         strIngredient11: String? = nil, strIngredient12: String? = nil, strIngredient13: String? = nil, strIngredient14: String? = nil, strIngredient15: String? = nil,
         strIngredient16: String? = nil, strIngredient17: String? = nil, strIngredient18: String? = nil, strIngredient19: String? = nil, strIngredient20: String? = nil,
         strMeasure1: String? = nil, strMeasure2: String? = nil, strMeasure3: String? = nil, strMeasure4: String? = nil, strMeasure5: String? = nil,
         strMeasure6: String? = nil, strMeasure7: String? = nil, strMeasure8: String? = nil, strMeasure9: String? = nil, strMeasure10: String? = nil,
         strMeasure11: String? = nil, strMeasure12: String? = nil, strMeasure13: String? = nil, strMeasure14: String? = nil, strMeasure15: String? = nil,
         strMeasure16: String? = nil, strMeasure17: String? = nil, strMeasure18: String? = nil, strMeasure19: String? = nil, strMeasure20: String? = nil) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strInstructions = strInstructions
        self.strMealThumb = strMealThumb
        self.strYoutube = strYoutube
        self.strIngredient1 = strIngredient1
        self.strIngredient2 = strIngredient2
        self.strIngredient3 = strIngredient3
        self.strIngredient4 = strIngredient4
        self.strIngredient5 = strIngredient5
        self.strIngredient6 = strIngredient6
        self.strIngredient7 = strIngredient7
        self.strIngredient8 = strIngredient8
        self.strIngredient9 = strIngredient9
        self.strIngredient10 = strIngredient10
        self.strIngredient11 = strIngredient11
        self.strIngredient12 = strIngredient12
        self.strIngredient13 = strIngredient13
        self.strIngredient14 = strIngredient14
        self.strIngredient15 = strIngredient15
        self.strIngredient16 = strIngredient16
        self.strIngredient17 = strIngredient17
        self.strIngredient18 = strIngredient18
        self.strIngredient19 = strIngredient19
        self.strIngredient20 = strIngredient20
        self.strMeasure1 = strMeasure1
        self.strMeasure2 = strMeasure2
        self.strMeasure3 = strMeasure3
        self.strMeasure4 = strMeasure4
        self.strMeasure5 = strMeasure5
        self.strMeasure6 = strMeasure6
        self.strMeasure7 = strMeasure7
        self.strMeasure8 = strMeasure8
        self.strMeasure9 = strMeasure9
        self.strMeasure10 = strMeasure10
        self.strMeasure11 = strMeasure11
        self.strMeasure12 = strMeasure12
        self.strMeasure13 = strMeasure13
        self.strMeasure14 = strMeasure14
        self.strMeasure15 = strMeasure15
        self.strMeasure16 = strMeasure16
        self.strMeasure17 = strMeasure17
        self.strMeasure18 = strMeasure18
        self.strMeasure19 = strMeasure19
        self.strMeasure20 = strMeasure20
    }
}

class Ingredients: Codable, Identifiable {
    let ingredient, measure: String?
    
    init(ingredient: String?, measure: String?) {
        self.ingredient = ingredient
        self.measure = measure
    }
}

class Meal: ObservableObject {
    @Published var idMeal: String?
    @Published var strMeal: String?
    @Published var strInstructions: String?
    @Published var strMealThumb: String?
    @Published var strYoutube: String?
    @Published var ingredients: [Ingredients]?
    @Published var isFavorite: Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
    init(idMeal: String? = "",
         strMeal: String? = "",
         strInstructions: String? = "",
         strMealThumb: String? = "",
         strYoutube: String? = "",
         ingredients: [Ingredients] = [],
         isFavorite: Bool = false) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strInstructions = strInstructions
        self.strMealThumb = strMealThumb
        self.strYoutube = strYoutube
        self.ingredients = ingredients
        self.isFavorite = isFavorite
    }
}

class FavoritesRecipes: Codable, Identifiable {
    let idMeal: String
    let nameMeal: String
    
    init(idMeal: String,
         nameMeal: String) {
        self.idMeal = idMeal
        self.nameMeal = nameMeal
    }
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case nameMeal
    }
}
