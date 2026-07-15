import Foundation

/// Chooses one of the two approved visual forms for a quota warning.
enum QuotaWarningPresentation: Sendable {
    /// Shows the actual and limit inside a compact tinted capsule.
    case compactRatio

    /// Shows a colored dot followed by the status text.
    case statusLabel
}
