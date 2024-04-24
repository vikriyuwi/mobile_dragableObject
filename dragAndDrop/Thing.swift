//
//  Thing.swift
//  dragAndDrop
//
//  Created by win win on 23/04/24.
//

import SwiftUI

struct ThingItem: View {
    var color: Color
    @Binding var loc: CGPoint
    var things: [Th]
    var index: Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .frame(width: 100, height: 100)
            .foregroundColor(color)
            .position(loc)
            .onAppear {
                           withAnimation(Animation.spring(duration: 1)) {
                               loc = CGPoint(x: UIScreen.main.bounds.size.width/2-(.random(in:0...100)), y: UIScreen.main.bounds.size.height/2-(.random(in:20...100)))
                           }
                       }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        loc = gesture.location
                        checkCollisions()
                    }
            )
    }
    
    func checkCollisions() {
        let thisRect = CGRect(origin: loc, size: CGSize(width: 100, height: 100))
        for i in 0..<things.count {
            if i != index {
                let otherRect = CGRect(origin: things[i].loc, size: CGSize(width: 100, height: 100))
                if thisRect.intersects(otherRect) {
                    // Collision detected
                    print("Collision detected between item \(index) and item \(i)")
                    // React to collision here
                }
            }
        }
    }
}

//#Preview {
//    ThingItem(color: .blue)
//}
