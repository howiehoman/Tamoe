import SwiftUI

struct OpeningView: View {
    let onNext: () -> Void

    init(onNext: @escaping () -> Void = {}) {
        self.onNext = onNext
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()

            VStack(alignment: .leading, spacing: TamoeTheme.Spacing.small) {
                Text("Every wedding is")
                    .font(TamoeTheme.Typography.body)

                Text("UNIQUE")
                    .font(TamoeTheme.Typography.heroTitle)

                Text(
                    "Tell us about your wedding plans. Choose your wedding events "
                        + "and set the guest capacity for each one. We'll organize "
                        + "your guest list around the celebration you're planning."
                )
                .font(TamoeTheme.Typography.body)
                .padding(.top, TamoeTheme.Spacing.extraSmall)
            }
            .accessibilityElement(children: .combine)

            Spacer()

            Button("Next", action: onNext)
                .buttonStyle(.tamoePrimary)
                .accessibilityHint("Continues to wedding event setup")
        }
        .foregroundStyle(TamoeTheme.Colors.primaryText)
        .padding(.horizontal, TamoeTheme.Spacing.large)
        .padding(.vertical, TamoeTheme.Spacing.medium)
        .background(TamoeTheme.Colors.pageBackground.ignoresSafeArea())
    }
}

#Preview {
    OpeningView()
}
