import Foundation
import SwiftData

@Model
final class WeddingEvent {
    @Attribute(.unique) var id: UUID
    var slotIndex: Int
    var name: String
    var capacityPax: Int
    var isActive: Bool
    
    @Relationship(inverse: \WeddingPlan.events)
    var plan: WeddingPlan?
    
    @Relationship(deleteRule: .cascade)
    var categoryQuotas: [CategoryEventQuota] = []
    
    @Relationship(deleteRule: .cascade)
    var guestAssignments: [GuestEventAssignment] = []
    
    init(id: UUID = UUID(), slotIndex: Int, name: String = "", capacityPax: Int = 0, isActive: Bool = false) {
        self.id = id
        self.slotIndex = slotIndex
        self.name = name.trimmingCharacters(in: .whitespaces)
        self.capacityPax = capacityPax
        self.isActive = isActive
    }
}
