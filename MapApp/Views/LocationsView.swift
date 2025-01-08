//
//  LocationsView.swift
//  MapApp
//
//  Created by Ricky Moino on 2024-12-29.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject private var vm: LocationViewModel
    let maxIpadWidth: CGFloat = 700
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            
            VStack {
                headerCard
                    
                
                Spacer()
                
                locationsPreviewStack
            }
        }
        .sheet(item: $vm.showLocationDetails, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationViewModel())
}

extension LocationsView {
    var mapLayer: some View {
        Map(coordinateRegion: $vm.mapPosition,
            annotationItems: vm.locations,
            annotationContent: { location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(vm.selectedLocation.id == location.id ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.updateSelectedLocation(location: location)
                        }
                }
            }
        )
    }
    
    var headerContent: some View {
        Button {
            vm.toggleShowList()
        } label: {
            Text(vm.selectedLocation.name + ", " + vm.selectedLocation.cityName)
                .font(.title2)
                .fontWeight(.black)
                .foregroundStyle(.primary)
                .frame(height: 55)
                .frame(maxWidth: maxIpadWidth)
                .overlay(alignment: .leading) {
                    Image(systemName: "chevron.down")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .rotationEffect(Angle(degrees: vm.showList ? 180 : 0))
                }
                .animation(.none, value: vm.selectedLocation.id)
        }
        .tint(.primary)
    }
    
    var headerCard: some View {
        VStack {
            headerContent
            
            if vm.showList {
                LocationsListView()
            }
        }
        .background(
            .thickMaterial,
            in: RoundedRectangle(cornerRadius: 10)
        )
        .padding()
    }
    
    var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if location.id == vm.selectedLocation.id {
                    LocationPreviewView(location: vm.selectedLocation)
                        .shadow(color: Color.black.opacity(0.5), radius: 10)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        ))
                        .frame(maxWidth: maxIpadWidth)
                }
            }
        }
    }
}
