//
//  ContentView.swift
//  dragAndDrop
//
//  Created by win win on 22/04/24.
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

struct Th: Hashable {
    var color: Color
}

struct ContentView: View {
    @State var things = [
        Th(color: .random)
    ]
    
    var body: some View {
        ZStack {
            Button{
                things.append(Th(color: Color.random))
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(.bordered)
            if things.count > 0 {
                ForEach(things, id:\.self) { item in
                    ThingItem(color: item.color)
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        things.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
