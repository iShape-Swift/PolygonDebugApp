//
//  AreaTestStore.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 18.05.2023.
//

import iDebug
import CoreGraphics

final class AreaTestStore: TestStore {
    
    private (set) var pIndex = PersistInt(key: String(describing: AreaTestStore.self), nilValue: 0)
    
    var onUpdate: (() -> ())?
    
    var tests: [TestHandler] {
        var result = [TestHandler]()
        result.reserveCapacity(data.count)
        
        for i in 0..<data.count {
            result.append(.init(id: i, title: data[i].name))
        }
        
        return result
    }
    
    var testId: Int {
        get {
            pIndex.value
        }
        
        set {
            pIndex.value = newValue
            self.onUpdate?()
        }
    }
    
    var test: AreaTest {
        data[testId]
    }
    
    let data: [AreaTest] = [
        .init(
            name: "Test 1",
            p0: CGPoint(x: -10, y: 10),
            p1: CGPoint(x: -10, y: -10),
            path: [
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10)
            ]
        ),
        .init(
            name: "Test 2",
            p0: CGPoint(x: -5, y: 5),
            p1: CGPoint(x: -5, y: -5),
            path: [
                CGPoint(x: 5, y: 5),
                CGPoint(x: 5, y: -5)
            ]
        ),
        .init(
            name: "Test 3",
            p0: CGPoint(x: -10, y: 10),
            p1: CGPoint(x: -10, y: -10),
            path: [
                CGPoint(x: 0, y: 0)
            ]
        ),
        .init(
            name: "Test 4",
            p0: CGPoint(x: -10, y: 10),
            p1: CGPoint(x: -10, y: -10),
            path: [
                CGPoint(x: 0, y: 5),
                CGPoint(x: 5, y: 0),
                CGPoint(x: 0, y: -5)
            ]
        )
    ]
    
}
