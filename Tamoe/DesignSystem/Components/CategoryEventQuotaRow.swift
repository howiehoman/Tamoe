import SwiftUI

struct CategoryEventQuotaRow: View {
    let eventName: String
    
    @Binding var isEnabled: Bool
    @Binding var quotaText: String
    
    var body: some View {
        HStack(spacing: TamoeTheme.Spacing.medium) {
            Button {
                withAnimation(.easeInOut(duration: 0.15)) {
                    isEnabled.toggle()
                    
                    if !isEnabled {
                        quotaText = ""
                    }
                }
            } label: {
                Image(systemName: isEnabled ? "record.circle" : "circle")
                    .font(.system(size: 22, weight: .regular))
                    // Warna menyesuaikan status aktif atau tidak
                    .foregroundStyle(isEnabled ? TamoeTheme.Colors.accent : TamoeTheme.Colors.primaryText.opacity(0.3))
            }
            .buttonStyle(.plain)
            
            Text(eventName)
                .font(TamoeTheme.Typography.body)
                .foregroundStyle(TamoeTheme.Colors.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, TamoeTheme.Spacing.medium)
                .padding(.vertical, 8)
            
            HStack(spacing: TamoeTheme.Spacing.extraSmall) {
                TextField("0", text: $quotaText)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 40)
                    .font(TamoeTheme.Typography.label)
                    .disabled(!isEnabled)
                
                Text("Pax")
                    .font(TamoeTheme.Typography.label)
            }
            .padding(.horizontal, TamoeTheme.Spacing.medium)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isEnabled ? TamoeTheme.Colors.accent.opacity(0.2) : TamoeTheme.Colors.pageBackground)
            )
            .foregroundStyle(isEnabled ? TamoeTheme.Colors.primaryText : TamoeTheme.Colors.primaryText.opacity(0.4))
        }
        .padding(.vertical, TamoeTheme.Spacing.extraSmall)
    }
}

// MARK: - Preview
#Preview {
    struct PreviewWrapper: View {
        @State private var isMatrimonyEnabled = true
        @State private var matrimonyQuota = "150"
        
        @State private var isReceptionEnabled = false
        @State private var receptionQuota = ""
        
        var body: some View {
            VStack(spacing: TamoeTheme.Spacing.medium) {
                CategoryEventQuotaRow(
                    eventName: "Holy Matrimony",
                    isEnabled: $isMatrimonyEnabled,
                    quotaText: $matrimonyQuota
                )
            }
            .padding()
        }
    }
    
    return PreviewWrapper()
}
