//  BatteryStyle.swift
//  Created by Mazharul on 20/11/25.
//
import SwiftUI

struct BatteryStyle: Equatable {

    // MARK: - Theme
    enum Theme: String, CaseIterable, Equatable {
        case classic
        case neon
        case monochrome
        case highContrast
        case brand
    }

    // MARK: - General geometry
    var theme: Theme = .classic
    var cornerRadius: CGFloat = 18
    var borderWidth: CGFloat = 4
    var terminalWidth: CGFloat = 6
    var outerPadding: CGFloat = 4
    var innerPadding: CGFloat = 6
    var segments: Int = 5
    var segmentWidth: CGFloat = 3

    // MARK: - Colors (base palette)
    var segmentColor: Color = .white
    var emptyBackgroundColor: Color = Color.clear

    // Core palette used by classic/highContrast
    var green: Color = Color(hue: 0.35, saturation: 0.85, brightness: 0.75)
    var red: Color = Color(hue: 0.01, saturation: 0.75, brightness: 0.80)
    var yellow: Color = Color(hue: 0.12, saturation: 0.85, brightness: 0.85)
    var cyan: Color = Color(hue: 0.50, saturation: 0.45, brightness: 0.90)

    // Fixed border for “ok” state (native theme color)
    var fixedBorderGreen: Color = .themeColor

    // MARK: - Animation
    var animation: Animation = .spring(response: 0.45, dampingFraction: 0.85)
    func borderColor(for level: CGFloat) -> Color {
        switch theme {
        case .classic:
            if level <= 0.15 { return red }
            if level <= 0.35 { return yellow }
            return fixedBorderGreen

        case .neon:
            // Neon: low red neon, mid yellow neon, high cyan/green neon
            if level <= 0.15 { return Color(red: 1.0, green: 0.16, blue: 0.36) } // neon pinkish red
            if level <= 0.35 { return Color(red: 1.0, green: 0.84, blue: 0.0) }  // neon yellow
            return Color(red: 0.0, green: 1.0, blue: 0.6) // neon green/cyan

        case .monochrome:
            // grayscale border; darker as level drops
            let gray = 0.25 + 0.55 * Double(level) // 0.25..0.8
            return Color(white: gray)

        case .highContrast:
            // strong tri-state
            if level <= 0.15 { return .red }
            if level <= 0.35 { return .orange }
            return .green

        case .brand:
            // Use app themeColor as base border for most, warn on low
            if level <= 0.15 { return .batteryDanger } // danger red
            if level <= 0.35 { return .batteryWarning } // amber
            return .themeColor
        }
    }

    func gradient(for level: CGFloat) -> LinearGradient {
        switch theme {
        case .classic:
            let start = level <= 0.15 ? red : (level <= 0.35 ? yellow : cyan)
            let end   = level <= 0.15 ? red.opacity(0.8) : (level <= 0.35 ? yellow.opacity(0.9) : green)
            return LinearGradient(colors: [start, end], startPoint: .leading, endPoint: .trailing)

        case .neon:
            // Vivid neon gradient that shifts with level
            let start = level <= 0.15 ? Color(red: 1.0, green: 0.0, blue: 0.3)
                      : level <= 0.35 ? Color(red: 1.0, green: 0.8, blue: 0.0)
                      : Color(red: 0.0, green: 1.0, blue: 0.8)
            let end   = level <= 0.15 ? Color(red: 1.0, green: 0.3, blue: 0.5)
                      : level <= 0.35 ? Color(red: 1.0, green: 0.9, blue: 0.2)
                      : Color(red: 0.2, green: 1.0, blue: 0.6)
            return LinearGradient(colors: [start, end], startPoint: .leading, endPoint: .trailing)

        case .monochrome:
            // Single-color fill that scales with level
            let gray = 0.2 + 0.65 * Double(level) // 0.2..0.85
            let start = Color(white: gray)
            let end   = Color(white: min(gray + 0.1, 1.0))
            return LinearGradient(colors: [start, end], startPoint: .leading, endPoint: .trailing)

        case .highContrast:
            // Strong solid-like gradient
            let start: Color = level <= 0.15 ? .red : (level <= 0.35 ? .orange : .green)
            return LinearGradient(colors: [start, start.opacity(0.9)], startPoint: .leading, endPoint: .trailing)

        case .brand:
            // Use your app gradients where it makes sense
            if level <= 0.15 {
                let start = Color.batteryDanger
                return LinearGradient(colors: [start, start.opacity(0.9)], startPoint: .leading, endPoint: .trailing)
            } else if level <= 0.35 {
                let start = Color.batteryWarning
                return LinearGradient(colors: [start, start.opacity(0.9)], startPoint: .leading, endPoint: .trailing)
            } else {
                // Brand “ok” feel — use theme color
                return LinearGradient(colors: [.themeColor, .themeColor.opacity(0.95)], startPoint: .leading, endPoint: .trailing)
            }
        }
    }

     func boltColor(for level: CGFloat) -> Color {
        switch theme {
        case .classic:
            return borderColor(for: level)
        case .neon:
            return borderColor(for: level).opacity(0.95)
        case .monochrome:
            return level <= 0.15 ? .white : .black
        case .highContrast:
            return .white
        case .brand:
            return level <= 0.35 ? .white : .themeColor
        }
    }

    private func labelColor(for level: CGFloat) -> Color {
        switch theme {
        case .classic:
            return level <= 0.15 ? .white : .white
        case .neon:
            return .white
        case .monochrome:
            return level <= 0.5 ? .white : .black
        case .highContrast:
            return .white
        case .brand:
            return .primaryTextColor
        }
    }

    private func labelBackground(for level: CGFloat) -> Color {
        switch theme {
        case .classic:
            return borderColor(for: level)
        case .neon:
            return borderColor(for: level).opacity(0.6)
        case .monochrome:
            return Color(white: 0.1).opacity(0.8)
        case .highContrast:
            return borderColor(for: level)
        case .brand:
            return level <= 0.35 ? borderColor(for: level) : .secondaryBackgroundColor
        }
    }

    // MARK: - Presets
    static let `default` = BatteryStyle.classic

    static let classic: BatteryStyle = BatteryStyle(
        theme: .classic,
        cornerRadius: 18,
        borderWidth: 4,
        terminalWidth: 6,
        outerPadding: 4,
        innerPadding: 6,
        segments: 5,
        segmentWidth: 3,
        segmentColor: .white,
        emptyBackgroundColor: .clear,
        green: Color(hue: 0.35, saturation: 0.85, brightness: 0.75),
        red: Color(hue: 0.01, saturation: 0.75, brightness: 0.80),
        yellow: Color(hue: 0.12, saturation: 0.85, brightness: 0.85),
        cyan: Color(hue: 0.50, saturation: 0.45, brightness: 0.90),
        fixedBorderGreen: .themeColor,
        animation: .spring(response: 0.45, dampingFraction: 0.85)
    )

    static let neon: BatteryStyle = BatteryStyle(
        theme: .neon,
        cornerRadius: 16,
        borderWidth: 3,
        terminalWidth: 6,
        outerPadding: 4,
        innerPadding: 6,
        segments: 6,
        segmentWidth: 2,
        segmentColor: Color.white.opacity(0.8),
        emptyBackgroundColor: Color.black.opacity(0.15),
        green: .green, red: .red, yellow: .yellow, cyan: .cyan,
        fixedBorderGreen: Color(red: 0.0, green: 1.0, blue: 0.7),
        animation: .spring(response: 0.35, dampingFraction: 0.75)
    )

    static let monochrome: BatteryStyle = BatteryStyle(
        theme: .monochrome,
        cornerRadius: 14,
        borderWidth: 2.5,
        terminalWidth: 6,
        outerPadding: 4,
        innerPadding: 5,
        segments: 4,
        segmentWidth: 2,
        segmentColor: Color.white.opacity(0.6),
        emptyBackgroundColor: Color.black.opacity(0.05),
        green: .gray, red: .gray, yellow: .gray, cyan: .gray,
        fixedBorderGreen: .gray,
        animation: .easeInOut(duration: 0.25)
    )

    static let highContrast: BatteryStyle = BatteryStyle(
        theme: .highContrast,
        cornerRadius: 18,
        borderWidth: 5,
        terminalWidth: 7,
        outerPadding: 4,
        innerPadding: 6,
        segments: 5,
        segmentWidth: 3,
        segmentColor: Color.white.opacity(0.95),
        emptyBackgroundColor: Color.clear,
        green: .green, red: .red, yellow: .orange, cyan: .green,
        fixedBorderGreen: .green,
        animation: .spring(response: 0.4, dampingFraction: 0.85)
    )

    static let brand: BatteryStyle = BatteryStyle(
        theme: .brand,
        cornerRadius: 18,
        borderWidth: 4,
        terminalWidth: 6,
        outerPadding: 4,
        innerPadding: 6,
        segments: 5,
        segmentWidth: 3,
        segmentColor: Color.primaryTextColor.opacity(0.8),
        emptyBackgroundColor: Color.secondaryBackgroundColor.opacity(0.2),
        green: .themeColor,
        red: .batteryDanger,
        yellow: .batteryWarning,
        cyan: .themeColor,
        fixedBorderGreen: .themeColor,
        animation: .spring(response: 0.45, dampingFraction: 0.85)
    )
}
