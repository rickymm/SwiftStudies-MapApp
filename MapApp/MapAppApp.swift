//
//  MapAppApp.swift
//  MapApp
//
//  Created by Ricky Moino on 2024-12-28.
//

import SwiftUI

@main
struct MapAppApp: App {
    @StateObject private var vm = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
