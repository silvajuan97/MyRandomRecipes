//
//  RecipeDetailView.swift
//  MyRandomRecipes
//
//  Created by Juan Silva on 26/08/2022.
//

import SwiftUI
import AVKit

struct RecipeDetailView: View {
    @StateObject var recipeViewModel = RecipeViewModel()
    @ObservedObject var authViewModel: AuthViewModel
    @State var showVideo: Int? = nil
    @ObservedObject var recipe = Meal()
    @StateObject var imageProvider = ImageProvider()
    
    var body: some View {
        ScrollView {
            VStack {
                Text(recipe.strMeal ?? "")
                    .underline()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: recipe.strMealThumb ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 200, alignment: .center)
                } else {
                    if let url = URL(string: recipe.strMealThumb ?? "") {
                        Image(uiImage: imageProvider.image)
                            .resizable()
                            .frame(width: 200, height: 200, alignment: .center)
                            .onAppear {
                                imageProvider.loadImage(url: url)
                            }
                    }
                }
                
                Text("Instructions")
                    .underline()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .padding()
                Text(recipe.strInstructions ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.body)
                    .padding(.horizontal)
                Text("Ingredients")
                    .underline()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .padding()
                ForEach(recipe.ingredients ?? [] ) { ingredient in
                    IngredientView(ingredient: ingredient.ingredient ?? "",
                                   measure: ingredient.measure ?? "")
                }.padding(.horizontal)
                
                VStack {
                    NavigationLink(destination: VideoView(videoUrl: recipe.strYoutube ?? ""),
                                   tag: 1,
                                   selection: $showVideo) {
                        Button(action: { self.showVideo = 1 },
                               label: { Text("Watch video") })
                        .padding()
                        .frame(maxWidth: .infinity, idealHeight: 50)
                        .foregroundColor(.black)
                        .background(Color(red: 0.89, green: 0.27, blue: 0.07))
                        .cornerRadius(8)
                    }
                    
                    if recipe.isFavorite {
                        Button(action: {
                            recipeViewModel.deleteFavoriteRecipe(recipe: recipe,
                                                                 email: authViewModel.user?.email ?? "")
                            recipe.isFavorite.toggle()
                        }, label: { Text("Remove from favorites")})
                        .padding()
                        .frame(maxWidth: .infinity, idealHeight: 50)
                        .foregroundColor(.black)
                        .background(Color.blue)
                        .cornerRadius(8)
                    } else {
                        Button(action: {
                            recipeViewModel.addFavoriteRecipe(recipe: recipe,
                                                              email: authViewModel.user?.email ?? "")
                            recipe.isFavorite.toggle()
                        }, label: { Text("Add to favorites")})
                        .padding()
                        .frame(maxWidth: .infinity, idealHeight: 50)
                        .foregroundColor(.black)
                        .background(Color.green)
                        .cornerRadius(8)
                    }
                    
                    Button(action: { recipeViewModel.getRandomRecipe(
                        success: { result in
                            recipe.idMeal = result?.idMeal
                            recipe.strMeal = result?.strMeal
                            recipe.strInstructions = result?.strInstructions
                            recipe.strMealThumb = result?.strMealThumb
                            recipe.strYoutube = result?.strYoutube
                            recipe.ingredients = result?.ingredients
                            recipe.isFavorite = result?.isFavorite ?? false
                        },
                        failure: { _ in }) },
                           label: { Text("See another recipe") })
                    .padding()
                    .frame(maxWidth: .infinity, idealHeight: 50)
                    .foregroundColor(.black)
                    .background(Color(red: 1.0, green: 0.7, blue: 0.0))
                    .cornerRadius(8)
                    
                    Button(action: {
                        authViewModel.logout()
                    }, label: { Text("Logout")})
                    .padding()
                    .frame(maxWidth: .infinity, idealHeight: 50)
                    .foregroundColor(.black)
                    .background(Color(red: 0.04, green: 0.73, blue: 0.84))
                    .cornerRadius(8)
                    
                }
                .padding([.leading, .bottom, .trailing])
                
            }
        }
        .navigationTitle("Recipe")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            NavigationLink(destination: FavoritesView(recipeViewModel: recipeViewModel,
                                                      authViewModel: authViewModel),
                           label: { Image(systemName: "star") })
        }
        .onAppear {
            recipeViewModel.getFavoriteRecipesDB(email: authViewModel.user?.email ?? "")
            if recipe.idMeal == "" {
                recipeViewModel.getRandomRecipe(
                    success: { result in
                        recipe.idMeal = result?.idMeal
                        recipe.strMeal = result?.strMeal
                        recipe.strInstructions = result?.strInstructions
                        recipe.strMealThumb = result?.strMealThumb
                        recipe.strYoutube = result?.strYoutube
                        recipe.ingredients = result?.ingredients
                        recipe.isFavorite = result?.isFavorite ?? false
                    },
                    failure: { _ in })
            }}
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(authViewModel: AuthViewModel())
    }
}
