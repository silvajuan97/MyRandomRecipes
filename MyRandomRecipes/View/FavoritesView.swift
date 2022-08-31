//
//  FavoritesView.swift
//  MyRandomRecipes
//
//  Created by Juan Silva on 29/08/2022.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var recipeViewModel: RecipeViewModel
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Favorites Recipes")
            List(recipeViewModel.getFavoriteRecipes(email: authViewModel.user?.email ?? "")) { favorite in
                Text(favorite.nameMeal)
            }
        }
        .navigationTitle("Favorites Recipes")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(recipeViewModel: RecipeViewModel(),
                      authViewModel: AuthViewModel())
    }
}
