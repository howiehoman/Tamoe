import SwiftUI

struct TamoeCardStyle: ViewModifier {
    var contentPadding: CGFloat = TamoeTheme.Spacing.medium

    func body(content: Content) -> some View {
        content
            .padding(contentPadding)
            .background(
                TamoeTheme.Colors.cardBackground,
                in: RoundedRectangle(cornerRadius: TamoeTheme.Radius.card)
            )
            .overlay {
                RoundedRectangle(cornerRadius: TamoeTheme.Radius.card)
                    .stroke(TamoeTheme.Colors.border, lineWidth: 1)
            }
            .shadow(
                color: TamoeTheme.Shadow.color,
                radius: TamoeTheme.Shadow.radius,
                y: TamoeTheme.Shadow.yOffset
            )
    }
}

extension View {
    func tamoeCard(contentPadding: CGFloat = TamoeTheme.Spacing.medium) -> some View {
        modifier(TamoeCardStyle(contentPadding: contentPadding))
    }
}

#Preview {
    VStack(alignment: .leading, spacing: TamoeTheme.Spacing.small) {
        Text("Reception")
            .font(TamoeTheme.Typography.cardTitle)

        Text("120/200 pax")
            .font(TamoeTheme.Typography.metric)

        Text("80 pax remaining")
            .font(TamoeTheme.Typography.caption)
            .foregroundStyle(.secondary)
    }
    .foregroundStyle(TamoeTheme.Colors.primaryText)
    .frame(maxWidth: .infinity, alignment: .leading)
    .tamoeCard()
    .padding(TamoeTheme.Spacing.large)
    .background(TamoeTheme.Colors.pageBackground)
}
