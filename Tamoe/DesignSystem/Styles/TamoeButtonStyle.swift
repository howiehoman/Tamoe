import SwiftUI

struct TamoeButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    let typography: Font

    init(typography: Font = TamoeTheme.Typography.button) {
        self.typography = typography
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(typography)
            .frame(
                maxWidth: .infinity,
                minHeight: TamoeTheme.Size.minimumTapTarget
            )
            .padding(.horizontal, TamoeTheme.Spacing.medium)
            .foregroundStyle(TamoeTheme.Colors.onAccent)
            .background(
                TamoeTheme.Colors.accent.opacity(isEnabled ? 1 : 0.4),
                in: RoundedRectangle(cornerRadius: TamoeTheme.Radius.button)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == TamoeButtonStyle {
    static var tamoePrimary: TamoeButtonStyle {
        TamoeButtonStyle()
    }

    static var tamoeModal: TamoeButtonStyle {
        TamoeButtonStyle(typography: TamoeTheme.Typography.modalButton)
    }
}

#Preview {
    VStack(spacing: TamoeTheme.Spacing.medium) {
        Button("Next") {}
            .buttonStyle(.tamoePrimary)

        Button("Save Guest") {}
            .buttonStyle(.tamoeModal)

        Button("Next") {}
            .buttonStyle(.tamoePrimary)
            .disabled(true)
    }
    .padding(TamoeTheme.Spacing.large)
    .background(TamoeTheme.Colors.pageBackground)
}
