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
    private let pinAreaScene = PinAreaScene(id: 2)
    private let intersectScene = IntersectScene(id: 3)
    private let monotoneScene = MonotoneScene(id: 4)
    private let delaunayScene = DelaunayScene(id: 5)
    private let degenerateScene = DegenerateScene(id: 6)
    private let fixScene = FixScene(id: 7)
    private let fcwScene = FCWScene(id: 8)
    private var testStore: TestStore?

    private (set) var pIndex = PersistInt(key: "TestIndex", nilValue: 0)
    
    lazy var scenes: [SceneHandler] = [
        areaScene.handler,
        pinScene.handler,
        pinAreaScene.handler,
        intersectScene.handler,
        monotoneScene.handler,
        delaunayScene.handler,
        degenerateScene.handler,
        fixScene.handler,
        fcwScene.handler
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
        case 2:
            pinAreaScene.makeView()
        case 3:
            intersectScene.makeView()
        case 4:
            monotoneScene.makeView()
        case 5:
            delaunayScene.makeView()
        case 6:
            degenerateScene.makeView()
        case 7:
            fixScene.makeView()
        case 8:
            fcwScene.makeView()
        default:
            fatalError("scene not set")
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
            testStore = pinAreaScene.testStore
        case 3:
            testStore = intersectScene.testStore
        case 4:
            testStore = monotoneScene.testStore
        case 5:
            testStore = delaunayScene.testStore
        case 6:
            testStore = degenerateScene.testStore
        case 7:
            testStore = fixScene.testStore
        case 8:
            testStore = fcwScene.testStore
        default:
            break
        }
        
        tests = testStore?.tests ?? []
    }
}
