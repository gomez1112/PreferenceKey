import SwiftUI

struct Hive: View {
    let onTap: Binding<Int>
    private let id = Target.hiveID
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(LinearGradient(colors: [Color.black.opacity(0.2), Color.brown], startPoint: .top, endPoint: .bottom))
                    .frame(width: geo.size.width * 1.5, height: 20)
                    .offset(x: -20, y: 5)
                hivePath(rect: geo.frame(in: .local))
                    .fill(RadialGradient(colors: [Color.orange, .red], center: .top, startRadius: 20, endRadius: geo.size.width))
                
            }
            .anchorPreference(key: TargetPreferenceKey.self, value: .bounds) { anchor in
                [Target(id: id, anchor: anchor)]
            }
            .onTapGesture {
                onTap.wrappedValue = id
            }
        }
    }
    
    private func hivePath(rect: CGRect) -> Path {
        let margin = rect.width * 0.05
        return Path { path in
            path.move(to: CGPoint(x: rect.minX + margin, y: rect.minY + margin))
            
            path.addQuadCurve(to: CGPoint(x: rect.maxX - margin, y: rect.minY + margin), control: CGPoint(x: rect.midX, y: rect.maxY))
            
            path.addRelativeArc(center: CGPoint(x: rect.maxX - (margin * 2), y: rect.minY + margin), radius: margin, startAngle: .degrees(0), delta: .degrees(-90))
            
            path.addLine(to: CGPoint(x: rect.minX + (margin * 2), y: rect.minY))
            
            path.addRelativeArc(center: CGPoint(x: rect.minX + (margin * 2), y: rect.minY + margin), radius: margin, startAngle: .degrees(180), delta: .degrees(90))
            
            path.closeSubpath()
        }
    }
}

struct Hive_Previews: PreviewProvider {
    static var previews: some View {
        Hive(onTap: .constant(0))
    }
}
