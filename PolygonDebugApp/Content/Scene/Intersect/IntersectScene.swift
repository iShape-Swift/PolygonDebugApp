//
//  IntersectScene.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 16.05.2023.
//

import SwiftUI

final class IntersectScene: ObservableObject, SceneContainer {
    
    let id: Int
    let title = "Intersect"
    let testStore: TestStore = IntersectTestStore()
    
    init(id: Int) {
        self.id = id
    }
    
    func makeView() -> IntersectSceneView {
        IntersectSceneView(scene: self)
    }
}
