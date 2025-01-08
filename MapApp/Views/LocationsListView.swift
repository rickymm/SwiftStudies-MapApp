//
//  LocationsListView.swift
//  MapApp
//
//  Created by Ricky Moino on 2024-12-29.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var vm: LocationViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.updateSelectedLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                .listRowBackground(Color.clear)
                .padding(.vertical, 8)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationViewModel())
}

extension LocationsListView {
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .frame(width: 55, height: 55)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
