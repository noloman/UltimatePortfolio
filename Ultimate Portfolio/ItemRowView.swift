//
//  ItemRowView.swift
//  Ultimate Portfolio
//
//  Created by Manu on 04/04/2022.
//

import SwiftUI

struct ItemRowView: View {
    @ObservedObject var item: Item
    var body: some View {
        NavigationLink {
            EditItemView(item: item)
        } label: {
            Text(item.itemTitle)
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(item: Item.example)
    }
}
