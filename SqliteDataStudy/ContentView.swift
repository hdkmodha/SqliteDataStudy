//
//  ContentView.swift
//  SqliteDataStudy
//
//  Created by Hardik Modha on 23/03/26.
//

import SwiftUI
import SQLiteData

struct ContentView: View {
    
    @FetchAll(Person.order(by: \.name)) var peoples: [Person]
    
    var body: some View {
        NavigationStack {
            if peoples.isEmpty {
                ContentUnavailableView("No People", image: "person.2")
            } else {
                List {
                    ForEach(peoples, id: \.id) { people in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(people.name)
                                    .font(.headline)
                            }
                        }
                    }
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
