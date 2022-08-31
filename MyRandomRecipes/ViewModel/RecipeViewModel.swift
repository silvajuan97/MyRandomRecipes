//
//  RecipeViewModel.swift
//  MyRandomRecipes
//
//  Created by Juan Silva on 26/08/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RecipeViewModel: ObservableObject {
    private let db = Firestore.firestore()
    private var favoritesRecipes = [FavoritesRecipes]()
    private var service = NetworkProvider()
    
    func getRandomRecipe(success: @escaping (Meal?) -> Void,
                         failure: @escaping (Error?) -> Void) {
        
        service.getRandomRecipe(success: { result in
            let meal = Meal(idMeal: result?.idMeal,
                            strMeal: result?.strMeal,
                            strInstructions: result?.strInstructions,
                            strMealThumb: result?.strMealThumb,
                            strYoutube: result?.strYoutube,
                            ingredients: self.getIngredientsArray(recipe: result),
                            isFavorite: self.favoritesRecipes.contains(where: { $0.idMeal == result?.idMeal }))
            success(meal)
        },
                                failure: { _ in })
        
        
    }
    
    func getRecipeById(id: String,
                       success: @escaping (Meal?) -> Void,
                       failure: @escaping (Error?) -> Void) {
        
        service.getRecipeById(id: id,
                              success: { result in
            let meal = Meal(idMeal: result?.idMeal,
                            strMeal: result?.strMeal,
                            strInstructions: result?.strInstructions,
                            strMealThumb: result?.strMealThumb,
                            strYoutube: result?.strYoutube,
                            ingredients: self.getIngredientsArray(recipe: result),
                            isFavorite: self.favoritesRecipes.contains(where: { $0.idMeal == result?.idMeal }))
            success(meal)
        },
                              failure: { _ in })
        
        
    }
    
    func getIngredientsArray(recipe: Recipe?) -> [Ingredients] {
        var ingredients = [Ingredients]()
        
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient1 ?? "", measure: recipe?.strMeasure1 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient2 ?? "", measure: recipe?.strMeasure2 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient3 ?? "", measure: recipe?.strMeasure3 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient4 ?? "", measure: recipe?.strMeasure4 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient5 ?? "", measure: recipe?.strMeasure5 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient6 ?? "", measure: recipe?.strMeasure6 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient7 ?? "", measure: recipe?.strMeasure7 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient8 ?? "", measure: recipe?.strMeasure8 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient9 ?? "", measure: recipe?.strMeasure9 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient10 ?? "", measure: recipe?.strMeasure10 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient11 ?? "", measure: recipe?.strMeasure11 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient12 ?? "", measure: recipe?.strMeasure12 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient13 ?? "", measure: recipe?.strMeasure13 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient14 ?? "", measure: recipe?.strMeasure14 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient15 ?? "", measure: recipe?.strMeasure15 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient16 ?? "", measure: recipe?.strMeasure16 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient17 ?? "", measure: recipe?.strMeasure17 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient18 ?? "", measure: recipe?.strMeasure18 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient19 ?? "", measure: recipe?.strMeasure19 ?? ""))
        ingredients.append(Ingredients(ingredient: recipe?.strIngredient20 ?? "", measure: recipe?.strMeasure20 ?? ""))
        
        let nonEmptyIngredients = ingredients.filter({
            $0.ingredient != ""
        })
        
        return nonEmptyIngredients
    }
    
    func addFavoriteRecipe(recipe: Meal?, email: String) {
        if let idMeal = recipe?.idMeal, let nameMeal = recipe?.strMeal {
            let favorite = FavoritesRecipes(idMeal: idMeal, nameMeal: nameMeal)
            favoritesRecipes.append(favorite)
            saveFavoritesDB(email: email)
        }
    }
    
    func deleteFavoriteRecipe(recipe: Meal?, email: String) {
        favoritesRecipes.removeAll(where: { $0.idMeal == recipe?.idMeal })
        saveFavoritesDB(email: email)
    }
    
    
    func saveFavoritesDB(email: String) {
        let data = ["Favorite": favoritesRecipes]
        do {
            try db.collection("Favorites").document(email).setData(from: data)
        } catch let error {
            print("Error writing to Firestore: \(error)")
        }
    }
    
    func getFavoriteRecipesDB(email: String) {
        if !email.isEmpty {
            let docRef = db.collection("Favorites").document(email)
            docRef.getDocument(as: [String: [FavoritesRecipes]].self) { result in
                switch result {
                case .success(let data):
                    self.favoritesRecipes = data["Favorite"] ?? [FavoritesRecipes]()
                case .failure(let error):
                    print("Error decoding: \(error)")
                }
            }
        }
    }
    
    func getFavoriteRecipes(email: String) -> [FavoritesRecipes] {
        if favoritesRecipes.isEmpty {
            getFavoriteRecipesDB(email: email)
        }
        return favoritesRecipes
    }
}
