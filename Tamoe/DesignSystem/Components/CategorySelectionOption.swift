import SwiftUI

/// Supplies the stable identity and display name needed by a category menu.
struct CategorySelectionOption: Identifiable {
    /// The stable category identity stored in a guest assignment draft.
    let id: UUID

    /// The category name shown to the user.
    let name: String

    /// The assigned palette color used whenever the category name is shown.
    let color: Color
}
