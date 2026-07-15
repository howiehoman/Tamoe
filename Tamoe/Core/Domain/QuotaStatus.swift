import Foundation

/// Describes whether an actual pax value is within its allowed limit.
enum QuotaStatus: Equatable, Sendable {
    /// The actual pax value is less than or equal to the limit.
    case onTrack

    /// The actual pax value is greater than the limit.
    case overCapacity

    /// Creates a status from the true, unclamped values supplied by metrics.
    init(actualPax: Int, limitPax: Int) {
        self = actualPax > limitPax ? .overCapacity : .onTrack
    }

    /// Provides consistent visible and VoiceOver copy for the status.
    var displayName: String {
        switch self {
        case .onTrack:
            "On Track"
        case .overCapacity:
            "Over Capacity"
        }
    }
}
