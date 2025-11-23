//  BatterySegmentsView.swift
//  Created by Mazharul on 23/11/25.
//
import SwiftUI

 struct BatterySegmentsView: View {
    let bodyRect: CGRect
    let corner: CGFloat
    let style: BatteryStyle

    var body: some View {
        Group {
            if style.segments > 1 {
                segmentDividers(in: bodyRect,
                                cornerRadius: corner,
                                count: style.segments,
                                lineWidth: style.segmentWidth)
                .stroke(style.segmentColor, lineWidth: style.segmentWidth)
            }
        }
    }

    private func segmentDividers(in rect: CGRect, cornerRadius: CGFloat, count: Int, lineWidth: CGFloat) -> some Shape {
        AnyShape(
            Path { p in
                let innerRect = rect.insetBy(dx: style.innerPadding, dy: style.innerPadding)
                let segmentWidth = innerRect.width / CGFloat(count)
                for i in 1..<count {
                    let x = innerRect.minX + CGFloat(i) * segmentWidth
                    p.move(to: CGPoint(x: x, y: innerRect.minY))
                    p.addLine(to: CGPoint(x: x, y: innerRect.maxY))
                }
            }
        )
    }
}
