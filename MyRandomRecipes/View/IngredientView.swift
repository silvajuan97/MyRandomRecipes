//
//  IngredientView.swift
//  MyRandomRecipes
//
//  Created by Juan Silva on 26/08/2022.
//

import SwiftUI

struct IngredientView: View {
    var ingredient: String
    var measure: String
    
    var body: some View {
        HStack {
            Text(ingredient)
                .padding()
                .frame(minWidth: 0,
                       idealWidth: 199.5,
                       maxWidth: .infinity)
            Divider()
            Text(measure)
                .padding()
                .frame(minWidth: 0,
                       idealWidth: 199.5,
                       maxWidth: .infinity)
        }.border(.black)
    }
}

struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView(ingredient: String(),
                       measure: String())
        .previewLayout(.fixed(width: 400, height: 50))
    }
}
