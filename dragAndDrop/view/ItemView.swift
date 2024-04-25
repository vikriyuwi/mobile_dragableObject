import Foundation
import SwiftUI

struct ItemView: View {
    @State var zidx: Double
    @Binding var ingredient: MyIngredient
    @Binding var ingredients: [MyIngredient]
    @Binding var highestIdx: Double
    @State private var isAnimating: Bool = false
    @State private var isDraggingToTrash: Bool = false
    
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
            .transition(.scale)
            .animation(.spring())
            .scaleEffect(isDraggingToTrash ? 0.5 : 1, anchor: .center)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        isDraggingToTrash = isDraggingOverTrash(gesture.location)
                        ingredient.loc = gesture.location
                        if(zidx < highestIdx-1){
                            zidx = highestIdx
                            highestIdx += 1
                            print("idx: \(zidx)")
                            print("highest:  \(highestIdx)")
                        }
                    }
                    .onEnded ({ value in
                        if !isDraggingOverTrash(value.location) {
                            checkSide()
                            checkCollisions()
                            isDraggingToTrash = false
                        } else{
                            removeItem()
                        }
                    })
            )
    }
    
    func isDraggingOverTrash(_ location: CGPoint) -> Bool {
            let trashRect = CGRect(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - 50, width: 20, height: 20)
            let otherRect = CGRect(origin: location, size: CGSize(width: 10, height: 10))
            return trashRect.intersects(otherRect)
        }
    
    func hasMoreThanTwoWords(_ string: String) -> Bool {
        let words = string.split(separator: " ")
        return words.count >= 2
    }
    
    func checkSide() {
        if hasMoreThanTwoWords(ingredient.name){
            return
        }
        if ingredient.loc.x < 50{
            removeItemLeft()
        } else if ingredient.loc.x > UIScreen.main.bounds.size.width - 50{
            removeItemRight()
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
                    if (ingredient.name == "rice" && ingredients[i].name == "salmon") || (ingredient.name == "salmon" && ingredients[i].name == "rice") {
                        ingredient.name = "sushi salmon"
                        ingredients.removeAll(where: {
                            $0.id == ingredients[i].id
                        })
                        return
                    } else if (ingredient.name == "rice" && ingredients[i].name == "shrimp") || (ingredient.name == "shrimp" && ingredients[i].name == "rice"){
                        ingredient.name = "sushi shrimp"
                        ingredients.removeAll(where: {
                            $0.id == ingredients[i].id
                        })
                        return
                    } else if (ingredient.name == "rice" && ingredients[i].name == "tamago") || ingredient.name == "tamago" && ingredients[i].name == "rice" {
                        ingredient.name = "sushi tamago"
                        ingredients.removeAll(where: {
                            $0.id == ingredients[i].id
                        })
                        return
                    } else if (ingredient.name == "rice" && ingredients[i].name == "tuna") || ingredient.name == "tuna" && ingredients[i].name == "rice" {
                        ingredient.name = "sushi tuna"
                        ingredients.removeAll(where: {
                            $0.id == ingredients[i].id
                        })
                        return
                    }
                }
            }
        }
    }
    
    func removeItemLeft() {
        withAnimation(Animation.spring(duration: 1)) {
            ingredient.loc.x = -100
        } completion: {
            ingredients.removeAll(where: {
                $0.id == ingredient.id
            })
            print(ingredients)
        }
    }
    
    func removeItemRight() {
        withAnimation(Animation.spring(duration: 1)) {
            ingredient.loc.x = UIScreen.main.bounds.size.width + 100
        } completion: {
            ingredients.removeAll(where: {
                $0.id == ingredient.id
            })
            print(ingredients)
        }
    }
    
    func removeItem(){
        ingredients.removeAll(where: {
            $0.id == ingredient.id
        })
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
