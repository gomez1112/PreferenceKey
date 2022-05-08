import SwiftUI

struct Target: Equatable, Identifiable {
    static let hiveID = 999
    static let beeID = 100
    let id: Int
    let anchor: Anchor<CGRect>
}

struct TargetPreferenceKey: PreferenceKey {
    static var defaultValue: [Target] = []
    
    static func reduce(value: inout [Target], nextValue: () -> [Target]) {
        value.append(contentsOf: nextValue())
    }
}
