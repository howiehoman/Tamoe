import SwiftUI
import Charts

struct AllocationDonutChart: View {
    // Parameter ini menerima array dari struct AllocationSegment yang sudah kita buat sebelumnya
    let segments: [AllocationSegment]
    
    // Opsi untuk mengatur ketebalan donat (opsional) - 0.98 akan membuatnya sangat tipis
    var donutThickness: CGFloat = 0.80
    
    var body: some View {
        // ZStack digunakan untuk menumpuk Chart (bawah) dan Teks (atas/tengah)
        ZStack {
            Chart(segments, id: \.id) { segment in
                SectorMark(
                    angle: .value("Porsi", segment.value),
                    innerRadius: .ratio(donutThickness), // Melubangi bagian tengah
                    angularInset: 0 // Memberikan jarak/celah putih antar potongan
                )
                // Mengubah warna berdasarkan properti colorHex, dengan fallback warna abu-abu
                .foregroundStyle(Color(hex: segment.colorHex) ?? Color.gray)
                // Membulatkan ujung dari setiap potongan
                .cornerRadius(0)
            }
            // Agar chart tidak memakan seluruh layar, kita batasi rasio aspeknya
            .aspectRatio(1, contentMode: .fit)
            
            // Teks di tengah Donat
            VStack(spacing: TamoeTheme.Spacing.extraSmall) {
                Text("Allocations")
                    .font(TamoeTheme.Typography.cardTitle)
                    .foregroundStyle(TamoeTheme.Colors.primaryText)
            }
            .padding(TamoeTheme.Spacing.medium)
        }
    }
}

// MARK: - Preview
#Preview {
    // Donut Chart
    AllocationDonutChart(
        segments: [
            AllocationSegment(id: UUID(), value: 50, colorHex: "#D44A00"),
            AllocationSegment(id: UUID(), value: 50, colorHex: "#A70000"),
        ]
        // donutThickness tidak diisi di sini agar menggunakan default 0.98
    )
    .frame(height: 200)
    .frame(maxWidth: .infinity)
}
