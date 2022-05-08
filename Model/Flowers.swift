import SwiftUI

struct FlowerProperties: Identifiable {
    let id: Int
    let color: Color
    let petals: [PetalProperties]
}

struct PetalProperties: Identifiable {
    let id = UUID()
    let color: Color
    let angle: Angle
    let xScale = CGFloat.random(in: 0.25...0.65)
    let yScale = CGFloat.random(in: 1.0...1.15)
}


