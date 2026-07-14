import Foundation
import SwiftData

@Model
final class CategoryEventQuota {
    @Attribute(.unique) var id: UUID
    var quotaPax: Int
    
    @Relationship(inverse: \GuestCategory.eventQuotas)
    var category: GuestCategory?
    
    @Relationship(inverse: \WeddingEvent.categoryQuotas)
    var event: WeddingEvent?
    
    init(id: UUID = UUID(), quotaPax: Int, category: GuestCategory, event: WeddingEvent) {
        self.id = id
        self.quotaPax = quotaPax
        self.category = category
        self.event = event
    }
}
