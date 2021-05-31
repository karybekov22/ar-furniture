//
//  Model.swift
//  ARFurniture
//
//  Created by Nursultan Karybekov on 19/4/21.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case kitchen
    case garden
    case toyz
    case others
    
    var label: String {
        get {
            switch self {
            case .kitchen:
                return "Kitchen"
            case .garden:
                return "Garden"
            case .toyz:
                return "Toyz"
            case .others:
                return "Others"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation : Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                
                switch loadCompletion {
                case .failure(let error): print("Unable to load modelEntity for \(filename). Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
                
            }, receiveValue: { modelEntity in
                
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                
                print("modelEntity for \(self.name) has been loaded.")
            })
    }
    
}

struct Models {
    var all: [Model] = []
    
    init() {
        // Kitchen
        let chairSwan = Model(name: "chair_swan", category: .kitchen, scaleCompensation: 0.32/100)
        let cupSaucerSet = Model(name: "cup_saucer_set", category: .kitchen)
        let teapot = Model(name: "teapot", category: .kitchen)
        
        self.all += [chairSwan, cupSaucerSet, teapot]
        
        // Garden
        let flowerTulip = Model(name: "flower_tulip", category: .garden)
        let potPlant = Model(name: "pot_plant", category: .garden, scaleCompensation: 0.32/100)
        let trowel = Model(name: "trowel", category: .garden, scaleCompensation: 0.32/100)
        let wateringcan = Model(name: "wateringcan", category: .garden, scaleCompensation: 0.32/100)
        let wheelbarrow = Model(name: "wheelbarrow", category: .garden, scaleCompensation: 0.32/100)
        
        self.all += [flowerTulip, potPlant, trowel, wateringcan, wheelbarrow]
        
        // Toyz
        let toyCar = Model(name: "toy_car", category: .toyz, scaleCompensation: 0.32/100)
        let toyDrummer = Model(name: "toy_drummer", category: .toyz, scaleCompensation: 0.32/100)
        let toyRobotVintage = Model(name: "toy_robot_vintage", category: .toyz, scaleCompensation: 0.32/100)
        let slideStylized = Model(name: "slide_stylized", category: .toyz, scaleCompensation: 0.32/100)
        let toyBiplane = Model(name: "toy_biplane", category: .toyz, scaleCompensation: 0.32/100)
        
        self.all += [toyCar, toyDrummer, toyRobotVintage, slideStylized, toyBiplane]
        
        // Others
        let gramophone = Model(name: "gramophone", category: .others, scaleCompensation: 0.32/100)
        let fenderStratocaster = Model(name: "fender_stratocaster", category: .others, scaleCompensation: 0.32/100)
        let tvRetro = Model(name: "tv_retro", category: .others, scaleCompensation: 0.32/100)

        
        self.all += [gramophone, fenderStratocaster, tvRetro]
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter( {$0.category == category} )
    }
}

