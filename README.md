# BatteryView

A lightweight, customizable SwiftUI battery indicator view with multiple themes, smooth animations, accessibility, and charging state support. Distributed as a Swift Package for easy integration.

- Swift: 6.2
- Platforms: iOS 16+
- Package name: BatteryView
- Product: Library (BatteryView)

Screenshots
Place your screenshots under Docs/ and update paths below:
- Classic: Docs/default.png
- Neon: Docs/neon.png
- Monochrome: Docs/monochrome.png
- High Contrast: Docs/highContrast.png
- Brand: Docs/brand.png

Features
- SwiftUI battery indicator with percent fill
- Smooth animations (spring/ease)
- Multiple built-in themes via BatteryStyle:
  - classic, neon, monochrome, highContrast, brand
- Configurable geometry (corner radius, paddings, segments)
- Charging bolt overlay
- Accessibility labels and values
- iOS 16+ compatible


Installation (Swift Package Manager)
- In Xcode: File > Add Packages...
- Enter the repository URL of this package
- Add the library BatteryView to your target

Or in Package.swift of a client project:
dependencies: [
    .package(url: "https://github.com/your-org/BatteryView.git", from: "1.0.0")
]

targets: [
    .target(
        name: "YourApp",
        dependencies: ["BatteryView"]
    )
]

Quick Start
import SwiftUI
import BatteryView

struct ContentView: View {
    @State private var battery = 72
    var body: some View {
        VStack(spacing: 16) {
            BatteryView(
                percentage: $battery,
                isCharging: true,
                style: .classic
            )
            .frame(height: 80)

            Slider(value: Binding(
                get: { Double(battery) },
                set: { battery = Int($0) }
            ), in: 0...100)
        }
        .padding()
    }
}

API Overview

BatteryView
- percentage: Binding<Int> (0...100). Values are clamped automatically.
- isCharging: Bool (default false). Shows a bolt overlay when true.
- style: BatteryStyle (default .default which aliases .classic)
- Height can be constrained via .frame(height:).

BatteryStyle
- Themes: classic, neon, monochrome, highContrast, brand
- Geometry:
  - cornerRadius: CGFloat
  - borderWidth: CGFloat
  - terminalWidth: CGFloat
  - outerPadding: CGFloat
  - innerPadding: CGFloat
  - segments: Int (segment dividers)
  - segmentWidth: CGFloat
- Colors:
  - segmentColor
  - emptyBackgroundColor
  - green/red/yellow/cyan (base palette)
  - fixedBorderGreen (used for terminal at OK level)
- Animation:
  - animation: Animation

Built-in Presets
- .default
- .neon
- .monochrome
- .highContrast
- .brand
You can start with a preset and customize fields as needed.

Example: Changing Theme and Geometry
@State private var level = 44

var body: some View {
    VStack(spacing: 16) {
        BatteryView(percentage: $level, isCharging: false, style: .neon)
            .frame(height: 72)

        BatteryView(percentage: $level, isCharging: true, style: .highContrast)
            .frame(height: 64)

        let custom = BatteryStyle.highContrast
        var tuned = custom
        tuned.segments = 7
        tuned.segmentWidth = 2
        tuned.cornerRadius = 14

        BatteryView(percentage: $level, isCharging: true, style: tuned)
            .frame(height: 60)
    }
    .padding()
}
