//
//  ShowInfoView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 13.08.2025.
//

import SwiftUI

struct ShowInfoView: View {
    
    //we need to add infos becaus we wanna to create base info. Thanks this is infos we can crate a cool View
    let infos: Datum
    
    //MARK: View
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                
                
                VStack {
                    ZStack(alignment: .top) {
  
                        Rectangle()
                            .frame(width: .infinity, height: geometry.size.height/2)
                            .cornerRadius(20)
                            .padding(.vertical)
                            .padding(.horizontal)
                            .foregroundStyle(Color.gray.opacity(0.4))
                        
                        VStack {
                            HStack {
                                Text(infos.rank)
                                    .bold()
                                    .font(.title)
                                    .padding(.top,geometry.size.height/20)
                                
                                Text(infos.symbol)
                                    .font(.title)
                                    .bold()
                                    .padding(.top,geometry.size.height/20)
                            }
                            VStack(alignment: .leading) {
                                Text("Name: \(infos.name)")
                                    .padding(.trailing, geometry.size.height/4)
                                    .font(.title2)
                                    .padding(.leading)
                                
                                Text("Supply: \(infos.supply)")
                                    .font(.title2)
                                    .padding(.leading)
                                
                                Text("Max supply: \(infos.maxSupply!)")
                                    .font(.title2)
                                    .padding(.leading)
                                
                                Text("MarketCapUSD : \(infos.marketCapUsd)")
                                    .font(.title2)
                                
                                Text("Volume: \(infos.volumeUsd24Hr)")
                                    .font(.title2)
                                
                                Text("Price: \(infos.priceUsd)")
                                    .font(.title2)
                                
                                Text("Changes: \(infos.changePercent24Hr)")
                                    .font(.title2)
                                    
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ShowInfoView(infos: Datum(rank: "1", symbol: "BTC", name: "BitCoin", supply: "19905281.0000", maxSupply: "21000000.00", marketCapUsd: "2378217132259.4600698742800082", volumeUsd24Hr: "19062411264.4263499071064425", priceUsd: "119476.6922536516851922", changePercent24Hr: "0.4384217220864664"))
}
