//
//  LocationDetailView.swift
//  MapApp
//
//  Created by Ricky Moino on 2024-12-30.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @EnvironmentObject var vm: LocationViewModel
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                imageSection
                
            
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    
                    Divider()
                    
                    descriptionSection
                    
                    Divider()
                    
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
        .foregroundStyle(.primary)
    }
}

#Preview {
    let vm = LocationViewModel()
    let location = vm.locations.first!
    LocationDetailView(location: location)
        .environmentObject(vm)
}

extension LocationDetailView {
    var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { locationImage in
                Image(locationImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    
    var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .foregroundStyle(.blue)
            }
        }
    }
    
    var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [location],
            annotationContent: { location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .shadow(radius: 10)
                }
            }
        )
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    
    var backButton: some View {
        Button {
            vm.showLocationDetails = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundStyle(.primary)
                .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 4)
                .padding()
        }
    }
}
