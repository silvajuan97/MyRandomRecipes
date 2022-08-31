//
//  Meals.swift
//  MyRandomRecipes
//
//  Created by Juan Silva on 25/08/2022.
//

import Foundation

class Meals: ObservableObject, Decodable {
    var meals = [Recipe]()
}
