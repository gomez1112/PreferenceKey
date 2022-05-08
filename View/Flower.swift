import SwiftUI

struct Flower: View {
    let onTap: Binding<Int>
    let id: Int
    let color: Color
    let petals: [PetalProperties]
    
    init(onTap: Binding<Int>, properties: FlowerProperties) {
        self.onTap = onTap
        self.id = properties.id
        self.color = properties.color
        self.petals = properties.petals
    }
    var body: some View {
        ZStack {
            ForEach(petals) {
                FlowerPetal(properties: $0)
            }
            Circle()
                .fill(Color.yellow)
                .scaleEffect(0.25)
        }
        .onTapGesture {
            onTap.wrappedValue = id
        }
        .anchorPreference(key: TargetPreferenceKey.self, value: .bounds) { anchor in
            [Target(id: id, anchor: anchor)]
        }
    }
}

struct Flower_Previews: PreviewProvider {
    static var previews: some View {
        let flowers = FlowersViewModel(count: 10)
        VStack {
            Flower(onTap: .constant(0), properties: flowers.properties[0])
                .frame(width: 150, height: 150)
            Flower(onTap: .constant(0), properties: flowers.properties[1])
                .frame(width: 150, height: 150)
            Flower(onTap: .constant(0), properties: flowers.properties[2])
                .frame(width: 150, height: 150)
            Flower(onTap: .constant(0), properties: flowers.properties[3])
                .frame(width: 150, height: 150)
        }
    }
}
