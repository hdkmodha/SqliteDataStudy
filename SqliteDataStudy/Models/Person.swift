//
//  Person.swift
//  SqliteDataStudy
//
//  Created by Hardik Modha on 23/03/26.
//

import Foundation
import SQLiteData

@Table("People")
struct Person: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var notes: String = ""
}

extension Person: DatabaseMigrating {
    static func migrate(using migrator: inout DatabaseMigrator) throws {
        migrator.registerMigration("Create the 'People' table") { db in
            try db.create(table: "People") { t in
                t.column("id", .text).primaryKey()
                t.column("name", .text).notNull()
                t.column("notes", .text).notNull()
            }
        }
    }
}

extension Person {
    
    static var peoples: [Person] {
        return [
            Person(name: "Hardik", notes: "He likes play cricket and programming"),
            Person(name: "Sanjay", notes: "He likes play football and designing")
        ]
    }
}

extension Person.Draft: Identifiable {}
