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
    @Dependency(\.defaultDatabase) var database
    @State private var person: Person.Draft?
    
    var body: some View {
        NavigationStack {
            Group {
                if peoples.isEmpty {
                    ContentUnavailableView("No People", image: "person.2")
                } else {
                    List {
                        ForEach(peoples, id: \.id) { people in
                            VStack(alignment: .leading) {
                                Text(people.name)
                                    .font(.headline)
                                Text(people.notes)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    person = Person.Draft(people)
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.yellow)
                            }
                            .swipeActions(edge: .trailing) {
                                Button {
                                    do {
                                        try database.write { db in
                                            try Person.delete(people)
                                                .execute(db)
                                        }
                                    } catch let error {
                                        print(error.localizedDescription)
                                    }
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .tint(.red)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    
                    
                }
            }
            .navigationTitle("Persons")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.person = Person.Draft()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(item: $person) { person in
                AddUpdatePerson(person: person)
                    .presentationDetents([.medium])
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
