import Testing
@testable import Tamoe

/// Verifies the stable product language shared by summaries and filters.
@Test func priorityDisplayNamesUseApprovedCopy() {
    #expect(PriorityLevel.mustInvite.displayName == "Must-Invite")
    #expect(PriorityLevel.maybe.displayName == "Maybe")
    #expect(PriorityLevel.optional.displayName == "Optional")
}

/// Verifies that each concrete filter maps to exactly one priority.
@Test func priorityFiltersMapToDomainPriorities() {
    #expect(PriorityFilter.all.priority == nil)
    #expect(PriorityFilter.mustInvite.priority == .mustInvite)
    #expect(PriorityFilter.maybe.priority == .maybe)
    #expect(PriorityFilter.optional.priority == .optional)
}
