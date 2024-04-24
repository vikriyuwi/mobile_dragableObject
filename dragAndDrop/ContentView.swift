//
//  ContentView.swift
//  dragAndDropCollision
//
//  Created by Nadhif Rahman Alfan on 23/04/24.
//

import SwiftUI

extension Color {
    static var random: Color {
        return Color(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1)
        )
    }
}

struct ContentView: View {
    
    @State private var ingridients: [Ingridient] = [
        Ingridient(id: 1, name: "Rice", color: .random),
        Ingridient(id: 2, name: "Salmon", color: .random),
        Ingridient(id: 3, name: "Shrimp", color: .random),
        Ingridient(id: 4, name: "Tuna", color: .random),
    ]
    
//    @State private var droppedIngridients: [IngridientView] = []
    @State private var droppedIngridients: [Ingridient] = []
    
    var body: some View {
        ZStack {
            Button{
                let newIngridient = ingridients.randomElement()!
                
                droppedIngridients.append(
                    Ingridient(id: droppedIngridients.count, name: newIngridient.name, color: newIngridient.color)
                )

            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.bordered)
            if droppedIngridients.count > 0 {
                ForEach(droppedIngridients.indices, id: \.self) { index in
                    IngridientView(ingridient: $droppedIngridients[index], dropppedIngridients: $droppedIngridients)
                    //                    droppedIngridients[index]
//                        .onAppear {
//                            droppedIngridients[index].checkCollisions()
//                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
