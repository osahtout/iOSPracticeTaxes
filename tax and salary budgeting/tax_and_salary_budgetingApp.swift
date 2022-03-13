//
//  tax_and_salary_budgetingApp.swift
//  tax and salary budgeting
//
//  Created by Sahtout, Omar on 2022-03-13.
//

import SwiftUI

@main
struct tax_and_salary_budgetingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
