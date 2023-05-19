//
//  SceneContainer.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 16.05.2023.
//

struct SceneHandler: Identifiable {
    
    let id: Int
    let title: String
}

protocol SceneContainer {

    var id: Int { get }
    var title: String { get }
    var testStore: TestStore { get }
}

extension SceneContainer {
    
    var handler: SceneHandler {
        SceneHandler(id: id, title: title)
    }
    
}
