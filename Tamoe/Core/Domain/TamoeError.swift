import Foundation

enum TamoeError: Error, Equatable, Sendable {
    case planNotFound
    case eventNotFound(UUID)
    case categoryNotFound(UUID)
    case guestNotFound(UUID)
    case duplicateCategoryName
    case categoryInUse(categoryID: UUID)
    case categoryEventInUse(categoryID: UUID, eventID: UUID)
    case capacityBelowAllocatedQuota(eventID: UUID)
    case eventInUse(eventID: UUID, hasCategoryAllocations: Bool, hasGuestAssignments: Bool)
    case assignmentNotFound(guestID: UUID, eventID: UUID)
    case missingCategory(UUID)
    case categoryUnavailableForEvent(categoryID: UUID, eventID: UUID)
}
