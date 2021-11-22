//
//  HomeView.swift
//  Ultimate Portfolio
//
//  Created by Manu on 16/11/2021.
//

import SwiftUI

struct HomeView: View {
    static let tag = "Home"
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Add data") {
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                }
            }
        }
        .navigationTitle("Home")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
