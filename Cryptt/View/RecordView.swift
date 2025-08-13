//
//  RecordView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI

struct RecordView: View {
    //for get and post info for data
    @Environment(\.managedObjectContext) var contexView
    
    //MARK: Request Data
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: false)]
    ) var records: FetchedResults<Item>
    
    
    @State var isTrue = false
    
    //MARK: View
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    List {
                        ForEach(records) { record in
                            VStack(alignment: .leading) {
                                Text(record.title ?? "Untitled")
                                    .font(.headline)
                                Text(record.text ?? "No text")
                                    .lineLimit(2)
                                Text(record.date ?? "")
                                    .font(.subheadline)
                            }
                        }
                    }.listStyle(PlainListStyle())
                    
                    
                    
                    
                        .navigationTitle("Your Records")
                        .sheet(isPresented: $isTrue) {
                            CreateRecordView()
                                .environment(\.managedObjectContext, contexView)
                        }
                }
            }
        }
    }
}

#Preview {
    RecordView()
}
