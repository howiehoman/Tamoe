import Testing
@testable import Tamoe

/// Verifies that GuestCard preserves the current-first order supplied by its ViewModel.
@Test func guestCardPreservesOrderedEventNames() {
    let card = GuestCard(
        guestName: "Aunt Jane",
        orderedEventNames: ["Holy Matrimony", "Reception", "Tea Pai"],
        categoryName: "Bride's",
        categoryColor: TamoeTheme.Colors.categoryPalette[0],
        householdSize: 2,
        priority: .mustInvite,
        onTap: {}
    )

    #expect(card.eventNamesText == "Holy Matrimony, Reception, Tea Pai")
}

/// Verifies that all twelve replaceable category color slots remain available.
@Test func temporaryCategoryPaletteContainsTwelveColors() {
    #expect(TamoeTheme.Colors.categoryPalette.count == 12)
}
