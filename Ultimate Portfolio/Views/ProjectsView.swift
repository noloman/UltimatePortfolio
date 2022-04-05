//
//  ProjectsView.swift
//  Ultimate Portfolio
//
//  Created by Manu on 16/11/2021.
//

import SwiftUI

struct ProjectsView: View {
    static let openProjects = "OpenProjects"
    static let closedProjects = "ClosedProjects"
    let showClosedProjects: Bool
    @FetchRequest var projects: FetchedResults<Project>
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        _projects = FetchRequest(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.title, ascending: false)], predicate: NSPredicate(format: "closed = %d", showClosedProjects), animation: .default)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects) { project in
                    Section(header: ProjectHeaderView(project: project)) {
                        ForEach(project.projectItems, content: ItemRowView.init)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProjects ? "Closed projects" : "Open projects")
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var dataController: DataController = DataController.preview
    
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
