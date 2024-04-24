//
//  Object.swift
//  dragAndDropCollision
//
//  Created by Nadhif Rahman Alfan on 23/04/24.
//

import Foundation
import SwiftUI

struct Ingridient: Hashable{
    var id : Int
    var name : String
    var color : Color
    var loc : CGPoint = CGPoint(x: 100, y: 100)
    
    // Implement hash(into:) method
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(color)
        hasher.combine(loc.x)
        hasher.combine(loc.y)
    }
}

struct IngridientView : View{
    @Binding var ingridient : Ingridient
    @Binding var dropppedIngridients : [Ingridient]

    var body : some View{
        VStack {
            Text(String(ingridient.id))
        }
        .frame(width: 100, height: 100)
        .background(ingridient.color)
        .cornerRadius(20)
        .position(ingridient.loc)
        .onAppear {
                withAnimation(Animation.spring(duration: 1)) {
                    ingridient.loc = CGPoint(x: UIScreen.main.bounds.size.width/2-(.random(in:0...100)), y: UIScreen.main.bounds.size.height/2-(.random(in:20...100)))
                       }
                   }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    ingridient.loc = gesture.location
                    checkCollisions()
                }
        )
    }
    
    func changeIngridient(newIngridient: Ingridient){
//        ingridient = newIngridient
    }
    
    func checkCollisions() {
        let thisRect = CGRect(origin: ingridient.loc, size: CGSize(width: 100, height: 100))
        for i in 0..<dropppedIngridients.count {
            if i != ingridient.id {
                let otherRect = CGRect(origin: dropppedIngridients[i].loc, size: CGSize(width: 100, height: 100))
                if thisRect.intersects(otherRect) {
                    // Collision detected
                    print("Collision detected between item \(ingridient.id) and item \(i)")
                    
                    
                    // React to collision here
                }
            }
        }
    }
    
    mutating func combinedIngridients(firstIndex: Int, secondIndex: Int){
//        let firstItem: IngridientView = dropppedIngridient[firstIndex]
//        let secondItem: IngridientView = dropppedIngridient[secondIndex]
//        if(isCombinedPossible(firstId: firstItem.ingridient.id, secondId: secondItem.ingridient.id)){
//            firstItem.changeIngridient(newIngridient: Hasil)
//        }
//
//        dropppedIngridient.remove(at: secondIndex)

    }
    
    func isCombinedPossible(firstId: Int, secondId: Int) -> Bool{
        
        return true
    }
}

