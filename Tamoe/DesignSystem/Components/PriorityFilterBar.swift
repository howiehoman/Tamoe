import SwiftUI

/// Lets users filter one event-scoped guest list by assignment priority.
struct PriorityFilterBar: View {
    /// Connects the selected filter to state owned by the detailed-list parent.
    @Binding var selectedFilter: PriorityFilter

    /// Stores the visible pax result count for each concrete priority.
    let priorityPax: [PriorityLevel: Int]

    /// Builds a horizontally scrollable row that remains usable with large text.
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: TamoeTheme.Spacing.small) {
                ForEach(PriorityFilter.allCases) { filter in
                    filterButton(for: filter)
                }
            }
            .padding(.vertical, 1)
        }
        .scrollIndicators(.hidden)
    }

    /// Builds one selected or unselected filter button.
    ///
    /// - Parameter filter: The filter represented by this button.
    /// - Returns: A minimum-size accessible capsule button.
    private func filterButton(for filter: PriorityFilter) -> some View {
        let isSelected = selectedFilter == filter
        let resultPax = paxCount(for: filter)

        return Button {
            selectedFilter = filter
        } label: {
            Text(visibleLabel(for: filter))
                .font(TamoeTheme.Typography.caption)
                .lineLimit(1)
                .padding(.horizontal, TamoeTheme.Spacing.medium)
                .frame(minHeight: TamoeTheme.Size.minimumTapTarget)
                .foregroundStyle(
                    isSelected
                        ? TamoeTheme.Colors.onAccent
                        : TamoeTheme.Colors.primaryText
                )
                // Every visible filter button uses the native iOS 26 glass material.
                .glassEffect(
                    .regular
                        .tint(
                            isSelected
                                ? TamoeTheme.Colors.primaryText
                                : TamoeTheme.Colors.cardBackground
                        )
                        .interactive(),
                    in: Capsule()
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(filter.displayName)
        .accessibilityValue("\(resultPax) pax")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    /// Creates the visual filter label shown in the screenshots.
    private func visibleLabel(for filter: PriorityFilter) -> String {
        guard filter != .all else { return filter.displayName }
        return "\(filter.displayName) (\(paxCount(for: filter)))"
    }

    /// Returns the pax count for one filter, including the computed All total.
    private func paxCount(for filter: PriorityFilter) -> Int {
        guard let priority = filter.priority else {
            return PriorityLevel.allCases.reduce(0) { partialResult, priority in
                partialResult + priorityPax[priority, default: 0]
            }
        }

        return priorityPax[priority, default: 0]
    }
}

#Preview("Priority filters") {
    @Previewable @State var selectedFilter = PriorityFilter.all

    PriorityFilterBar(
        selectedFilter: $selectedFilter,
        priorityPax: [
            .mustInvite: 20,
            .maybe: 10,
            .optional: 20
        ]
    )
    .padding(TamoeTheme.Spacing.large)
}
