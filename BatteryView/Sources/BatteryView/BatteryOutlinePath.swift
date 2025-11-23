//  BatteryOutlinePath.swift
//  Created by Mazharul on 23/11/25.
//
import SwiftUI

 struct BatteryOutlinePath: Shape {
    let bodyRect: CGRect
    let terminalWidth: CGFloat
    let terminalCorner: CGFloat
    let strokeInset: CGFloat
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let body = UIBezierPath(roundedRect: bodyRect, cornerRadius: min(bodyRect.height/2, terminalCorner*1.2))
        p.addPath(Path(body.cgPath))
        let tw = terminalWidth
        let termRect = CGRect(x: bodyRect.maxX,
                              y: bodyRect.midY - bodyRect.height * 0.25,
                              width: tw,
                              height: bodyRect.height * 0.5)
        let terminal = UIBezierPath(roundedRect: termRect, cornerRadius: terminalCorner)
        p.addPath(Path(terminal.cgPath))
        return p
    }
}

// MARK: - Type eraser for Shape

private struct AnyShape: Shape, @unchecked Sendable {
    private let pathClosure: @Sendable (CGRect) -> Path
    init<S: Shape>(_ shape: S) { self.pathClosure = shape.path(in:) }
    func path(in rect: CGRect) -> Path { pathClosure(rect) }
}
