import SwiftUI

/// Communicates whether an actual pax value is within its quota or capacity.
struct QuotaWarningBadge: View {
    /// The true actual pax value; overflow is never visually hidden.
    let actualPax: Int

    /// The quota or capacity against which actual pax is compared.
    let limitPax: Int

    /// The event or category name included in the VoiceOver description.
    let scopeLabel: String

    /// Chooses the compact-ratio or status-label visual presentation.
    let presentation: QuotaWarningPresentation

    /// Derives one shared status so both presentations always agree.
    private var status: QuotaStatus {
        QuotaStatus(actualPax: actualPax, limitPax: limitPax)
    }

    /// Chooses the semantic foreground color for the derived status.
    private var statusColor: Color {
        status == .overCapacity
            ? TamoeTheme.Colors.warning
            : TamoeTheme.Colors.onTrack
    }

    /// Builds exactly one of the approved warning presentations.
    @ViewBuilder
    var body: some View {
        switch presentation {
        case .compactRatio:
            compactRatio
        case .statusLabel:
            statusLabel
        }
    }

    /// Shows true actual/limit values and an explicit overflow icon when needed.
    private var compactRatio: some View {
        HStack(spacing: TamoeTheme.Spacing.small) {
            if status == .overCapacity {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(statusColor)
                    .accessibilityHidden(true)
            }

            Text("\(actualPax)/\(limitPax)")
                .font(TamoeTheme.Typography.label)
                .monospacedDigit()
                .foregroundStyle(Color.white)
                .padding(.horizontal, TamoeTheme.Spacing.medium)
                .frame(minHeight: TamoeTheme.Size.minimumTapTarget)
                // The solid fill matches the reference; glass adds its bright edge.
                .background(statusColor, in: Capsule())
                .glassEffect(
                    .regular.tint(statusColor),
                    in: Capsule()
                )
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityDescription)
    }

    /// Shows a colored dot plus status text so color is never the only signal.
    private var statusLabel: some View {
        HStack(spacing: TamoeTheme.Spacing.small) {
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)
                .accessibilityHidden(true)

            Text(status.displayName)
                .font(TamoeTheme.Typography.body)
                .foregroundStyle(TamoeTheme.Colors.primaryText)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityDescription)
    }

    /// Provides the same complete meaning for both visible presentations.
    private var accessibilityDescription: String {
        "\(scopeLabel), \(actualPax) of \(limitPax) pax, \(status.displayName)"
    }
}

#Preview("Quota warning presentations") {
    VStack(spacing: TamoeTheme.Spacing.large) {
        QuotaWarningBadge(
            actualPax: 40,
            limitPax: 40,
            scopeLabel: "Reception",
            presentation: .compactRatio
        )

        QuotaWarningBadge(
            actualPax: 50,
            limitPax: 40,
            scopeLabel: "Reception",
            presentation: .compactRatio
        )

        QuotaWarningBadge(
            actualPax: 25,
            limitPax: 20,
            scopeLabel: "Bride's category",
            presentation: .statusLabel
        )
    }
    .padding(TamoeTheme.Spacing.large)
}
