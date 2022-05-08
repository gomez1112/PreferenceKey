import SwiftUI

struct Bee: View {
    @State private var wingRotation: Double = 20
    var body: some View {
        GeometryReader { geo in
            beeBody(rect: geo.frame(in: .local))
                .anchorPreference(key: TargetPreferenceKey.self, value: .bounds) { anchor in
                    [Target(id: Target.beeID, anchor: anchor)]
                }
        }
        .onAppear { 
            wingRotation = 10
        }
    }
    
    private func beeBody(rect: CGRect) -> some View {
        ZStack {
            beeWingPath(rect: rect)
                .fill(.yellow)
                .rotationEffect(.degrees(wingRotation))
                .animation(.easeInOut(duration: 0.18).repeatForever(autoreverses: true), value: wingRotation)
            beeBodyPath(rect: rect)
                .fill(LinearGradient(colors: [.orange, .yellow], startPoint: .leading, endPoint: .trailing))
            
            beeBodyStripePath(rect: rect, radius: 15)
            beeBodyStripePath(rect: rect, radius: 25)
            
            beeBodyPath(rect: rect)
                .stroke(Color.orange, style: StrokeStyle(lineWidth: 4, lineJoin: .round))
            
            beeWingPath(rect: rect)
                .fill(.yellow)
                .rotationEffect(.degrees(-wingRotation))
                .animation(.easeInOut(duration: 0.15).repeatForever(autoreverses: true), value: wingRotation)
            beeFace(rect: rect)
        }
    }
    
    private func beeBodyPath(rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            
            path.addQuadCurve(to: CGPoint(x: rect.maxX * 0.91, y: rect.maxY * 0.4), control: CGPoint(x: rect.midX, y: rect.maxY * 0.1))
            
            path.addQuadCurve(to: CGPoint(x: rect.maxX * 0.91, y: rect.maxY * 0.6), control: CGPoint(x: rect.maxX * 1.04, y: rect.midY))
            
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.midY), control: CGPoint(x: rect.midX, y: rect.maxY * 0.9))
            
            path.closeSubpath()
        }
    }
    
    private func beeFace(rect: CGRect) -> some View {
        let width = 10.0
        let height = 10.0
        
        return ZStack {
            Path { path in 
                path.addEllipse(in: CGRect(origin: CGPoint(x: rect.maxX - width * 3.5, y: rect.midY - height), size: CGSize(width: width, height: height)))
            }
            .fill(Color.black.opacity(0.7))
            Path { path in 
                path.addEllipse(in: CGRect(origin: CGPoint(x: rect.maxX - width * 2.25, y: rect.midY - height), size: CGSize(width: width, height: height)))
            }
            .fill(Color.black.opacity(0.7))
        }
    }
    
    private func beeBodyStripePath(rect: CGRect, radius: CGFloat) -> some View {
        Path { path in
            path.addRelativeArc(center: CGPoint(x: rect.minX, y: rect.midY), radius: radius, startAngle: .degrees(320), delta: .degrees(80))
        }
        .stroke(Color.black.opacity(0.3), lineWidth: 4)
    }
    
    private func beeWingPath(rect: CGRect) -> Path {
        let width = rect.width * 0.4
        let height = rect.height * 0.6
        
        return Path { path in
            path.addEllipse(in: CGRect(origin: CGPoint(x: rect.midX - width / 2, y: rect.midY - height * 1.5), size: CGSize(width: width, height: height)))
        }
    }
}

struct Bee_Previews: PreviewProvider {
    static var previews: some View {
        Bee()
    }
}
