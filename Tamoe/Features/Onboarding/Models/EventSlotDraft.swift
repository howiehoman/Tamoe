import Foundation

struct EventSlotDraft: Identifiable, Equatable {
    let id: UUID
    let slotIndex: Int
    var name: String
    var capacityText: String
    var isActive: Bool
}

extension EventSlotDraft {
    static func initialSlots() -> [EventSlotDraft] {
        [
            EventSlotDraft(
                id: UUID(),
                slotIndex: 0,
                name: "Holy Matrimony / Akad",
                capacityText: "",
                isActive: false
            ),
            EventSlotDraft(
                id: UUID(),
                slotIndex: 1,
                name: "Reception",
                capacityText: "",
                isActive: false
            ),
            EventSlotDraft(
                id: UUID(),
                slotIndex: 2,
                name: "",
                capacityText: "",
                isActive: false
            ),
            EventSlotDraft(
                id: UUID(),
                slotIndex: 3,
                name: "",
                capacityText: "",
                isActive: false
            ),
            EventSlotDraft(
                id: UUID(),
                slotIndex: 4,
                name: "",
                capacityText: "",
                isActive: false
            )
        ]
    }
}
