import Foundation
import SwiftData

struct ModelContainerFactory {
    static func createContainer(inMemory: Bool = false) -> ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
        
        do {
            let container = try ModelContainer(for: TamoeSchemaV1.schema, configurations: [configuration])
            DefaultWeddingPlanSeeder.seed(context: container.mainContext)
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
