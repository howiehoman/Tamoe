import SwiftUI

/// Presents Must-Invite, Maybe, and Optional pax totals in a fixed order.
struct PrioritySummary: View {
    /// Stores each event-specific priority total measured in pax.
    let priorityPax: [PriorityLevel: Int]

    /// Builds a three-column summary that becomes vertical at large text sizes.
    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .top, spacing: TamoeTheme.Spacing.medium) {
                ForEach(PriorityLevel.allCases) { priority in
                    priorityValue(for: priority)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            VStack(alignment: .leading, spacing: TamoeTheme.Spacing.medium) {
                ForEach(PriorityLevel.allCases) { priority in
                    priorityValue(for: priority)
                }
            }
        }
        .foregroundStyle(TamoeTheme.Colors.primaryText)
    }

    /// Builds one accessible label-and-number pair for a priority.
    ///
    /// - Parameter priority: The priority whose pax total should be displayed.
    /// - Returns: A vertically arranged priority name and number.
    private func priorityValue(for priority: PriorityLevel) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(priority.displayName)
                .font(TamoeTheme.Typography.body)

            Text("\(priorityPax[priority, default: 0])")
                .font(TamoeTheme.Typography.heroTitle)
                .monospacedDigit()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(priority.displayName)
        .accessibilityValue("\(priorityPax[priority, default: 0]) pax")
    }
}

#Preview("Priority summary") {
    PrioritySummary(
        priorityPax: [
            .mustInvite: 15,
            .maybe: 5,
            .optional: 5
        ]
    )
    .padding(TamoeTheme.Spacing.large)
}
