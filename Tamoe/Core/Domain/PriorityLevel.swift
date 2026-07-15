import Foundation

/// Describes a guest assignment's importance for one wedding event.
///
/// Priority belongs to an event assignment rather than the global guest, so a
/// guest can have a different priority in each event.
enum PriorityLevel: String, Codable, CaseIterable, Identifiable, Sendable {
    /// The guest should be included before lower-priority guests.
    case mustInvite

    /// The guest is being considered but is not yet essential.
    case maybe

    /// The guest can be included when capacity remains available.
    case optional

    /// Lets SwiftUI identify each priority by its stable enum value.
    var id: Self { self }

    /// Provides the approved user-facing name instead of exposing raw values.
    var displayName: String {
        switch self {
        case .mustInvite:
            "Must-Invite"
        case .maybe:
            "Maybe"
        case .optional:
            "Optional"
        }
    }
}
