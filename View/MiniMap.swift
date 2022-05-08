import SwiftUI

extension View {
    func miniMap(geo: GeometryProxy) -> some View {
        modifier(MiniMap(geo: geo))
    }
}

struct MiniMap: ViewModifier {
    let geo: GeometryProxy
    private let miniMapScale: CGFloat = 0.25
    func body(content: Content) -> some View {
        content
            .overlayPreferenceValue(TargetPreferenceKey.self) { mapTargets in
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .circular)
                        .stroke(.primary)
                    ForEach(mapTargets) { target in
                        let targetFrame = geo[target.anchor]
                        let mapTargetFrame = targetFrame.applying(CGAffineTransform(scaleX: miniMapScale, y: miniMapScale))
                        
                        switch target.id {
                        case Target.hiveID:
                            Image(systemName: "house.fill")
                                .foregroundColor(.purple)
                                .frame(width: mapTargetFrame.width, height: mapTargetFrame.height)
                                .position(x: mapTargetFrame.midX, y: mapTargetFrame.midY)
                        case Target.beeID:
                            Image(systemName: "circle.fill")
                                .foregroundColor(.orange)
                                .frame(width: mapTargetFrame.width, height: mapTargetFrame.height)
                                .position(x: mapTargetFrame.midX, y: mapTargetFrame.midY)
                        default:
                            Image(systemName: "seal.fill")
                                .foregroundColor(.yellow)
                                .frame(width: mapTargetFrame.width, height: mapTargetFrame.height)
                                .position(x: mapTargetFrame.midX, y: mapTargetFrame.midY)
                        }
                    }
                }
                .frame(width: geo.size.width * miniMapScale, height: geo.size.height * miniMapScale)
                .position(x: geo.size.width / 1.2, y: geo.size.height / 7)
            }
    }
}
