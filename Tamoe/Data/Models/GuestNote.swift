import Foundation
import SwiftData

@Model
final class GuestNote {
    @Attribute(.unique) var id: UUID
    var body: String
    var sortIndex: Int
    
    @Relationship(inverse: \Guest.notes)
    var guest: Guest?
    
    init(id: UUID = UUID(), body: String, sortIndex: Int, guest: Guest) {
        self.id = id
        self.body = body.trimmingCharacters(in: .whitespaces)
        self.sortIndex = sortIndex
        self.guest = guest
    }
}
