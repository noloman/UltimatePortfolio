//
//  EditItemView.swift
//  Ultimate Portfolio
//
//  Created by Manu on 04/04/2022.
//

import SwiftUI

struct EditItemView: View {
    let item: Item
    @EnvironmentObject var dataController: DataController
    @State private var title: String
    @State private var detail: String
    @State private var priority: Int
    @State private var completed: Bool
    
    init(item: Item) {
        self.item = item
        _title = State(wrappedValue: item.itemTitle)
        _detail = State(wrappedValue: item.itemDetail)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Item name", text: $title.onChange(update))
                TextField("Description", text: $detail.onChange(update))
            } header: {
                Text("Basic settings")
            }
            
            Section {
                Picker("Priority", selection: $priority.onChange(update)) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Priority")
            }
            
            Section {
                Toggle("Completed", isOn: $completed.onChange(update))
            }
        }
        .navigationTitle("Edit Item")
        .onDisappear {
            dataController.save()
        }
    }
    
    func update() {
        item.detail = detail
        item.completed = completed
        item.priority = Int16(priority)
        item.title = title
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item.example)
    }
}
