import SwiftUI

/// Collects the visual tokens shared by Tamoe's reusable SwiftUI views.
///
/// Keeping colors, fonts, spacing, and sizes in one place prevents individual
/// components from inventing slightly different versions of the same design.
enum TamoeTheme {
    /// Contains every shared color used by the current light appearance.
    enum Colors {
        /// The dark brown used for Tamoe's primary text and selected controls.
        static let primaryText = Color(
            red: 72 / 255,
            green: 53 / 255,
            blue: 11 / 255
        )

        /// The warm tan used for Tamoe's primary actions.
        static let accent = Color(
            red: 190 / 255,
            green: 145 / 255,
            blue: 106 / 255
        )

        /// The foreground color placed on the warm tan accent.
        static let onAccent = Color.white

        /// The lightly tinted background behind full app screens.
        static let pageBackground = accent.opacity(0.08)

        /// The white surface used by quota summary cards.
        static let cardBackground = Color(uiColor: .systemBackground)

        /// The cream surface used by Guest Cards.
        static let guestCardBackground = Color(
            red: 248 / 255,
            green: 245 / 255,
            blue: 238 / 255
        )

        /// The cream surface used by modal form sections and compact controls.
        static let formSurface = Color(
            red: 237 / 255,
            green: 227 / 255,
            blue: 207 / 255
        )

        /// The neutral surface behind a category name inside a Guest Card.
        static let categoryChipBackground = Color.black.opacity(0.07)

        /// The neutral line used for unselected borders and dividers.
        static let border = primaryText.opacity(0.08)

        /// The neutral outline used by selectable circular controls.
        static let selectionOutline = Color(uiColor: .systemGray3)

        /// The unfilled portion of a pax progress bar.
        static let progressTrack = Color(uiColor: .systemGray5)

        /// The filled portion of a pax progress bar.
        static let progressFill = primaryText

        /// The status color for values that are at or below their limit.
        static let onTrack = Color.green

        /// The status color for values that exceed their limit.
        static let warning = Color.red

        /// The priority color supplied for Must-Invite guests.
        static let mustInvitePriority = Color(
            red: 164 / 255,
            green: 75 / 255,
            blue: 75 / 255
        )

        /// The priority color supplied for Maybe guests.
        static let maybePriority = Color(
            red: 220 / 255,
            green: 173 / 255,
            blue: 85 / 255
        )

        /// The priority color supplied for Optional guests.
        static let optionalPriority = Color(
            red: 254 / 255,
            green: 253 / 255,
            blue: 248 / 255
        )

        /// Temporary category text colors, stored in one replaceable array.
        ///
        /// Replace these twelve entries, in order, when the final palette is
        /// available. Each temporary value passes a 4.5:1 contrast ratio on
        /// Tamoe's light cream and white card surfaces.
        static let categoryPalette: [Color] = [
            Color(red: 122 / 255, green: 31 / 255, blue: 31 / 255),   // Temporary category 1: burgundy.
            Color(red: 122 / 255, green: 62 / 255, blue: 0 / 255),    // Temporary category 2: dark amber.
            Color(red: 101 / 255, green: 87 / 255, blue: 0 / 255),    // Temporary category 3: dark olive.
            Color(red: 31 / 255, green: 107 / 255, blue: 58 / 255),   // Temporary category 4: forest green.
            Color(red: 0 / 255, green: 107 / 255, blue: 104 / 255),   // Temporary category 5: dark teal.
            Color(red: 7 / 255, green: 90 / 255, blue: 120 / 255),    // Temporary category 6: deep cyan.
            Color(red: 36 / 255, green: 78 / 255, blue: 145 / 255),   // Temporary category 7: dark blue.
            Color(red: 73 / 255, green: 58 / 255, blue: 138 / 255),   // Temporary category 8: indigo.
            Color(red: 106 / 255, green: 44 / 255, blue: 130 / 255),  // Temporary category 9: purple.
            Color(red: 129 / 255, green: 44 / 255, blue: 94 / 255),   // Temporary category 10: plum.
            Color(red: 139 / 255, green: 51 / 255, blue: 71 / 255),   // Temporary category 11: rose.
            Color(red: 75 / 255, green: 85 / 255, blue: 99 / 255)     // Temporary category 12: slate.
        ]

        /// Returns the visual color for a priority without putting UI concerns
        /// inside the pure `PriorityLevel` domain type.
        static func priorityColor(for priority: PriorityLevel) -> Color {
            switch priority {
            case .mustInvite:
                mustInvitePriority
            case .maybe:
                maybePriority
            case .optional:
                optionalPriority
            }
        }

        // TODO: Dark Mode support is optional for this component milestone.
        // Replace the temporary light-only surfaces with approved adaptive
        // values before claiming the Section 16 Dark Mode acceptance criteria.
    }

    /// Contains semantic Dynamic Type fonts used by Tamoe.
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

    /// Contains the shared spacing scale used between and inside components.
    enum Spacing {
        static let extraSmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }

    /// Contains shared rounded-corner values.
    enum Radius {
        static let button: CGFloat = 14
        static let card: CGFloat = 20
        static let compactControl: CGFloat = 12
    }

    /// Contains the shared shadow treatment for elevated surfaces.
    enum Shadow {
        static let color = Color.black.opacity(0.08)
        static let radius: CGFloat = 12
        static let yOffset: CGFloat = 4
    }

    /// Contains reusable dimensions that are not spacing values.
    enum Size {
        static let minimumTapTarget: CGFloat = 44
        static let guestCardPriorityStripeWidth: CGFloat = 12
        static let progressBarHeight: CGFloat = 8
    }
}
