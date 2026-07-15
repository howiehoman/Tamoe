import SwiftUI

struct EventSegmentedPicker: View {
    let options: [String]
    
    @Binding var selection: String
    
    @Namespace private var animation
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                Button {
                    // Animasi
                    withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.5)) {
                        selection = option
                    }
                } label: {
                    Text(option)
                        .font(TamoeTheme.Typography.label)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
//                        .minimumScaleFactor(0.7)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 8)
                        .foregroundStyle(selection == option ? TamoeTheme.Colors.primaryText : TamoeTheme.Colors.primaryText.opacity(1))
                        .background {
                            if selection == option {
                                RoundedRectangle(cornerRadius: TamoeTheme.Radius.card)
                                    .fill(TamoeTheme.Colors.cardBackground)
                                    .shadow(color: TamoeTheme.Shadow.color.opacity(0.5), radius: 4, x: 0, y: 2)
                                    .matchedGeometryEffect(id: "activeTab", in: animation)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: TamoeTheme.Radius.card)
                .fill(TamoeTheme.Colors.primaryText.opacity(0.12))
        )
    }
}

// MARK: - Preview
#Preview {
    struct PreviewWrapper: View {
        @State private var selectedEvent = "Holy Matrimony"
        let events = ["Holy Matrimony", "Reception", "Teapai"]
        
        var body: some View {
            VStack(spacing: TamoeTheme.Spacing.large) {
                EventSegmentedPicker(
                    options: events,
                    selection: $selectedEvent
                )
                Spacer()
            }
            .padding(TamoeTheme.Spacing.medium)
        }
    }
    
    return PreviewWrapper()
}
