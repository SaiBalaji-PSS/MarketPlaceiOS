//
//  PickupLocationMapView.swift
//  FirebaseTest
//
//  Created by Sai Balaji on 26/04/26.
//

import SwiftUI
import MapKit

struct PickupLocationMapView: View {
    var body: some View {
        Map(initialPosition: .userLocation(fallback: .automatic))
    }
}

#Preview {
    PickupLocationMapView()
}
