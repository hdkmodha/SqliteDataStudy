//
//  AddUpdatePerson.swift
//  SqliteDataStudy
//
//  Created by Hardik Modha on 07/04/26.
//

import Foundation
import IssueReporting
import SQLiteData
import SwiftUI

struct AddUpdatePerson: View {
    
    
    @Dependency(\.defaultDatabase) var database
    @Environment(\.dismiss) var dismiss
    
    @State private var person: Person.Draft
    @State private var name: String
    @State private var aboutMe: String
    
    init(person: Person.Draft) {
        self._person = State(initialValue: person)
        self._name = State(initialValue: person.name)
        self._aboutMe = State(initialValue: person.notes)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("name", text: $name)
                }
                
                Section("About Me") {
                    TextField("About Me", text: $aboutMe, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                }
            }
            .navigationTitle("Add Person")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .confirm) {
                        person.name = name
                        person.notes = aboutMe
                        
                        withErrorReporting {
                            try database.write { db in
                                try Person
                                    .upsert { person }
                                    .execute(db)
                            }
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddUpdatePerson(person: .QueryOutput(name: "", notes: ""))
}

