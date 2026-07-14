import Foundation
import SwiftData

@Model
final class Guest {
    @Attribute(.unique) var id: UUID
    var name: String
    var phoneNumber: String?
    var address: String?
    var createdAt: Date
    var updatedAt: Date
    
    @Relationship(inverse: \WeddingPlan.guests)
    var plan: WeddingPlan?
    
    @Relationship(deleteRule: .cascade)
    var assignments: [GuestEventAssignment] = []
    
    @Relationship(deleteRule: .cascade)
    var notes: [GuestNote] = []
    
    init(id: UUID = UUID(), name: String, phoneNumber: String? = nil, address: String? = nil) {
        self.id = id
        self.name = name.trimmingCharacters(in: .whitespaces)
        self.phoneNumber = phoneNumber?.trimmingCharacters(in: .whitespaces)
        self.address = address?.trimmingCharacters(in: .whitespaces)
        self.createdAt = .now
        self.updatedAt = .now
    }
}
