import SwiftUI

struct CategorySummaryCard: View {
    let categoryName: String
    
    let titleColor: Color
    
    let actualPax: Int
    let limitPax: Int
    let priorityPax: [PriorityLevel: Int]
    
    var body: some View {
        VStack(alignment: .leading, spacing: TamoeTheme.Spacing.medium) {
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: TamoeTheme.Spacing.extraSmall) {
                    Text(categoryName)
                        .font(TamoeTheme.Typography.cardTitle)
                        .foregroundStyle(titleColor)
                    
                    QuotaWarningBadge(
                        actualPax: actualPax,
                        limitPax: limitPax,
                        scopeLabel: categoryName,
                        presentation: .statusLabel
                    )
                }
                
                Spacer(minLength: TamoeTheme.Spacing.small)
                
                Text("\(actualPax)/\(limitPax)")
                    .font(TamoeTheme.Typography.label)
                    .monospacedDigit()
                    .foregroundStyle(TamoeTheme.Colors.primaryText)
            }
            
            PaxProgressView(
                actualPax: actualPax,
                limitPax: limitPax
            )
            
            PrioritySummary(priorityPax: priorityPax)
        }
        .tamoeCard(contentPadding: TamoeTheme.Spacing.large)
    }
}

// MARK: - Preview
#Preview {
    VStack {
        CategorySummaryCard(
            categoryName: "temen papa bride",
            titleColor: Color(hex: "#D32F2F") ?? .red,
            actualPax: 25,
            limitPax: 40,
            priorityPax: [
                .mustInvite: 15,
                .maybe: 5,
                .optional: 5
            ]
        )
    }
    .padding()
    .background(TamoeTheme.Colors.pageBackground)
}
