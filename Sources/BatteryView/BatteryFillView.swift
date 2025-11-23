//  BatteryFillView.swift
//  Created by Mazharul on 23/11/25.
//
import SwiftUI
 struct BatteryFillView: View {
    let level: CGFloat
    let bodyRect: CGRect
    let corner: CGFloat
    let style: BatteryStyle

    var body: some View {
        Group {
            if level > 0 {
                let innerBodyRect = bodyRect.insetBy(dx: style.innerPadding, dy: style.innerPadding)
                let innerCorner = max(0, corner - style.innerPadding)
                let fillWidth = max(0, innerBodyRect.width * level)

                RoundedRectangle(cornerRadius: innerCorner)
                    .frame(width: fillWidth, height: innerBodyRect.height)
                    .position(x: innerBodyRect.minX + fillWidth / 2,
                              y: innerBodyRect.midY)
                    .foregroundStyle(style.gradient(for: level))
                    .mask(
                        RoundedRectangle(cornerRadius: innerCorner)
                            .path(in: innerBodyRect)
                    )
                    .animation(style.animation, value: level)
            }
        }
    }
}
