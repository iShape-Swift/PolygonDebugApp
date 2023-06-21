//
//  FCWTestStore.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 18.06.2023.
//

import iDebug
import CoreGraphics

final class FCWTestStore: TestStore {
    
    private (set) var pIndex = PersistInt(key: String(describing: FCWTestStore.self), nilValue: 0)
    
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
    
    var test: FCWTest {
        data[testId]
    }
    
    let data: [FCWTest] = [
        .init(
            name: "Test 1",
            center: .zero,
            p0: CGPoint(x:   0, y:  10),
            p1: CGPoint(x:  10, y:   0),
            p2: CGPoint(x:  10, y: -10)
        ),
        .init(
            name: "Test 2",
            center: .zero,
            p0: CGPoint(x:   0, y:  10),
            p1: CGPoint(x:  10, y:   0),
            p2: CGPoint(x: -10, y: -10)
        ),
        .init(
            name: "Test 3",
            center: .zero,
            p0: CGPoint(x:   0, y:  10),
            p1: CGPoint(x: -10, y:   0),
            p2: CGPoint(x: -10, y: -10)
        )
    ]
    
}
