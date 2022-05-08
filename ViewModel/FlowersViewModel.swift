import SwiftUI

@MainActor
final class FlowersViewModel: ObservableObject {
    static private  let allColors: [Color] = [.red, .blue, .pink, .orange, .purple, .green, .teal, .mint, .cyan, .indigo]
    
    @Published var properties: [FlowerProperties]
    
    init(count: Int) {
        let colors = FlowersViewModel.allColors.shuffled().prefix(count)
        
        properties = colors.enumerated().map { index, color in
            let petalProperties: [PetalProperties] = (0..<4).map { i in 
                let angle = Angle.degrees((Double(i) / 4.0) * 180)
                return PetalProperties(color: color, angle: angle)
            }
            return FlowerProperties(id: index, color: color, petals: petalProperties)
        }
    }
}
