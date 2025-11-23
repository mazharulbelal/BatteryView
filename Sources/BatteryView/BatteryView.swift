
//  BatteryView.swift
//  Created by Mazharul on 20/11/25.
//

import AudioToolbox
import SwiftUI

public struct BatteryView: View {
    @Binding var percentage: Int
    var isCharging: Bool = false
    var height: CGFloat = 80
    var style: BatteryStyle = .highContrast

    public init(percentage: Binding<Int>,
                isCharging: Bool = false,
                style: BatteryStyle = .default) {
        self._percentage = percentage
        self.isCharging = isCharging
        self.style = style
    }

    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let level = BatteryGeometry.level(from: percentage)
            let bodyRect = BatteryGeometry.bodyRect(in: size, style: style)
            let terminalRect = BatteryGeometry.terminalRect(for: bodyRect, style: style)
            let corner = BatteryGeometry.cornerRadius(for: bodyRect, style: style)

            ZStack {
                BatteryContainerView(size: size, style: style)
                BatteryFillView(level: level, bodyRect: bodyRect, corner: corner, style: style)
                BatteryTerminalView(level: level, terminalRect: terminalRect, corner: corner, style: style)
                BatterySegmentsView(bodyRect: bodyRect, corner: corner, style: style)
                BatteryBoltView(isCharging: isCharging, level: level, size: size, style: style)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .aspectRatio(2.0, contentMode: .fit)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Battery"))
        .accessibilityValue(Text("\(percentage) percent"))
        .onAppear {
            percentage = min(100, max(0, percentage))
        }
        .onChange(of: percentage) { newValue in
            let clamped = min(100, max(0, newValue))
            if clamped != newValue {
                percentage = clamped
            }
        }
        .frame(height: height)
    }
}

struct BatteryDemoView: View {
    @State private var percentage: Int = 44
    var body: some View {
        VStack{
            BatteryView(percentage: $percentage)
            Text("\(percentage)")
        }
        .padding()
    }
}

#Preview {
    BatteryDemoView()
}
