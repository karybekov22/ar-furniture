//
//  ARFurnitureApp.swift
//  ARFurniture
//
//  Created by Nursultan Karybekov on 18/4/21.
//

import SwiftUI

@main
struct ARFurnitureApp: App {
    @StateObject var placementSettings = PlacementSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}
