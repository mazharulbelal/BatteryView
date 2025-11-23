//
//  Theme.swift
//  BatteryView
//
//  Centralized, battery-specific theme palette used across the package.
//  Uses only Apple-native Color APIs (no custom initializers).
//

import SwiftUI

// MARK: - Battery Theme Palette (Concurrency-safe: immutable)

public enum BatteryTheme {
    public static let batteryThemeColor: Color = Color(
        .sRGB,
        red: 0.114,
        green: 0.569,
        blue: 0.290,
        opacity: 1.0
    )
    public static let batteryBackgroundColor: Color = Color.black.opacity(0.10)
    public static let batteryPrimaryTextColor: Color = .white
    public static let batteryWarningColor: Color = Color(
        .sRGB,
        red: 0.976,
        green: 0.659,
        blue: 0.145,
        opacity: 1.0
    )

    public static let batteryDangerColor: Color = Color(
        .sRGB,
        red: 0.827,
        green: 0.184,
        blue: 0.184,
        opacity: 1.0
    )
}

// MARK: - Color conveniences (aliases to keep current code compiling)

public extension Color {
    // Battery-specific convenience aliases used by the package
    static var batteryTheme: Color { BatteryTheme.batteryThemeColor }
    static var batteryBackground: Color { BatteryTheme.batteryBackgroundColor }
    static var batteryPrimaryText: Color { BatteryTheme.batteryPrimaryTextColor }
    static var batteryWarning: Color { BatteryTheme.batteryWarningColor }
    static var batteryDanger: Color { BatteryTheme.batteryDangerColor }

    // Backwards-compatibility for existing references in BatteryStyle.
    // You can update BatteryStyle to use the battery* names above and remove these.
    static var themeColor: Color { BatteryTheme.batteryThemeColor }
    static var primaryTextColor: Color { BatteryTheme.batteryPrimaryTextColor }
    static var secondaryBackgroundColor: Color { BatteryTheme.batteryBackgroundColor }
}

// MARK: - Spacing (used by BatteryDemoView)

public enum Spacing {
    public static let medium: CGFloat = 16
}
