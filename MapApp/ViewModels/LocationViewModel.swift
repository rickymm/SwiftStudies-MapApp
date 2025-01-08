//
//  LocationViewModel.swift
//  MapApp
//
//  Created by Ricky Moino on 2024-12-29.
//

import Foundation
import SwiftUI
import MapKit

class LocationViewModel: ObservableObject {
    @Published var locations: [Location] = []
    @Published var selectedLocation: Location {
        didSet {
            updateMapPosition(location: selectedLocation)
        }
    }
    @Published var showList: Bool = false
    @Published var showLocationDetails: Location? = nil
    
    @Published var mapPosition: MKCoordinateRegion = MKCoordinateRegion()
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.selectedLocation = locations.first!
        self.updateMapPosition(location: locations.first!)
    }
    
    private func updateMapPosition(location: Location) {
        mapPosition = MKCoordinateRegion(
                center: location.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
    }
    
    func updateSelectedLocation(location: Location) {
        withAnimation(.easeInOut) {
            selectedLocation = location
            showList = false
        }
    }
    
    func toggleShowList() {
        withAnimation(.easeInOut) {
            showList.toggle()
        }
    }
    
    func nextButtonPressed(location: Location) {
        guard let currentIndex = locations.firstIndex(where: { $0.id == location.id }) else {
            print("Couldn't find the current location in the list.")
            return
        }
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            guard let firstLocation = locations.first else { return }
            updateSelectedLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        updateSelectedLocation(location: nextLocation)
    }
    
    func learnMoreButtonPressed(location: Location) {
        showLocationDetails = location
    }
}
