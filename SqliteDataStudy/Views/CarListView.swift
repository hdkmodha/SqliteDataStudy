//
//  CarListView.swift
//  SqliteDataStudy
//
//  Created by Hardik Modha on 07/04/26.
//

import Foundation
import SQLiteData
import SwiftUI

struct CarListView: View {
    
    @State private var viewModel: CarViewModel = .init()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.cars, id: \.id) { car in
                    VStack(alignment: .leading) {
                        Text(car.name)
                            .font(.headline)
                            .foregroundStyle(.black)
                        HStack(spacing: 8) {
                            Text("Car company: \(car.company.description)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            Text("Car type: \(car.type.description)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                        
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Cars")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Button {
                    self.viewModel.isPresent.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
            .sheet(isPresented: $viewModel.isPresent) {
                AddCarView(viewModel: viewModel)
                    .presentationDetents([.medium])
            }
        }
    }
    
    
    
}
