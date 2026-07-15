import SwiftUI

/// Shows the compact empty-category message used on the dashboard.
struct TamoeEmptyState: View {
    /// The message displayed in SF Pro and transformed to uppercase.
    let title: String

    /// Creates the label-only state shown above `FloatingDashboardActions`.
    ///
    /// - Parameters:
    ///   - title: The message to display. The default matches the reference.
    init(
        title: String = "Add New Category"
    ) {
        self.title = title
    }

    /// Builds the centered SF Pro label without duplicating the floating action.
    var body: some View {
        Text(title.uppercased())
            .font(TamoeTheme.Typography.modalLabel)
            .fontWeight(.semibold)
            .tracking(0.5)
            .foregroundStyle(Color(uiColor: .systemGray3))
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(TamoeTheme.Spacing.medium)
            .accessibilityLabel(title)
    }
}

#Preview("Tamoe empty state") {
    TamoeEmptyState()
        .padding(TamoeTheme.Spacing.large)
        .background(TamoeTheme.Colors.pageBackground)
}
