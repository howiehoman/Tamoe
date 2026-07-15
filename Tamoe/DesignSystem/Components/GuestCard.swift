import SwiftUI

/// Displays one guest's information for the currently viewed wedding event.
///
/// The parent ViewModel supplies event names in display order: the current
/// event first, followed by the remaining events in saved slot order.
struct GuestCard: View {
    /// The guest's global display name.
    let guestName: String

    /// The already ordered names of every event this guest is joining.
    let orderedEventNames: [String]

    /// The category assigned to this guest in the current event.
    let categoryName: String

    /// The approved palette color for the current category's name.
    let categoryColor: Color

    /// The household pax assigned to this guest in the current event.
    let householdSize: Int

    /// The guest's priority in the current event.
    let priority: PriorityLevel

    /// Controls whether a selection checkbox appears beside the card.
    let isSelectionMode: Bool

    /// Controls the checkbox's selected appearance.
    let isSelected: Bool

    /// Runs when the card is tapped outside selection mode.
    let onTap: () -> Void

    /// Runs when the row is tapped while selection mode is active.
    let onSelectionToggle: () -> Void

    /// Creates a Guest Card from display-ready values and parent-owned actions.
    ///
    /// - Parameters:
    ///   - guestName: The guest's global name.
    ///   - orderedEventNames: Current event first, then saved event-slot order.
    ///   - categoryName: The category for the current event.
    ///   - categoryColor: The category's assigned palette color.
    ///   - householdSize: Current-event household pax.
    ///   - priority: Current-event priority.
    ///   - isSelectionMode: Whether selection behavior is active.
    ///   - isSelected: Whether this guest is currently selected.
    ///   - onTap: The normal navigation action.
    ///   - onSelectionToggle: The selection-mode toggle action.
    init(
        guestName: String,
        orderedEventNames: [String],
        categoryName: String,
        categoryColor: Color,
        householdSize: Int,
        priority: PriorityLevel,
        isSelectionMode: Bool = false,
        isSelected: Bool = false,
        onTap: @escaping () -> Void,
        onSelectionToggle: @escaping () -> Void = {}
    ) {
        self.guestName = guestName
        self.orderedEventNames = orderedEventNames
        self.categoryName = categoryName
        self.categoryColor = categoryColor
        self.householdSize = householdSize
        self.priority = priority
        self.isSelectionMode = isSelectionMode
        self.isSelected = isSelected
        self.onTap = onTap
        self.onSelectionToggle = onSelectionToggle
    }

    /// Builds a selectable row or a normal navigable Guest Card.
    var body: some View {
        Button(action: handleTap) {
            HStack(spacing: TamoeTheme.Spacing.small) {
                if isSelectionMode {
                    selectionIndicator
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }

                cardSurface
            }
            .animation(.easeInOut(duration: 0.2), value: isSelectionMode)
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    /// Shows the approved brown circle and white checkmark when selected.
    private var selectionIndicator: some View {
        ZStack {
            Circle()
                .fill(
                    isSelected
                        ? TamoeTheme.Colors.primaryText
                        : Color.clear
                )

            Circle()
                .stroke(
                    isSelected
                        ? TamoeTheme.Colors.primaryText
                        : TamoeTheme.Colors.selectionOutline,
                    lineWidth: 2
                )

            if isSelected {
                Image(systemName: "checkmark")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(Color.white)
            }
        }
        .frame(width: 24, height: 24)
        .frame(
            width: TamoeTheme.Size.minimumTapTarget,
            height: TamoeTheme.Size.minimumTapTarget
        )
        .accessibilityHidden(true)
    }

    /// Draws the cream card, priority stripe, content, and subtle shadow.
    private var cardSurface: some View {
        ViewThatFits(in: .horizontal) {
            horizontalContent
            verticalContent
        }
        // The leading padding reserves room for the overlaid priority stripe.
        .padding(
            .leading,
            TamoeTheme.Size.guestCardPriorityStripeWidth
                + TamoeTheme.Spacing.medium
        )
        .padding(.trailing, TamoeTheme.Spacing.medium)
        .padding(.vertical, TamoeTheme.Spacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        // Content controls height; the card no longer consumes preview space.
        .fixedSize(horizontal: false, vertical: true)
        .background(TamoeTheme.Colors.guestCardBackground)
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(TamoeTheme.Colors.priorityColor(for: priority))
                .frame(width: TamoeTheme.Size.guestCardPriorityStripeWidth)
                .accessibilityHidden(true)
        }
        .clipShape(RoundedRectangle(cornerRadius: TamoeTheme.Radius.card))
        .shadow(
            color: TamoeTheme.Shadow.color,
            radius: TamoeTheme.Shadow.radius,
            y: TamoeTheme.Shadow.yOffset
        )
    }

    /// Uses the screenshot's side-by-side card layout when width permits.
    private var horizontalContent: some View {
        HStack(alignment: .bottom, spacing: TamoeTheme.Spacing.medium) {
            guestIdentity

            Spacer(minLength: TamoeTheme.Spacing.small)

            paxAndPriority
        }
    }

    /// Stacks card content when Dynamic Type needs more horizontal space.
    private var verticalContent: some View {
        VStack(alignment: .leading, spacing: TamoeTheme.Spacing.medium) {
            guestIdentity
            paxAndPriority
        }
    }

    /// Groups the guest name, complete event list, and current category.
    private var guestIdentity: some View {
        VStack(alignment: .leading, spacing: TamoeTheme.Spacing.extraSmall) {
            Text(guestName)
                .font(TamoeTheme.Typography.cardTitle)

            Text(eventNamesText)
                .font(TamoeTheme.Typography.caption)
                .fixedSize(horizontal: false, vertical: true)

            Text(categoryName)
                .font(TamoeTheme.Typography.caption)
                .foregroundStyle(categoryColor)
                .padding(.horizontal, TamoeTheme.Spacing.small)
                .padding(.vertical, TamoeTheme.Spacing.extraSmall)
                .background(
                    TamoeTheme.Colors.categoryChipBackground,
                    in: Capsule()
                )
                .padding(.top, TamoeTheme.Spacing.extraSmall)
        }
        .foregroundStyle(TamoeTheme.Colors.primaryText)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    /// Groups the current-event household size and priority indicator.
    private var paxAndPriority: some View {
        VStack(alignment: .trailing, spacing: TamoeTheme.Spacing.extraSmall) {
            Text("\(householdSize) pax")
                .font(TamoeTheme.Typography.emphasizedBody)
                .monospacedDigit()

            HStack(spacing: TamoeTheme.Spacing.extraSmall) {
                Text(priority.displayName)
                    .font(TamoeTheme.Typography.caption)

                Circle()
                    .fill(TamoeTheme.Colors.priorityColor(for: priority))
                    .frame(width: 7, height: 7)
                    .accessibilityHidden(true)
            }
        }
        .foregroundStyle(TamoeTheme.Colors.primaryText)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }

    /// Chooses navigation or selection without letting both happen at once.
    private func handleTap() {
        if isSelectionMode {
            onSelectionToggle()
        } else {
            onTap()
        }
    }

    /// Combines all visual information into one concise VoiceOver label.
    private var accessibilityLabel: String {
        let events = orderedEventNames.joined(separator: ", ")
        return "\(guestName), events: \(events), category: \(categoryName), "
            + "\(householdSize) pax, \(priority.displayName)"
    }

    /// Explains the action that changes with the detailed list's mode.
    private var accessibilityHint: String {
        isSelectionMode
            ? "Double-tap to \(isSelected ? "deselect" : "select") this guest."
            : "Double-tap to edit this guest."
    }

    /// Joins names without sorting so the ViewModel's current-first order remains intact.
    var eventNamesText: String {
        orderedEventNames.joined(separator: ", ")
    }
}

#Preview("Guest Card states") {
    VStack(spacing: TamoeTheme.Spacing.medium) {
        GuestCard(
            guestName: "Aunt Jane",
            orderedEventNames: ["Holy Matrimony", "Reception", "Tea Pai"],
            categoryName: "Bride's",
            categoryColor: TamoeTheme.Colors.categoryPalette[0],
            householdSize: 2,
            priority: .mustInvite,
            onTap: {}
        )

        GuestCard(
            guestName: "Uncle John",
            orderedEventNames: ["Holy Matrimony", "Reception"],
            categoryName: "Groom's",
            categoryColor: TamoeTheme.Colors.categoryPalette[1],
            householdSize: 6,
            priority: .optional,
            isSelectionMode: true,
            isSelected: true,
            onTap: {},
            onSelectionToggle: {}
        )
    }
    .padding(TamoeTheme.Spacing.large)
    .background(TamoeTheme.Colors.pageBackground)
}
