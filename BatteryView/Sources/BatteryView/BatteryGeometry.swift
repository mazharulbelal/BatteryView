//  BatteryGeometry.swift
//  Created by Mazharul on 23/11/25.
//
import SwiftUI

 enum BatteryGeometry {
    static func level(from percentage: Int) -> CGFloat {
        let clamped = max(0, min(100, percentage))
        return CGFloat(clamped) / 100.0
    }

    static func bodyRect(in size: CGSize, style: BatteryStyle) -> CGRect {
        let bodyWidth = size.width - style.terminalWidth
        return CGRect(x: 0, y: 0, width: bodyWidth, height: size.height)
            .insetBy(dx: style.outerPadding, dy: style.outerPadding)
    }

    static func terminalRect(for bodyRect: CGRect, style: BatteryStyle) -> CGRect {
        CGRect(
            x: bodyRect.maxX,
            y: bodyRect.midY - bodyRect.height * 0.25,
            width: style.terminalWidth,
            height: bodyRect.height * 0.5
        )
    }

    static func cornerRadius(for bodyRect: CGRect, style: BatteryStyle) -> CGFloat {
        min(style.cornerRadius, min(bodyRect.height, bodyRect.width) / 2)
    }
}
