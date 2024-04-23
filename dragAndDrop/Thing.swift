//
//  Thing.swift
//  dragAndDrop
//
//  Created by win win on 23/04/24.
//

import SwiftUI

struct ThingItem: View {
    var color:Color
    
    @State var loc = CGPoint(x: UIScreen.main.bounds.size.width/2-50, y:0-100)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .frame(width: 100, height: 100)
            .foregroundColor(color)
//                .offset(x: offset.width + position.width, y: offset.height + position.height)
            .position(loc)
            .onAppear {
                withAnimation(Animation.spring(duration: 1)) {
                    loc = CGPoint(x: UIScreen.main.bounds.size.width/2-50, y: UIScreen.main.bounds.size.height/2)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged {state in
                        loc = state.location
//                        lastDragGesture = state
                    }
//                        .onEnded{value in
//                            let timediff = value.time.timeIntervalSince(self.lastDragGesture!.time)
//                            let speed = CGFloat(value.translation.height - self.lastDragGesture!.translation.height) / CGFloat(timediff)
//                            print(speed)
//                        }
//                    .updating($locState) {currentState, pastLocation, transaction in
//                        pastLocation = currentState.location
//                        transaction.animation = .spring
//                    }
            )
    }
}

#Preview {
    ThingItem(color: .blue)
}
