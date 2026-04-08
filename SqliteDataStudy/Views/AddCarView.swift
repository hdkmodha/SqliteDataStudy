//
//  AddCarView.swift
//  SqliteDataStudy
//
//  Created by Hardik Modha on 08/04/26.
//

import Foundation
import SwiftUI


struct AddCarView: View {
    
    @Bindable private var viewModel: CarViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: CarViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Car Details") {
                    TextField("Carname", text: $viewModel.carName)
                    HStack {
                        
                        Picker("Choose car type", selection: $viewModel.carType) {
                            ForEach(CarType.allCases, id: \.self) { type in
                                Text(type.description)
                                
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                    HStack {
                        
                        Picker("Choose car company", selection: $viewModel.carCompany) {
                            ForEach(Company.allCases, id: \.self) { company in
                                Text(company.description)
                                
                            }
                        }
                        .pickerStyle(.navigationLink)
                        
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Add New Car")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .confirm) {
                        self.viewModel.addNewCar()
                        dismiss()
                        
                    }
                }
            }
        }
    }
}

#Preview {
    AddCarView(viewModel: .init())
}
