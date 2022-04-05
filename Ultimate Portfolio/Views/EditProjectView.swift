//
//  EditProjectView.swift
//  Ultimate Portfolio
//
//  Created by Manu on 05/04/2022.
//

import SwiftUI

struct EditProjectView: View {
    let project: Project
    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String
    @State private var detail: String
    @State private var color: String
    @State private var showingDeleteConfirm = false
    
    let colorColumns = [
        GridItem(.adaptive(minimum: 44))
    ]
    
    init(project: Project) {
        self.project = project
        
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
    }
    
    var body: some View {
        Form {
            // Section 1
            Section {
                TextField("Project name", text: $title.onChange(update))
            } header: {
                Text("Basic settings")
            }
            
            Section {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Project.colors, id: \.self) { color in
                        ZStack {
                            Color(color)
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(6)
                            if color == self.color {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                        }.onTapGesture {
                            self.color = color
                            update()
                        }
                    }
                }
                .padding(.vertical)
            } header: {
                Text("Custom project color")
            }
            
            Section {
                Button {
                    project.closed.toggle()
                    update()
                } label: {
                    Text(project.closed ? "Reopen this project" : "Close this project")
                }
                Button {
                    showingDeleteConfirm.toggle()
                } label: {
                    Text("Delete this project")
                }.tint(.red)
            } footer: {
                Text("Closing a project moves it from the Open to Closed tab; deleting it removes the project completely.")
            }
        }
        .navigationTitle("Edit project")
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showingDeleteConfirm) {
            Alert(
                title: Text("Delete project"),
                message: Text("Are you sure you want to delete this project along with all its items?"),
                primaryButton: .destructive(Text("Delete"), action: delete),
                secondaryButton: .cancel()
            )
        }
    }
    
    func update() {
        project.title = title
        project.color = color
        project.detail = detail
    }
    
    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(project: Project.example)
    }
}
