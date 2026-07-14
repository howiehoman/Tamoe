import SwiftUI

struct TamoeCardStyle: ViewModifier {
    var contentPadding: CGFloat = 20

    func body(content: Content) -> some View {
        content
            .padding(contentPadding)
            .background(.background, in: RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.primary.opacity(0.08), lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.08), radius: 12, y: 4)
    }
}

extension View {
    func tamoeCard(contentPadding: CGFloat = 20) -> some View {
        modifier(TamoeCardStyle(contentPadding: contentPadding))
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 8) {
        Text("Reception")
            .font(.headline)

        Text("120/200 pax")
            .font(.title2.bold())

        Text("80 pax remaining")
            .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .tamoeCard()
    .padding()
    .background(Color.brown.opacity(0.08))
}
