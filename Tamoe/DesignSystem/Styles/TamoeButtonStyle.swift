import SwiftUI

struct TamoeButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .foregroundStyle(.white)
            .background(
                Color.brown.opacity(isEnabled ? 1 : 0.4),
                in: RoundedRectangle(cornerRadius: 14)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == TamoeButtonStyle {
    static var tamoePrimary: TamoeButtonStyle {
        TamoeButtonStyle()
    }
}

#Preview {
    VStack(spacing: 16) {
        Button("Next") {}
            .buttonStyle(.tamoePrimary)

        Button("Next") {}
            .buttonStyle(.tamoePrimary)
            .disabled(true)
    }
    .padding()
}
