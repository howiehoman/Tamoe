import Foundation
import SwiftData

struct TamoeSchemaV1 {
    static let schema = Schema([
        WeddingPlan.self,
        WeddingEvent.self,
        GuestCategory.self,
        CategoryEventQuota.self,
        Guest.self,
        GuestEventAssignment.self,
        GuestNote.self
    ])
}
