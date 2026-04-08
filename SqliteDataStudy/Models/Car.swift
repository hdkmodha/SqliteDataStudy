//
//  Car.swift
//  SqliteDataStudy
//
//  Created by Hardik Modha on 07/04/26.
//

import Foundation
import SQLiteData

enum Company: Int, QueryBindable, CustomStringConvertible, CaseIterable {
    case hyundai = 1
    case suzuki
    case tata
    case volkwegan
    case mahindra
    
    
    var description: String {
        switch self {
        case .hyundai:
            return "Hyundai"
        case .suzuki:
            return "MarutiSuzuki"
        case .tata:
            return "Tata"
        case .volkwegan:
            return "Volkwegan"
        case .mahindra:
            return "Mahindra"
        }
    }
}

enum CarType: Int, QueryBindable, CustomStringConvertible, CaseIterable {
    case hatchback = 1
    case suv
    case mpv
    case sedan
    
    var description: String {
        switch self {
        case .hatchback:
            return "Hatchback"
        case .suv:
            return "Sports Utility Vehicle(SUV)"
        case .mpv:
            return "Multi-Purpose Vehicle(MPV)"
        case .sedan:
            return "Sedan"
        }
    }
}

@Table("Cars")
struct Car: Identifiable {
    var id: UUID
    var name: String
    var company: Company
    var type: CarType
    var personID: Person.ID?
    
    init(id: UUID = .init(),
         name: String,
         company: Company = .hyundai,
         type: CarType = .hatchback,
         personID: Person.ID? = nil
    ) {
        self.id = id
        self.name = name
        self.company = company
        self.type = type
        self.personID = personID
    }
}

extension Car: DatabaseMigrating {
    
    static func migrate(using migrator: inout DatabaseMigrator) throws {
        migrator.registerMigration("Create table Cars") { db in
            try db.create(table: "Cars") { t in
                t.column("id", .text).primaryKey()
                t.column("name", .text).notNull()
                t.column("company", .integer).notNull()
                t.column("type", .integer).notNull()
                t.column("personID", .text).references(Person.tableName, column: "id", onDelete: .setNull)
            }
        }
    }
}
