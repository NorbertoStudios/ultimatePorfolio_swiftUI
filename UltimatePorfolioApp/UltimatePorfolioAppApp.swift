//
//  UltimatePorfolioAppApp.swift
//  UltimatePorfolioApp
//
//  Created by Norberto Fernandez on 3/9/21.
//

import SwiftUI

@main
struct UltimatePorfolioAppApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
