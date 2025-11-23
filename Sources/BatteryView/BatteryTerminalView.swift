//  BatteryTerminalView.swift
//  Created by Mazharul on 23/11/25.
//
import SwiftUI

 struct BatteryTerminalView: View {
    let level: CGFloat
    let terminalRect: CGRect
    let corner: CGFloat
    let style: BatteryStyle

    var body: some View {
        let innerTerminalRect = terminalRect.insetBy(dx: 0, dy: 0)
        let terminalCorner = min(innerTerminalRect.height / 2, corner)
        let terminalFill: LinearGradient = (level > 0.35)
        ? LinearGradient(colors: [style.fixedBorderGreen, style.fixedBorderGreen],
                         startPoint: .leading, endPoint: .trailing)
        : style.gradient(for: level)

        return AnyView(
            RoundedRectangle(cornerRadius: max(0, terminalCorner))
                .path(in: innerTerminalRect)
                .fill(terminalFill)
                .animation(style.animation, value: level)
        )
    }
}
