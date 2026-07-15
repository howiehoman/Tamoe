import SwiftUI

/// Edits one guest's attendance details for one active wedding event.
struct GuestEventAssignmentSection: View {
    /// The read-only event name displayed at the top of the section.
    let eventName: String

    /// Connects the attendance toggle to the parent guest draft.
    @Binding var isAttending: Bool

    /// Lists the event-valid categories shown by the category menu.
    let categoryOptions: [CategorySelectionOption]

    /// Stores the selected category's stable identity in the parent draft.
    @Binding var selectedCategoryID: UUID?

    /// Stores the current event-specific priority in the parent draft.
    @Binding var selectedPriority: PriorityLevel?

    /// Stores the current event-specific household pax in the parent draft.
    @Binding var householdSize: Int

    /// Indicates whether at least one category makes attendance selectable.
    let isAvailable: Bool

    /// Lets the parent explain the missing category and offer a creation route.
    let onUnavailableTap: () -> Void

    /// Creates an event assignment section backed entirely by parent bindings.
    ///
    /// - Parameters:
    ///   - eventName: The stable event's current display name.
    ///   - isAttending: The draft attendance binding.
    ///   - categoryOptions: Categories enabled for this event.
    ///   - selectedCategoryID: The selected category identity binding.
    ///   - selectedPriority: The selected priority binding.
    ///   - householdSize: The household pax binding.
    ///   - isAvailable: Whether this event can be enabled.
    ///   - onUnavailableTap: The parent-owned explanation/routing action.
    init(
        eventName: String,
        isAttending: Binding<Bool>,
        categoryOptions: [CategorySelectionOption],
        selectedCategoryID: Binding<UUID?>,
        selectedPriority: Binding<PriorityLevel?>,
        householdSize: Binding<Int>,
        isAvailable: Bool,
        onUnavailableTap: @escaping () -> Void
    ) {
        self.eventName = eventName
        _isAttending = isAttending
        self.categoryOptions = categoryOptions
        _selectedCategoryID = selectedCategoryID
        _selectedPriority = selectedPriority
        _householdSize = householdSize
        self.isAvailable = isAvailable
        self.onUnavailableTap = onUnavailableTap
    }

    /// Builds a compact inactive row or the complete expanded assignment form.
    var body: some View {
        VStack(spacing: 0) {
            attendanceControl

            if isAttending, isAvailable {
                Divider()
                    .padding(.horizontal, TamoeTheme.Spacing.medium)

                categoryPicker

                Divider()
                    .padding(.horizontal, TamoeTheme.Spacing.medium)

                priorityPicker

                Divider()
                    .padding(.horizontal, TamoeTheme.Spacing.medium)

                PaxStepper(
                    label: "Household size",
                    value: $householdSize,
                    minimumValue: 1
                )
                .padding(.horizontal, TamoeTheme.Spacing.medium)
            }
        }
        .foregroundStyle(TamoeTheme.Colors.primaryText)
        .background(
            TamoeTheme.Colors.formSurface,
            in: RoundedRectangle(cornerRadius: TamoeTheme.Radius.card)
        )
    }

    /// Shows a normal toggle or a tappable unavailable-event explanation row.
    @ViewBuilder
    private var attendanceControl: some View {
        if isAvailable {
            Toggle(eventName, isOn: $isAttending)
                .font(TamoeTheme.Typography.modalBody)
                .tint(.green)
                .padding(TamoeTheme.Spacing.medium)
                .accessibilityHint(
                    isAttending
                        ? "Turns off this event assignment."
                        : "Adds assignment details for this event."
                )
        } else {
            Button(action: onUnavailableTap) {
                HStack(spacing: TamoeTheme.Spacing.medium) {
                    Text(eventName)
                        .font(TamoeTheme.Typography.modalBody)

                    Spacer()

                    Toggle("", isOn: .constant(false))
                        .labelsHidden()
                        .disabled(true)
                        .allowsHitTesting(false)
                }
                .padding(TamoeTheme.Spacing.medium)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(eventName)
            .accessibilityValue("Unavailable")
            .accessibilityHint("Double-tap to learn how to create a category.")
        }
    }

    /// Shows only categories that are valid for this event assignment.
    private var categoryPicker: some View {
        Menu {
            ForEach(categoryOptions) { option in
                Button {
                    selectedCategoryID = option.id
                } label: {
                    Text(option.name)
                        .foregroundStyle(option.color)
                }
            }
        } label: {
            menuRow(
                title: "Category",
                value: selectedCategory?.name ?? "Select a Category",
                valueColor: selectedCategory?.color ?? .secondary
            )
        }
        .accessibilityLabel("Category for \(eventName)")
        .accessibilityValue(selectedCategory?.name ?? "Not selected")
    }

    /// Shows the three locked priority choices from the domain enum.
    private var priorityPicker: some View {
        Menu {
            ForEach(PriorityLevel.allCases) { priority in
                Button(priority.displayName) {
                    selectedPriority = priority
                }
            }
        } label: {
            menuRow(
                title: "Priority Level",
                value: selectedPriority?.displayName ?? "Choose the Priority",
                valueColor: selectedPriority == nil
                    ? .secondary
                    : TamoeTheme.Colors.primaryText
            )
        }
        .accessibilityLabel("Priority for \(eventName)")
        .accessibilityValue(selectedPriority?.displayName ?? "Not selected")
    }

    /// Builds the repeated title, selected value, and menu chevron layout.
    private func menuRow(
        title: String,
        value: String,
        valueColor: Color
    ) -> some View {
        HStack(spacing: TamoeTheme.Spacing.small) {
            Text(title)
                .font(TamoeTheme.Typography.modalBody)
                .foregroundStyle(TamoeTheme.Colors.primaryText)

            Spacer(minLength: TamoeTheme.Spacing.small)

            Text(value)
                .font(TamoeTheme.Typography.modalBody)
                .foregroundStyle(valueColor)
                .multilineTextAlignment(.trailing)

            Image(systemName: "chevron.up.chevron.down")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(TamoeTheme.Spacing.medium)
        .contentShape(Rectangle())
    }

    /// Resolves the selected stable ID into its display option.
    private var selectedCategory: CategorySelectionOption? {
        categoryOptions.first { option in
            option.id == selectedCategoryID
        }
    }
}

#Preview("Guest event assignment") {
    @Previewable @State var isAttending = true
    @Previewable @State var selectedCategoryID: UUID?
    @Previewable @State var selectedPriority: PriorityLevel?
    @Previewable @State var householdSize = 2

    let brideCategory = CategorySelectionOption(
        id: UUID(),
        name: "Bride's",
        color: TamoeTheme.Colors.categoryPalette[0]
    )

    GuestEventAssignmentSection(
        eventName: "Holy Matrimony",
        isAttending: $isAttending,
        categoryOptions: [brideCategory],
        selectedCategoryID: $selectedCategoryID,
        selectedPriority: $selectedPriority,
        householdSize: $householdSize,
        isAvailable: true,
        onUnavailableTap: {}
    )
    .padding(TamoeTheme.Spacing.large)
}
