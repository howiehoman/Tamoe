import Foundation
import SwiftData

@Model
final class GuestEventAssignment {
    @Attribute(.unique) var id: UUID
    var householdSize: Int
    var priorityRawValue: String
    
    @Relationship(inverse: \Guest.assignments)
    var guest: Guest?
    
    @Relationship(inverse: \WeddingEvent.guestAssignments)
    var event: WeddingEvent?
    
    @Relationship(inverse: \GuestCategory.guestAssignments)
    var category: GuestCategory?
    
    init(id: UUID = UUID(), householdSize: Int = 1, priority: PriorityLevel, guest: Guest, event: WeddingEvent, category: GuestCategory) {
        self.id = id
        self.householdSize = householdSize
        self.priorityRawValue = priority.rawValue
        self.guest = guest
        self.event = event
        self.category = category
    }
}
