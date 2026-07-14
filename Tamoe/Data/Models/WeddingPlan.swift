import Foundation
import SwiftData

@Model
final class WeddingPlan {
    @Attribute(.unique) var id: UUID
    var hasCompletedOnboarding: Bool
    var createdAt: Date
    var updatedAt: Date
    
    @Relationship(deleteRule: .cascade)
    var events: [WeddingEvent] = []
    
    @Relationship(deleteRule: .cascade)
    var categories: [GuestCategory] = []
    
    @Relationship(deleteRule: .cascade)
    var guests: [Guest] = []
    
    init(id: UUID = UUID(), hasCompletedOnboarding: Bool = false) {
        self.id = id
        self.hasCompletedOnboarding = hasCompletedOnboarding
        self.createdAt = .now
        self.updatedAt = .now
    }
}
