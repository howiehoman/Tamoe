import Testing
@testable import Tamoe

/// Verifies that values below their limit remain on track.
@Test func quotaBelowLimitIsOnTrack() {
    #expect(QuotaStatus(actualPax: 10, limitPax: 20) == .onTrack)
}

/// Verifies that reaching the exact limit is still an on-track state.
@Test func quotaAtLimitIsOnTrack() {
    #expect(QuotaStatus(actualPax: 20, limitPax: 20) == .onTrack)
}

/// Verifies that the first pax above a limit produces an overflow warning.
@Test func quotaAboveLimitIsOverCapacity() {
    #expect(QuotaStatus(actualPax: 21, limitPax: 20) == .overCapacity)
}

/// Verifies that progress uses the true ratio while clamping only its visual fill.
@Test func paxProgressClampsVisualFraction() {
    #expect(PaxProgressView(actualPax: 0, limitPax: 40).fillFraction == 0)
    #expect(PaxProgressView(actualPax: 20, limitPax: 40).fillFraction == 0.5)
    #expect(PaxProgressView(actualPax: 50, limitPax: 40).fillFraction == 1)
}

/// Verifies that an invalid zero limit cannot cause division by zero.
@Test func paxProgressHandlesZeroLimitSafely() {
    #expect(PaxProgressView(actualPax: 10, limitPax: 0).fillFraction == 0)
}
