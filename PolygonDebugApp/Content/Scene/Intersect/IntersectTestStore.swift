//
//  IntersectTestStore.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 16.05.2023.
//

import iDebug

final class IntersectTestStore: TestStore {
    
    private (set) var pIndex = PersistInt(key: String(describing: IntersectTestStore.self), nilValue: 0)
    
    var tests: [TestHandler] = [
        .init(id: 0, title: "0a"),
        .init(id: 1, title: "1a"),
        .init(id: 2, title: "2a"),
        .init(id: 3, title: "3a"),
        .init(id: 4, title: "4a")
    ]
    
    var testId: Int {
        get {
            pIndex.value
        }
        
        set {
            pIndex.value = newValue
        }
    }

}
