//
//  LocationMapAnnotationView.swift
//  MapApp
//
//  Created by Ricky Moino on 2024-12-30.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(.accent, in: Circle())
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .foregroundStyle(.accent)
                .padding(.bottom, 40)
            
        }
    }
}

#Preview {
    ZStack {
        Color.green.opacity(0.5)
            .ignoresSafeArea()
        
        LocationMapAnnotationView()
    }
}
