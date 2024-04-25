import Foundation
import SwiftUI

struct MyIngredient: Identifiable {
    var id: UUID = UUID()
    var name : String
    var loc: CGPoint = CGPoint(x: UIScreen.main.bounds.size.width/2-60, y: -100)
    var user: String = "UAUA"
}
