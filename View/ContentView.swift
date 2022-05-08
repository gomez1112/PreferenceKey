import SwiftUI

struct ContentView: View {
    @State var targets: [Target] = []
    @State private var beePosition = CGPoint(x: 75, y: 100)
    @State private var selectedTargetID = -1
    
    private let miniMapScale: CGFloat = 0.25
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Hive(onTap: $selectedTargetID)
                        .frame(width: 150, height: 250)
                        .position(x: 75, y: geo.size.height * 0.3)
                    Spacer()
                    FlowerField(onTap: $selectedTargetID)
                }
                Bee()
                    .frame(width: 90, height: 115)
                    .position(beePosition)
                    .animation(beeMoveAnimation, value: beePosition)
            }
            .onChange(of: selectedTargetID) { newValue in
                guard let target = targets.first(where: { $0.id == newValue}) else { return }
                let targetFrame = geo[target.anchor]
                beePosition = CGPoint(x: targetFrame.midX, y: targetFrame.midY)
            }
            .onPreferenceChange(TargetPreferenceKey.self) { value in
                targets = value
            }
            .miniMap(geo: geo)
        }
    }
    
    var beeMoveAnimation: Animation {
        .spring(response: 1.5, dampingFraction: 0.455, blendDuration: 0)
    }
}
