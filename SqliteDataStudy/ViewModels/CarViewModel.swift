//
//  CarViewModel.swift
//  SqliteDataStudy
//
//  Created by Hardik Modha on 07/04/26.
//

import Foundation
import Observation
import SQLiteData
import IssueReporting

@MainActor
@Observable
class CarViewModel {
    
    @ObservationIgnored
    @FetchAll(Car.order(by: \.name)) var cars: [Car]
    
    @ObservationIgnored
    @Dependency(\.defaultDatabase) var database
    
    var isPresent: Bool = false
    var carName: String = ""
    
    var carType: CarType = .hatchback
    var carCompany: Company = .hyundai
    
    
    func addNewCar() {
        
        let newCar = Car(name: self.carName, company: self.carCompany, type: self.carType)
        
        withErrorReporting {
            try database.write { db in
                try Car.upsert { newCar }
                .execute(db)
            }
        }
    }
    
}
