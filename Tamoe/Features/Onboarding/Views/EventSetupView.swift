import SwiftUI

struct EventSetupView: View {
    @Binding private var slots: [EventSlotDraft]

    private let nameErrors: [Int: String]
    private let capacityErrors: [Int: String]
    private let generalError: String?
    private let isSubmitting: Bool
    private let onSubmit: () -> Void

    init(
        slots: Binding<[EventSlotDraft]>,
        nameErrors: [Int: String] = [:],
        capacityErrors: [Int: String] = [:],
        generalError: String? = nil,
        isSubmitting: Bool = false,
        onSubmit: @escaping () -> Void = {}
    ) {
        _slots = slots
        self.nameErrors = nameErrors
        self.capacityErrors = capacityErrors
        self.generalError = generalError
        self.isSubmitting = isSubmitting
        self.onSubmit = onSubmit
    }

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: TamoeTheme.Spacing.large) {
                        header
                        eventRows
                        validationSummary
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, TamoeTheme.Spacing.large)
                    .frame(
                        minHeight: max(
                            proxy.size.height
                                - TamoeTheme.Size.minimumTapTarget
                                - 38,
                            0
                        ),
                        alignment: .center
                    )
                }
                .scrollDismissesKeyboard(.interactively)

                Button("Submit", action: onSubmit)
                    .buttonStyle(.tamoePrimary)
                    .frame(maxWidth: 346)
                    .disabled(isSubmitting)
                    .padding(.horizontal, TamoeTheme.Spacing.large)
                    .padding(.bottom, 38)
            }
        }
        .foregroundStyle(TamoeTheme.Colors.primaryText)
        .background(TamoeTheme.Colors.pageBackground.ignoresSafeArea())
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: TamoeTheme.Spacing.small) {
            Text("Set your wedding events and amount of guests you're expecting")
                .font(TamoeTheme.Typography.pageTitle)

            Text("Choose a maximum of five wedding events.")
                .font(TamoeTheme.Typography.body)
        }
        .accessibilityElement(children: .combine)
    }

    private var eventRows: some View {
        VStack(spacing: TamoeTheme.Spacing.small) {
            ForEach($slots) { $slot in
                EventSlotRow(
                    isActive: $slot.isActive,
                    name: $slot.name,
                    capacityText: $slot.capacityText,
                    nameError: nameErrors[slot.slotIndex],
                    capacityError: capacityErrors[slot.slotIndex]
                )
            }
        }
    }

    @ViewBuilder
    private var validationSummary: some View {
        if let generalError {
            Text(generalError)
                .font(TamoeTheme.Typography.caption)
                .foregroundStyle(TamoeTheme.Colors.warning)
                .accessibilityLabel("Setup error: \(generalError)")
        }
    }
}

#Preview {
    @Previewable @State var slots = EventSlotDraft.initialSlots()

    EventSetupView(slots: $slots)
}
