//
//  SqliteDataStudyApp.swift
//  SqliteDataStudy
//
//  Created by Hardik Modha on 23/03/26.
//

import SwiftUI
import SQLiteData

@main
struct SqliteDataStudyApp: App {
    
    
    init() {
        prepareDependencies { dependencies in
            dependencies.defaultDatabase = .appDatabase()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
