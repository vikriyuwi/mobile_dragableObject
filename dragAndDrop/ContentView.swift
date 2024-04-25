//
//  ContentView.swift
//  LearningSushi
//
//  Created by win win on 24/04/24.
//

import SwiftUI

struct ContentView: View {
    @State var highestIdx = 1.0
    let defaults = UserDefaults.standard
    let ingredients = ["rice","salmon","shrimp","tamago", "tuna"]
    @State var myIngredients:[MyIngredient] = []
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            HStack {
                Button {
                    let newIngredient = MyIngredient(name: ingredients.randomElement()!)
                    myIngredients.append(newIngredient)
                    highestIdx+=1
                } label: {
                    Image(systemName: "plus")
                }
                .buttonStyle(.bordered)
                Button {
                    if myIngredients.count > 0 {
                        myIngredients.remove(at: .random(in: 0...myIngredients.count-1))
                    }
                } label: {
                    Image(systemName: "minus")
                }
                .buttonStyle(.bordered)
            }
            
            if myIngredients.count > 0 {
                ForEach($myIngredients) { ingredient in
                    ItemView(zidx: Double(highestIdx), ingredient: ingredient, ingredients: $myIngredients, highestIdx: $highestIdx)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
