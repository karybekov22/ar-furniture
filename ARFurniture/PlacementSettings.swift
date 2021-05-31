//
//  PlacementSettings.swift
//  ARFurniture
//
//  Created by Nursultan Karybekov on 20/4/21.
//

import SwiftUI
import ReplayKit
import Combine

class PlacementSettings: ObservableObject {
    
    // When the user selects a model in BrowseView, this propetty is set.
    @Published var selectedModel: Model? {
        willSet(newValue) {
            print("Setting selected model \(String(describing: newValue?.name))")
        }
    }
    
    // When the user taps confirm in PlacementView, the value of selectedModel is assigned to confirmedModel.
    @Published var confirmedModel: Model? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmedModel")
                return
            }
            
            print("Setting confirmed to \(model.name)")
        }
    }
    
    // This property retains the cancellable object for our SceneEvents.Update subscriber
    var sceneObserver: Cancellable?
    
}

