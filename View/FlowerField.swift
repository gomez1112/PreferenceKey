import SwiftUI

struct FlowerField: View {
    let onTap: Binding<Int>
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    @StateObject private var flowers = FlowersViewModel(count: 6)
    var body: some View {
        LazyVGrid(columns: columns) { 
            ForEach(flowers.properties) { model in
                Flower(onTap: onTap, properties: model)
                    .frame(width: 100, height: 100)
                    .padding()
            }
        }
    }
}

struct FlowerField_Previews: PreviewProvider {
    static var previews: some View {
        FlowerField(onTap: .constant(0))
    }
}
