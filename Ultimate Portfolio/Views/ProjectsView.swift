//
//  ProjectsView.swift
//  Ultimate Portfolio
//
//  Created by Manu on 16/11/2021.
//

import SwiftUI

struct ProjectsView: View {
    static let openProjects: String? = "OpenProjects"
    static let closedProjects: String? = "ClosedProjects"
    let showClosedProjects: Bool
    @FetchRequest var projects: FetchedResults<Project>
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        _projects = FetchRequest(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.title, ascending: false)], predicate: NSPredicate(format: "closed = %d", showClosedProjects), animation: .default)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects) { project in
                    Section(header: ProjectHeaderView(project: project)) {
                        ForEach(project.projectItems) { item in
                            ItemRowView(item: item)
                        }.onDelete { offsets in
                            for offset in offsets {
                                let item = project.projectItems[offset]
                                dataController.delete(item)
                            }
                            dataController.save()
                        }
                        if showClosedProjects == false {
                            Button {
                                withAnimation {
                                    let item = Item(context: managedObjectContext)
                                    item.project = project
                                    item.creationDate = Date()
                                    dataController.save()
                                }
                            } label: {
                                Label("Add New Item", systemImage: "plus")
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProjects ? "Closed projects" : "Open projects")
            .toolbar {
                if showClosedProjects == false {
                    Button {
                        withAnimation {
                            let project = Project(context: managedObjectContext)
                            project.closed = false
                            project.creationDate = Date()
                            dataController.save()
                        }
                    } label: {
                        Label("Add Project", systemImage: "plus")
                    }
                }
            }
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
