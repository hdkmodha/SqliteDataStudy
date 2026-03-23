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
    let id: UUID
    var name: String = ""
    var birthDate: Date?
    var notes: String = ""
}

extension Person: DatabaseMigrating {
    static func migrate(using migrator: inout DatabaseMigrator) throws {
        migrator.registerMigration("Create the 'People' table") { db in
            try db.create(table: "People") { t in
                t.column("id", .text).primaryKey()
                t.column("name", .text).notNull()
                t.column("birthDate", .date)
                t.column("notes", .text).notNull()
            }
        }
    }
}
