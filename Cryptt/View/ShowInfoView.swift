import SwiftUI

struct ShowInfoView: View {
    let infos: Datum
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Заголовок карточки
            HStack {
                Text("#\(infos.rank)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.blue)
                
                Text(infos.symbol)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text(infos.name)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 8)
            
            // Основные метрики
            VStack(alignment: .leading, spacing: 8) {
                MetricRow(title: "Price",
                          value: formattedCurrency(infos.priceUsd),
                          icon: "dollarsign.circle")
                
                MetricRow(title: "Market Cap",
                          value: formattedCurrency(infos.marketCapUsd),
                          icon: "chart.bar")
                
                MetricRow(title: "Volume (24h)",
                          value: formattedCurrency(infos.volumeUsd24Hr),
                          icon: "arrow.left.arrow.right")
                
                HStack {
                    MetricRow(title: "Supply",
                              value: formattedNumber(infos.supply),
                              icon: "number")
                    
                    MetricRow(title: "Max Supply",
                              value: formattedNumber(infos.maxSupply),
                              icon: "infinity")
                }
                
                // Изменение цены с цветовой индикацией
                HStack {
                    Image(systemName: infos.changePercent24Hr.hasPrefix("-") ?
                          "arrow.down.right" : "arrow.up.right")
                    
                    Text("24h Change")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(formattedPercent(infos.changePercent24Hr))
                        .bold()
                        .foregroundColor(infos.changePercent24Hr.hasPrefix("-") ?
                                       .red : .green)
                }
                .padding(.top, 4)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 3)
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    // MARK: - Форматирующие функции
    
    private func formattedCurrency(_ value: String?) -> String {
        guard let value = value, let number = Double(value) else { return "N/A" }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        
        if number > 1_000_000_000 {
            formatter.positiveSuffix = "B"
            return formatter.string(from: NSNumber(value: number / 1_000_000_000)) ?? "N/A"
        } else if number > 1_000_000 {
            formatter.positiveSuffix = "M"
            return formatter.string(from: NSNumber(value: number / 1_000_000)) ?? "N/A"
        }
        
        return formatter.string(from: NSNumber(value: number)) ?? "N/A"
    }
    
    private func formattedNumber(_ value: String?) -> String {
        guard let value = value, let number = Double(value) else { return "N/A" }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        if number > 1_000_000_000 {
            formatter.positiveSuffix = "B"
            return formatter.string(from: NSNumber(value: number / 1_000_000_000)) ?? "N/A"
        } else if number > 1_000_000 {
            formatter.positiveSuffix = "M"
            return formatter.string(from: NSNumber(value: number / 1_000_000)) ?? "N/A"
        }
        
        return formatter.string(from: NSNumber(value: number)) ?? "N/A"
    }
    
    private func formattedPercent(_ value: String?) -> String {
        guard let value = value, let number = Double(value) else { return "N/A" }
        return String(format: "%.2f%%", number)
    }
}

// Вспомогательный вид для строки метрики
struct MetricRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.secondary)
                .frame(width: 24)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .bold()
        }
    }
}

#Preview {
    ShowInfoView(infos: Datum(
        id: "bitcoin",
        rank: "1",
        symbol: "BTC",
        name: "Bitcoin",
        supply: "19423843.0000000000000000",
        maxSupply: "21000000.0000000000000000",
        marketCapUsd: "1194766922536",
        volumeUsd24Hr: "19062411264",
        priceUsd: "61476.69",
        changePercent24Hr: "0.43",
        vwap24Hr: "",
        explorer: "https://blockchain.info/",
        tokens: [:]
    ))
}
