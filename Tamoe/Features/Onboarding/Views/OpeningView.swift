import SwiftUI

struct OpeningView: View {
    let onNext: () -> Void

    init(onNext: @escaping () -> Void = {}) {
        self.onNext = onNext
    }

    var body: some View {
        VStack(spacing: 0) {
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
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(maxHeight: .infinity, alignment: .leading)
            .padding(.horizontal, TamoeTheme.Spacing.large)

            Button("Next", action: onNext)
                .buttonStyle(.tamoePrimary)
                .frame(maxWidth: 346)
                .padding(.horizontal, TamoeTheme.Spacing.large)
                .padding(.bottom, 38)
                .accessibilityHint("Continues to wedding event setup")
        }
        .foregroundStyle(TamoeTheme.Colors.primaryText)
        .background(TamoeTheme.Colors.pageBackground.ignoresSafeArea())
    }
}

#Preview {
    OpeningView()
}
