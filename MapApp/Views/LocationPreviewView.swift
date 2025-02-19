//
//  LocationPreview.swift
//  MapApp
//
//  Created by Ricky Moino on 2024-12-30.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject private var vm: LocationViewModel
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                
                titleSection
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                learnMoreButton
                
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    let vm = LocationViewModel()
    let location = vm.locations.first
    LocationPreviewView(location: location!)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green.opacity(0.5))
        .environmentObject(vm)
}

extension LocationPreviewView {
    var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding(6)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    
    var titleSection: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    var learnMoreButton: some View {
        Button {
            vm.learnMoreButtonPressed(location: location)
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    var nextButton: some View {
        Button {
            vm.nextButtonPressed(location: location)
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
