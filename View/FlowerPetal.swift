import SwiftUI

struct FlowerPetal: View {
    let properties: PetalProperties
    var body: some View {
        Ellipse()
            .fill(properties.color)
            .scaleEffect(x: properties.xScale, y: properties.yScale)
            .rotationEffect(properties.angle)
    }
}

struct FlowerPetal_Previews: PreviewProvider {
    static var previews: some View {
        FlowerPetal(properties: PetalProperties(color: .teal, angle: .degrees(0)))
    }
}
