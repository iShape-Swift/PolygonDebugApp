//
//  ContentViewModel.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 16.05.2023.
//

import SwiftUI
import iDebug

final class ContentViewModel: ObservableObject {

    private let areaScene = AreaScene(id: 0)
    private let pinScene = PinScene(id: 1)
    private let intersectScene = IntersectScene(id: 2)
    private var testStore: TestStore?

    private (set) var pIndex = PersistInt(key: "TestIndex", nilValue: 0)
    
    lazy var scenes: [SceneHandler] = [
        areaScene.handler, pinScene.handler, intersectScene.handler
    ]

    @Published
    var sceneId: Int = 0 {
        didSet {
            self.update(id: sceneId)
        }
    }
    
    @Published
    var testId: Int = 0 {
        didSet {
            testStore?.testId = testId
        }
    }
    
    @Published
    var tests: [TestHandler] = []
    

    @ViewBuilder var sceneView: some View {
        switch sceneId {
        case 0:
            areaScene.makeView()
        case 1:
            pinScene.makeView()
        default:
            intersectScene.makeView()
        }
    }
    
    func onAppear() {
        sceneId = pIndex.value
    }
    
    private func update(id: Int) {
        if sceneId != id {
            sceneId = id
        }
        
        if pIndex.value != id {
            pIndex.value = id
        }
        
        switch id {
        case 0:
            testStore = areaScene.testStore
        case 1:
            testStore = pinScene.testStore
        case 2:
            testStore = intersectScene.testStore
        default:
            break
        }
        
        tests = testStore?.tests ?? []
    }
}
