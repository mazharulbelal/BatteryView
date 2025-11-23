//  Created by Mazharul on 23/11/25.
//
import SwiftUI

 struct BatteryContainerView: View {
    let size: CGSize
    let style: BatteryStyle

    var body: some View {
        let bodyRect = BatteryGeometry.bodyRect(in: size, style: style)
        let level: CGFloat = 1
        let corner = BatteryGeometry.cornerRadius(for: bodyRect, style: style)

        ZStack {
            batteryShape(in: size)
                .stroke(style.borderColor(for: level), lineWidth: style.borderWidth)
                .shadow(color: style.borderColor(for: level).opacity(0.15), radius: 2, y: 1)

            RoundedRectangle(cornerRadius: corner)
                .inset(by: style.borderWidth)
                .fill(style.emptyBackgroundColor)
        }
    }

    private func batteryShape(in size: CGSize) -> some Shape {
        let bodyRect = BatteryGeometry.bodyRect(in: size, style: style)
        let corner = BatteryGeometry.cornerRadius(for: bodyRect, style: style)
        return AnyShape(
            BatteryOutlinePath(bodyRect: bodyRect,
                               terminalWidth: style.terminalWidth,
                               terminalCorner: corner * 0.6,
                               strokeInset: style.borderWidth / 2)
        )
    }
}
