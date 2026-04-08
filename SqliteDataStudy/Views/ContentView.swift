//
//  ContentView.swift
//  SqliteDataStudy
//
//  Created by Hardik Modha on 23/03/26.
//

import SwiftUI
import SQLiteData

struct ContentView: View {
    
    var body: some View {
        Group {
            TabView {
                PersonListView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Users")
                    }
                CarListView()
                    .tabItem {
                        Image(systemName: "car.fill")
                        Text("Cars")
                    }
            
            }
        }
    }
}

#Preview {
    let _ = prepareDependencies { dependencies in
        dependencies.defaultDatabase = .appDatabase()
        do {
            try dependencies.seedDatabaseForPreviews()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    ContentView()
}
