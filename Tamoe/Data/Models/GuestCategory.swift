import Foundation
import SwiftData

@Model
final class GuestCategory {
    @Attribute(.unique) var id: UUID
    var name: String
    var createdAt: Date
    
    @Relationship(inverse: \WeddingPlan.categories)
    var plan: WeddingPlan?
    
    @Relationship(deleteRule: .cascade)
    var eventQuotas: [CategoryEventQuota] = []
    
    @Relationship(deleteRule: .nullify)
    var guestAssignments: [GuestEventAssignment] = []
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name.trimmingCharacters(in: .whitespaces)
        self.createdAt = .now
    }
}
