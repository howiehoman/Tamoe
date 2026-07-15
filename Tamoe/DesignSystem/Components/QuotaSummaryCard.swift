import SwiftUI

/// Combines event quota status, allocation content, progress, and priorities.
///
/// `AllocationContent` keeps this component independent from the teammate-owned
/// `AllocationDonutChart`. The finished chart can be inserted without either
/// component knowing the other's implementation details.
struct QuotaSummaryCard<AllocationContent: View>: View {
    /// The card title, such as `All`.
    let title: String

    /// Optional context shown below the title, such as an event name.
    let subtitle: String?

    /// The true actual pax shown by the card.
    let actualPax: Int

    /// The event capacity or category quota shown by the card.
    let limitPax: Int

    /// Stores Must-Invite, Maybe, and Optional totals measured in pax.
    let priorityPax: [PriorityLevel: Int]

    /// Supplies chart information that a single-element button would otherwise hide.
    let allocationAccessibilitySummary: String

    /// Holds the view built by the teammate-owned allocation chart implementation.
    let allocationContent: AllocationContent

    /// Opens the detailed list represented by the card.
    let onTap: () -> Void

    /// Creates a complete quota summary while leaving chart drawing injectable.
    ///
    /// - Parameters:
    ///   - title: The card's primary title.
    ///   - subtitle: Optional event or scope context.
    ///   - actualPax: The true invited pax.
    ///   - limitPax: The capacity or quota.
    ///   - priorityPax: Event-scoped totals for all three priorities.
    ///   - allocationAccessibilitySummary: A spoken summary of chart segments.
    ///   - onTap: The card's navigation action.
    ///   - allocationContent: The injected allocation chart view.
    init(
        title: String,
        subtitle: String? = nil,
        actualPax: Int,
        limitPax: Int,
        priorityPax: [PriorityLevel: Int],
        allocationAccessibilitySummary: String,
        onTap: @escaping () -> Void,
        @ViewBuilder allocationContent: () -> AllocationContent
    ) {
        self.title = title
        self.subtitle = subtitle
        self.actualPax = actualPax
        self.limitPax = limitPax
        self.priorityPax = priorityPax
        self.allocationAccessibilitySummary = allocationAccessibilitySummary
        self.onTap = onTap
        self.allocationContent = allocationContent()
    }

    /// Builds one large accessible button matching the dashboard reference.
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: TamoeTheme.Spacing.large) {
                cardHeader

                allocationContent
                    .frame(maxWidth: .infinity)
                    .accessibilityHidden(true)

                progressSection

                PrioritySummary(priorityPax: priorityPax)
            }
            .padding(TamoeTheme.Spacing.large)
            .foregroundStyle(TamoeTheme.Colors.primaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                TamoeTheme.Colors.cardBackground,
                in: RoundedRectangle(cornerRadius: TamoeTheme.Radius.card)
            )
            .shadow(
                color: TamoeTheme.Shadow.color,
                radius: TamoeTheme.Shadow.radius,
                y: TamoeTheme.Shadow.yOffset
            )
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint("Opens the detailed guest list.")
    }

    /// Places scope context on the left and quota status on the right.
    private var cardHeader: some View {
        HStack(alignment: .top, spacing: TamoeTheme.Spacing.medium) {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(TamoeTheme.Typography.sectionTitle)

                if let subtitle {
                    Text(subtitle)
                        .font(TamoeTheme.Typography.body)
                }
            }

            Spacer(minLength: TamoeTheme.Spacing.small)

            VStack(alignment: .trailing, spacing: TamoeTheme.Spacing.extraSmall) {
                HStack(spacing: TamoeTheme.Spacing.small) {
                    Text("\(actualPax)/\(limitPax)")
                        .font(TamoeTheme.Typography.metric)
                        .monospacedDigit()

                    Image(systemName: "chevron.right")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                }

                QuotaWarningBadge(
                    actualPax: actualPax,
                    limitPax: limitPax,
                    scopeLabel: title,
                    presentation: .statusLabel
                )
            }
        }
    }

    /// Places the FILL label and true ratio above the reusable clamped bar.
    private var progressSection: some View {
        VStack(spacing: TamoeTheme.Spacing.small) {
            HStack {
                Text("Fill")
                    .font(TamoeTheme.Typography.emphasizedBody)
                    .textCase(.uppercase)

                Spacer()

                Text("\(actualPax)/\(limitPax)")
                    .font(TamoeTheme.Typography.body)
                    .monospacedDigit()
            }

            PaxProgressView(actualPax: actualPax, limitPax: limitPax)
        }
    }

    /// Combines visual metrics and the injected chart summary for VoiceOver.
    private var accessibilityLabel: String {
        let status = QuotaStatus(actualPax: actualPax, limitPax: limitPax)
        let subtitleText = subtitle.map { ", \($0)" } ?? ""
        let priorityText = PriorityLevel.allCases.map { priority in
            "\(priority.displayName) \(priorityPax[priority, default: 0]) pax"
        }
        .joined(separator: ", ")

        return "\(title)\(subtitleText), \(actualPax) of \(limitPax) pax, "
            + "\(status.displayName). \(allocationAccessibilitySummary). \(priorityText)."
    }
}

#Preview("Quota summary card") {
    QuotaSummaryCard(
        title: "ALL",
        subtitle: "Holy Matrimony",
        actualPax: 40,
        limitPax: 40,
        priorityPax: [
            .mustInvite: 20,
            .maybe: 10,
            .optional: 10
        ],
        allocationAccessibilitySummary: "Bride's 20 pax, Groom's 20 pax",
        onTap: {}
    ) {
        Circle()
            .stroke(TamoeTheme.Colors.progressTrack, lineWidth: 24)
            .frame(width: 220, height: 220)
            .overlay {
                Text("Allocations")
                    .font(TamoeTheme.Typography.cardTitle)
            }
    }
    .padding(TamoeTheme.Spacing.large)
    .background(TamoeTheme.Colors.pageBackground)
}
