import SwiftUI

struct FloatingDashboardAction: View {
    let leftIcon: String
    let rightIcon: String
    
    let onLeftTap: () -> Void
    let onRightTap: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                triggerHaptic()
                onLeftTap()
            }) {
                Image(systemName: leftIcon)
                    .font(.system(size: 24, weight: .regular))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .contentShape(Rectangle())
            }
            .buttonStyle(DualFABStyle())
            
            Divider()
                .background(TamoeTheme.Colors.onAccent.opacity(0.4))
                .frame(height: 24)
            
            Button(action: {
                triggerHaptic()
                onRightTap()
            }) {
                Image(systemName: rightIcon)
                    .font(.system(size: 26, weight: .regular))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .contentShape(Rectangle())
            }
            .buttonStyle(DualFABStyle())
        }
        .foregroundStyle(TamoeTheme.Colors.onAccent)
        .background(
            TamoeTheme.Colors.accent,
            in: Capsule()
        )
        .overlay(
            Capsule()
                .stroke(TamoeTheme.Colors.onAccent.opacity(0.3), lineWidth: 1)
        )
        .shadow(
            color: TamoeTheme.Shadow.color.opacity(0.5),
            radius: 8,
            x: 0,
            y: 4
        )
    }
    
    private func triggerHaptic() {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
    }
}

private struct DualFABStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Preview
#Preview {
    ZStack(alignment: .bottomTrailing) {
        // Latar belakang halaman
        Color.clear
            .background(TamoeTheme.Colors.pageBackground)
            .ignoresSafeArea()
        
        FloatingDashboardAction(
            leftIcon: "book",
            rightIcon: "plus",
            onLeftTap: {
                print("kiri")
            },
            onRightTap: {
                print("kanan")
            }
        )
        .padding(.trailing, TamoeTheme.Spacing.large)
        .padding(.bottom, TamoeTheme.Spacing.large)
    }
}
