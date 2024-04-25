import Foundation
import SwiftUI

struct ItemView: View {
    @State var zidx: Double
    @Binding var ingredient: MyIngredient
    @Binding var ingredients: [MyIngredient]
    @Binding var highestIdx: Double
    
    var body: some View {
        Image(ingredient.name)
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .shadow(color: .shadow, radius: 0, x: 10, y: 10)
            .position(ingredient.loc)
            .zIndex(zidx)
            .onAppear {
                    withAnimation(Animation.spring(duration: 1)) {
                        ingredient.loc = CGPoint(x: UIScreen.main.bounds.size.width/2-60, y: UIScreen.main.bounds.size.height/2)
                           }
                       }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        ingredient.loc = gesture.location
                        if(zidx < highestIdx-1){
                            zidx = highestIdx
                            highestIdx += 1
                            print("idx: \(zidx)")
                            print("highest:  \(highestIdx)")
                        }
                    }
                    .onEnded ({ value in
                        checkCollisions()
                        checkLeftSide()
                    })
            )
    }
    
    func checkLeftSide() {
        if ingredient.loc.x < 10 {
            removeItemLeft()
        }
    }
    
    func checkCollisions() {
        
        let thisRect = CGRect(origin: ingredient.loc, size: CGSize(width: 150, height: 150))
        
        for i in 0..<ingredients.count {
            if ingredients[i].id != ingredient.id {
                let otherRect = CGRect(origin: ingredients[i].loc, size: CGSize(width: 100, height: 100))
                if thisRect.intersects(otherRect) {
                    // Collision detected
                    print("combine \(ingredient.name) and \(ingredients[i].name)")
                    
                    
                    // React to collision here
                }
            }
        }
        
    }
    
    func removeItemLeft() {
        withAnimation(Animation.spring(duration: 1)) {
            print(ingredient.loc)
            ingredient.loc.x = -100
        } completion: {
            ingredients.removeAll(where: {
                $0.id == ingredient.id
            })
        }
    }
    
}

#Preview {
    struct PreviewWrapper: View {
        @State var highestIdx = 1.0
        @State var ingredient: MyIngredient = MyIngredient(name: "rice")
        @State var ingredients: [MyIngredient] = [
            MyIngredient(name: "salmon")
        ]
        var body: some View {
            ItemView(zidx:1.0,ingredient: $ingredient, ingredients: $ingredients, highestIdx: $highestIdx)
        }
    }
    
    return PreviewWrapper()
}
