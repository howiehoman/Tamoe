import SwiftUI

/// Lets a user increase or decrease an integer pax value.
struct PaxStepper: View {
    /// Explains which pax value the stepper changes.
    let label: String

    /// Connects the control to draft state owned by its parent ViewModel.
    @Binding var value: Int

    /// Prevents the value from decreasing below the product's valid minimum.
    let minimumValue: Int

    /// Creates a stepper whose household-size default minimum is one pax.
    ///
    /// - Parameters:
    ///   - label: The visible and accessible name of the value.
    ///   - value: A binding to the parent's draft integer.
    ///   - minimumValue: The lowest permitted value. The default is `1`.
    init(
        label: String,
        value: Binding<Int>,
        minimumValue: Int = 1
    ) {
        self.label = label
        _value = value
        self.minimumValue = minimumValue
    }

    /// Builds the row label and the compact minus/value/plus control.
    var body: some View {
        HStack(spacing: TamoeTheme.Spacing.medium) {
            Text(label)
                .font(TamoeTheme.Typography.modalBody)

            Spacer(minLength: TamoeTheme.Spacing.small)

            HStack(spacing: 0) {
                Button(action: decrement) {
                    Image(systemName: "minus")
                        .frame(
                            width: TamoeTheme.Size.minimumTapTarget,
                            height: TamoeTheme.Size.minimumTapTarget
                        )
                }
                .disabled(value <= minimumValue)

                Text("\(value)")
                    .font(TamoeTheme.Typography.modalButton)
                    .monospacedDigit()
                    .frame(minWidth: TamoeTheme.Size.minimumTapTarget)

                Button(action: increment) {
                    Image(systemName: "plus")
                        .frame(
                            width: TamoeTheme.Size.minimumTapTarget,
                            height: TamoeTheme.Size.minimumTapTarget
                        )
                }
                .disabled(value == Int.max)
            }
            .foregroundStyle(TamoeTheme.Colors.primaryText)
            // The entire compact control shares one Liquid Glass capsule.
            .glassEffect(
                .regular
                    .tint(TamoeTheme.Colors.categoryChipBackground)
                    .interactive(),
                in: Capsule()
            )
        }
        .foregroundStyle(TamoeTheme.Colors.primaryText)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label)
        .accessibilityValue("\(value) pax")
        .accessibilityAdjustableAction(adjustValue)
    }

    /// Decreases the value by one without crossing the configured minimum.
    private func decrement() {
        value = max(value - 1, minimumValue)
    }

    /// Increases the value by one while protecting against integer overflow.
    private func increment() {
        guard value < Int.max else { return }
        value += 1
    }

    /// Gives VoiceOver users the same increment and decrement behavior.
    private func adjustValue(_ direction: AccessibilityAdjustmentDirection) {
        switch direction {
        case .increment:
            increment()
        case .decrement:
            decrement()
        @unknown default:
            break
        }
    }
}

#Preview("Pax stepper") {
    @Previewable @State var householdSize = 2

    PaxStepper(label: "Household size", value: $householdSize)
        .padding(TamoeTheme.Spacing.large)
}
