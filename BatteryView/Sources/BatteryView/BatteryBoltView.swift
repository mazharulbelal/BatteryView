//  BatteryBoltView.swift
//  GlafitES
//
//  Created by Mazharul on 23/11/25.
//
import SwiftUI

 struct BatteryBoltView: View {
    let isCharging: Bool
    let level: CGFloat
    let size: CGSize
    let style: BatteryStyle

    var body: some View {
        Group {
            if isCharging {
                Image(systemName: "bolt.fill")
                    .rotationEffect(.degrees(45))
                    .font(.system(size: min(size.height, size.width) * 0.25, weight: .bold))
                    .foregroundStyle(style.boltColor(for: level))
                    .shadow(color: .black.opacity(0.15), radius: 2, y: 1)
                    .transition(.scale.combined(with: .opacity))
            }
        }
    }
}
