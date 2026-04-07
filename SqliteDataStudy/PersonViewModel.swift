//
//  PersonViewModel.swift
//  SqliteDataStudy
//
//  Created by Hardik Modha on 07/04/26.
//

import Foundation
import IssueReporting
import SQLiteData
import Observation
import SwiftUI

@MainActor
@Observable
class PersonViewModel {
    @ObservationIgnored
    @FetchAll(Person.none) var peoples: [Person]
    @ObservationIgnored
    @Dependency(\.defaultDatabase) var database
    var person: Person.Draft?
    var searchText: String = "" {
        didSet {
            reload()
        }
    }
    
    var searchTask: Task<Void, Never>?
    
    var isAcending: Bool = true {
        didSet {
            reload()
        }
    }
    
    public enum Action {
        case deleteButtonTapped(Person)
    }
    
    init() {
        reload()
    }
    
    func reduce(_ action: PersonViewModel.Action) {
        switch action {
        case .deleteButtonTapped(let person):
            withErrorReporting {
                try database.write { db in
                    try Person
                        .delete(person)
                        .execute(db)
                }
            }
        }
    }
    
    func reload() {
        Task {
            await reloadData()
        }
    }
    
    func reloadData() async {
        searchTask?.cancel()
        searchTask = Task {
            await withErrorReporting {
                _ = try await $peoples
                    .load(
                        Person
                            .all
                            .order {
                                if isAcending {
                                    $0.id
                                } else {
                                    $0.id.desc()
                                }
                            }
                            .where {
                                $0.name.contains(searchText) ||
                                $0.notes.contains(searchText)
                            },
                        
                        animation: .default
                    )
            }
        }
    }
}
