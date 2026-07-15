import Foundation

/// Defines the priority choices available above a detailed guest list.
enum PriorityFilter: String, Codable, Hashable, CaseIterable, Identifiable, Sendable {
    /// Includes every priority in the current event and list scope.
    case all

    /// Includes only Must-Invite assignments.
    case mustInvite

    /// Includes only Maybe assignments.
    case maybe

    /// Includes only Optional assignments.
    case optional

    /// Lets SwiftUI identify each filter by its stable enum value.
    var id: Self { self }

    /// Maps a filter to its matching domain priority when one exists.
    var priority: PriorityLevel? {
        switch self {
        case .all:
            nil
        case .mustInvite:
            .mustInvite
        case .maybe:
            .maybe
        case .optional:
            .optional
        }
    }

    /// Provides the approved label displayed inside the filter control.
    var displayName: String {
        priority?.displayName ?? "All"
    }
}
