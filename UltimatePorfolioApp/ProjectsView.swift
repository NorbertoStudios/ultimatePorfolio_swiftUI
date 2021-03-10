//
//  ProjectView.swift
//  UltimatePorfolioApp
//
//  Created by Norberto Fernandez on 3/9/21.
//

import SwiftUI

struct ProjectsView: View {
    
    let showClosedProjects: Bool
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        
        projects = FetchRequest(entity: Project.entity(),
                                sortDescriptors: [
                                    NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)
                                ], predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: Text(project.title ?? "")){
                        ForEach(project.items?.allObjects as? [Item] ?? [])
                        { item in
                            Text(item.title ?? "")
                        }
                    }
                }
            }.listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProjects ? "Close Projects" :
                                "Open Projects")
        }
    }
}

struct ProjectView_Previews: PreviewProvider {
    
    static var dataController = DataController.preview
    
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
