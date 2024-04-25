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
    let ingredients = ["salmon","shrimp","tamago", "tuna"]
    @State var myIngredients:[MyIngredient] = []
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            VStack{
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
                Button {
                    let newIngredient = MyIngredient(name: "rice")
                    myIngredients.append(newIngredient)
                    highestIdx+=1
                } label: {
                    Text("Add Rice")
                }
                .buttonStyle(.bordered)
                Spacer()
            }
            .padding()
            Image(systemName: "trash")
                .font(.system(size: 40))
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - 50)
                .gesture(
                    DragGesture()
                        .onEnded { gesture in
                            let trashRect = CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - 50, width: 50, height: 50)
                            if trashRect.contains(gesture.location) {
                                myIngredients.removeAll()
                            }
                        }
            )
            
            
            
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
