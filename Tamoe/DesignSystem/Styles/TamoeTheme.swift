import SwiftUI

enum TamoeTheme {
    enum Colors {
        static let primaryText = Color(
            red: 72 / 255,
            green: 53 / 255,
            blue: 11 / 255
        )
        static let accent = Color(
            red: 190 / 255,
            green: 145 / 255,
            blue: 106 / 255
        )
        static let fieldBackground = Color(
            red: 231 / 255,
            green: 223 / 255,
            blue: 206 / 255
        )
        static let onAccent = Color.white
        static let pageBackground = accent.opacity(0.08)
        static let cardBackground = Color(uiColor: .systemBackground)
        static let border = primaryText.opacity(0.08)
        static let warning = Color.red
    }

    enum Typography {
        static let heroTitle = Font.system(.title, design: .serif, weight: .bold)
        static let pageTitle = Font.system(.title, design: .serif, weight: .bold)
        static let sectionTitle = Font.system(.title2, design: .serif, weight: .bold)
        static let cardTitle = Font.system(.headline, design: .serif, weight: .bold)
        static let metric = Font.system(.title3, design: .serif, weight: .bold)
        static let body = Font.system(.body, design: .serif, weight: .regular)
        static let emphasizedBody = Font.system(.body, design: .serif, weight: .semibold)
        static let label = Font.system(.subheadline, design: .serif, weight: .medium)
        static let caption = Font.system(.caption, design: .serif, weight: .regular)
        static let button = Font.system(.headline, design: .serif, weight: .semibold)

        static let modalTitle = Font.system(.headline, design: .serif, weight: .semibold)
        static let modalBody = Font.system(.body, design: .default, weight: .regular)
        static let modalLabel = Font.system(.subheadline, design: .default, weight: .medium)
        static let modalCaption = Font.system(.caption, design: .default, weight: .regular)
        static let modalButton = Font.system(.headline, design: .default, weight: .semibold)
    }

    enum Spacing {
        static let extraSmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }

    enum Radius {
        static let button: CGFloat = 14
        static let card: CGFloat = 20
        static let field: CGFloat = 12
    }

    enum Shadow {
        static let color = Color.black.opacity(0.08)
        static let radius: CGFloat = 12
        static let yOffset: CGFloat = 4
    }

    enum Size {
        static let minimumTapTarget: CGFloat = 44
    }
}
