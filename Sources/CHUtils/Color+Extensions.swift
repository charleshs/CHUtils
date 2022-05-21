#if canImport(UIKit)
import UIKit
public typealias Color = UIColor
#else
import Cocoa
public typealias Color = NSColor
#endif

extension Color {
    /// [CHUtils] Returns a random color.
    public static func getRandom() -> Color {
        return Color(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1
        )
    }
}
