import Foundation
import SwiftData

struct DefaultWeddingPlanSeeder {
    static func seed(context: ModelContext) {
        let fetchDescriptor = FetchDescriptor<WeddingPlan>()
        guard let count = try? context.fetchCount(fetchDescriptor), count == 0 else { return }
        
        let plan = WeddingPlan(hasCompletedOnboarding: false)
        context.insert(plan)
        
        let defaultEvents = [
            (0, "Holy Matrimony / Akad", false),
            (1, "Reception", false),
            (2, "", false),
            (3, "", false),
            (4, "", false)
        ]
        
        for (index, name, active) in defaultEvents {
            let event = WeddingEvent(slotIndex: index, name: name, capacityPax: 0, isActive: active)
            event.plan = plan
            context.insert(event)
        }
        
        try? context.save()
    }
}
