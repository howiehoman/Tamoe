import SwiftUI

/// Draws a reusable horizontal comparison between actual pax and a limit.
///
/// The view intentionally renders only the bar. Parent components can place
/// labels, ratios, and warnings in the positions required by their designs.
struct PaxProgressView: View {
    /// The true pax value represented by the filled portion of the bar.
    let actualPax: Int

    /// The quota or capacity used as the bar's comparison limit.
    let limitPax: Int

    /// Converts the true values into a safe visual fraction from zero to one.
    var fillFraction: Double {
        guard limitPax > 0 else { return 0 }

        let rawFraction = Double(actualPax) / Double(limitPax)
        return min(max(rawFraction, 0), 1)
    }

    /// Builds the neutral track and the clamped brown fill shown above totals.
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(TamoeTheme.Colors.progressTrack)

                Capsule()
                    .fill(TamoeTheme.Colors.progressFill)
                    .frame(width: geometry.size.width * fillFraction)
            }
        }
        .frame(height: TamoeTheme.Size.progressBarHeight)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Pax progress")
        .accessibilityValue(accessibilityValue)
    }

    /// Describes the real values without hiding overflow from VoiceOver users.
    private var accessibilityValue: String {
        let status = QuotaStatus(actualPax: actualPax, limitPax: limitPax)
        return "\(actualPax) of \(limitPax) pax, \(status.displayName)"
    }
}

#Preview("Pax progress states") {
    VStack(spacing: TamoeTheme.Spacing.large) {
        PaxProgressView(actualPax: 0, limitPax: 40)
        PaxProgressView(actualPax: 20, limitPax: 40)
        PaxProgressView(actualPax: 50, limitPax: 40)
    }
    .padding(TamoeTheme.Spacing.large)
}
