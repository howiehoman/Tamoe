import SwiftUI

struct EventSlotRow: View {
    @Binding var isActive: Bool
    @Binding var name: String
    @Binding var capacityText: String

    var nameError: String?
    var capacityError: String?
    var isEditable = true

    var body: some View {
        VStack(alignment: .leading, spacing: TamoeTheme.Spacing.extraSmall) {
            HStack(spacing: TamoeTheme.Spacing.small) {
                activationButton

                TextField("Event name", text: $name)
                    .font(TamoeTheme.Typography.body)
                    .foregroundStyle(TamoeTheme.Colors.primaryText)
                    .padding(.horizontal, TamoeTheme.Spacing.medium)
                    .frame(minHeight: TamoeTheme.Size.minimumTapTarget)
                    .background(
                        fieldBackground,
                        in: RoundedRectangle(cornerRadius: TamoeTheme.Radius.field)
                    )
                    .overlay(fieldBorder(hasError: nameError != nil))
                    .accessibilityLabel("Event name")

                ZStack(alignment: .trailing) {
                    TextField("___", text: $capacityText)
                        .font(TamoeTheme.Typography.body)
                        .foregroundStyle(TamoeTheme.Colors.primaryText)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .padding(.leading, TamoeTheme.Spacing.small)
                        .padding(.trailing, TamoeTheme.Spacing.extraLarge)

                    Text("Pax")
                        .font(TamoeTheme.Typography.caption)
                        .foregroundStyle(TamoeTheme.Colors.primaryText)
                        .padding(.trailing, TamoeTheme.Spacing.small)
                        .allowsHitTesting(false)
                }
                .frame(width: 96)
                .frame(minHeight: TamoeTheme.Size.minimumTapTarget)
                .background(
                    fieldBackground,
                    in: RoundedRectangle(cornerRadius: TamoeTheme.Radius.field)
                )
                .overlay(fieldBorder(hasError: capacityError != nil))
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Event capacity in pax")
            }

            errorMessages
                .padding(.leading, TamoeTheme.Size.minimumTapTarget + TamoeTheme.Spacing.small)
        }
        .disabled(!isEditable)
        .opacity(isEditable ? 1 : 0.6)
    }

    private var activationButton: some View {
        Button {
            isActive.toggle()
        } label: {
            ZStack {
                Circle()
                    .stroke(TamoeTheme.Colors.primaryText, lineWidth: 1.5)
                    .frame(width: 22, height: 22)

                if isActive {
                    Circle()
                        .fill(TamoeTheme.Colors.accent)
                        .frame(width: 14, height: 14)
                }
            }
            .frame(
                width: TamoeTheme.Size.minimumTapTarget,
                height: TamoeTheme.Size.minimumTapTarget
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(name.isEmpty ? "Enable event" : "Enable \(name)")
        .accessibilityValue(isActive ? "Selected" : "Not selected")
    }

    private var fieldBackground: some ShapeStyle {
        TamoeTheme.Colors.fieldBackground
    }

    private func fieldBorder(hasError: Bool) -> some View {
        RoundedRectangle(cornerRadius: TamoeTheme.Radius.field)
            .stroke(
                hasError ? TamoeTheme.Colors.warning : Color.clear,
                lineWidth: 1
            )
    }

    @ViewBuilder
    private var errorMessages: some View {
        if let nameError {
            Text(nameError)
                .font(TamoeTheme.Typography.caption)
                .foregroundStyle(TamoeTheme.Colors.warning)
        }

        if let capacityError {
            Text(capacityError)
                .font(TamoeTheme.Typography.caption)
                .foregroundStyle(TamoeTheme.Colors.warning)
        }
    }
}

#Preview {
    @Previewable @State var isActive = true
    @Previewable @State var name = "Holy Matrimony"
    @Previewable @State var capacity = "400"

    EventSlotRow(
        isActive: $isActive,
        name: $name,
        capacityText: $capacity
    )
    .padding(TamoeTheme.Spacing.large)
    .background(TamoeTheme.Colors.pageBackground)
}
