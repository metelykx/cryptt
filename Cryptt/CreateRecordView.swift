//
//  CreateRecordView.swift
//  Cryptt
//
//  Created by Denis Ivaschenko on 11.08.2025.
//

import SwiftUI

struct CreateRecordView: View {
    
    @Environment(\.managedObjectContext) var contexView
    @Environment(\.dismiss) var dismiss
    
    @State var title: String = ""
    @State var text: String = ""
    @State var date: String = ""
    
    // Для автоматического скрытия клавиатуры
    @FocusState private var focusedField: Field?
    
    enum Field {
        case title, text, date
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Record Details")) {
                    HStack {
                        Image(systemName: "circle.hexagonpath.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        
                        TextField("Title", text: $title)
                            .focused($focusedField, equals: .title)
                    }
                    
                    HStack(alignment: .top) {
                        Image(systemName: "calendar.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        
                        TextField("Date", text: $date)
                            .focused($focusedField, equals: .date)
                    }
                }
                
                Section(header: Text("Content")) {
                    TextEditor(text: $text)
                        .focused($focusedField, equals: .text)
                        .frame(minHeight: 200)
                        .overlay(
                            Group {
                                if text.isEmpty {
                                    Text("Enter your text here...")
                                        .foregroundColor(.gray)
                                        .padding(.top, 8)
                                        .padding(.leading, 5)
                                        .allowsHitTesting(false)
                                }
                            },
                            alignment: .topLeading
                        )
                }
            }
            .navigationTitle("Create Record")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveRecord()
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusedField = nil
                    }
                }
            }
        }
    }
    
    private func saveRecord() {
        let records = Item(context: contexView)
        
        records.title = title
        records.text = text
        records.date = date
        
        
        
        do {
            try contexView.save()
        } catch {
            print(error.localizedDescription)
        }




        print("Saving record: \(title)")
    }
}

#Preview {
    CreateRecordView()
}
