//
//  ContentView.swift
//  SqliteDataStudy
//
//  Created by Hardik Modha on 23/03/26.
//

import SwiftUI
import SQLiteData

struct ContentView: View {
    
    @State private var viewModel: PersonViewModel = .init()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.peoples.isEmpty {
                    ContentUnavailableView("No People", image: "person.2")
                } else {
                    List {
                        ForEach(viewModel.peoples, id: \.id) { people in
                            VStack(alignment: .leading) {
                                Text(people.name)
                                    .font(.headline)
                                Text(people.notes)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    viewModel.person = Person.Draft(people)
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.yellow)
                            }
                            .swipeActions(edge: .trailing) {
                                Button {
                                    viewModel.reduce(.deleteButtonTapped(people))
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
            .searchable(text: $viewModel.searchText, prompt: "Enter name or notes")
            .navigationTitle("Persons")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                       viewModel.person = Person.Draft()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    Button {
                        viewModel.isAcending.toggle()
                    } label: {
                        Image(systemName: viewModel.isAcending ? "arrow.down" : "arrow.up")
                    }
                }
            }
            .sheet(item: $viewModel.person) { person in
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
