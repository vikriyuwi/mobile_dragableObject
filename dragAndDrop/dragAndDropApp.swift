//
//  dragAndDropApp.swift
//  dragAndDrop
//
//  Created by win win on 22/04/24.
//

import SwiftUI
import SwiftData

@main
struct dragAndDropApp: App {
    let myCard: ModelContainer = {
        let schema = Schema([UnoCard.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(myCard)
    }
}
