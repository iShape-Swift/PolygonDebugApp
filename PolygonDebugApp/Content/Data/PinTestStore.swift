//
//  PinTestStore.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 16.05.2023.
//

import iDebug
import CoreGraphics

final class PinTestStore: TestStore {
    
    private (set) var pIndex = PersistInt(key: String(describing: PinTestStore.self), nilValue: 0)
    
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
    
    var test: SimplePolygonTest {
        data[testId]
    }
    
    let data: [SimplePolygonTest] = [
        .init(
            name: "Two Rect 1",
            pA: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ]
            ),
            pB: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x:   0, y: -5),
                    CGPoint(x:   0, y:  5),
                    CGPoint(x:  20, y:  5),
                    CGPoint(x:  20, y: -5)
                ]
            )
        ),
        .init(
            name: "Two Rect 2",
            pA: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -5, y: -10),
                    CGPoint(x: -5, y:  10),
                    CGPoint(x:  15, y:  10),
                    CGPoint(x:  15, y: -10)
                ]
            ),
            pB: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -10, y: -5),
                    CGPoint(x: -10, y:  15),
                    CGPoint(x:  10, y:  15),
                    CGPoint(x:  10, y: -5)
                ]
            )
        ),
        .init(
            name: "Two Rect 3",
            pA: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -10.0, y: -10.0),
                    CGPoint(x: -10.0, y: 10.0),
                    CGPoint(x: 10.0, y: 10.0),
                    CGPoint(x: 10.0, y: -10.0)
                ]
            ),
            pB: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -5.0, y: -20.0),
                    CGPoint(x: -5.0, y: 20.0),
                    CGPoint(x: 5.0, y: 20.0),
                    CGPoint(x: 5.0, y: -20.0)
                ]
            )
        ),
        .init(
            name: "Two Rect 4",
            pA: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -10.0, y: -10.0),
                    CGPoint(x: -10.0, y: 10.0),
                    CGPoint(x: 10.0, y: 10.0),
                    CGPoint(x: 10.0, y: -10.0)
                ]
            ),
            pB: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x:  0.0, y:-15.0),
                    CGPoint(x:-15.0, y:  0.0),
                    CGPoint(x:  0.0, y: 15.0),
                    CGPoint(x: 15.0, y:   0.0)
                ]
            )
        ),
        .init(
            name: "Two Rect 5",
            pA: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x:  0.0, y:-15.0),
                    CGPoint(x:-15.0, y:  0.0),
                    CGPoint(x:  0.0, y: 15.0),
                    CGPoint(x: 15.0, y:   0.0)
                ]
            ),
            pB: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -10.0, y: -10.0),
                    CGPoint(x: -10.0, y: 10.0),
                    CGPoint(x: 10.0, y: 10.0),
                    CGPoint(x: 10.0, y: -10.0)
                ]
            )
        ),
        .init(
            name: "Two Rect 6",
            pA: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -10.0, y: -10.0),
                    CGPoint(x: -10.0, y: 10.0),
                    CGPoint(x: 10.0, y: 10.0),
                    CGPoint(x: 10.0, y: -10.0)
                ]
            ),
            pB: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x:  0.0, y:-20.0),
                    CGPoint(x:-20.0, y:  0.0),
                    CGPoint(x:  0.0, y: 20.0),
                    CGPoint(x: 20.0, y:   0.0)
                ]
            )
        ),
        .init(
            name: "Two Rect 7",
            pA: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x:  0.0, y:-20.0),
                    CGPoint(x:-20.0, y:  0.0),
                    CGPoint(x:  0.0, y: 20.0),
                    CGPoint(x: 20.0, y:   0.0)
                ]
            ),
            pB: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -10.0, y: -10.0),
                    CGPoint(x: -10.0, y: 10.0),
                    CGPoint(x: 10.0, y: 10.0),
                    CGPoint(x: 10.0, y: -10.0)
                ]
            )
        ),
        .init(
            name: "Two Rect 8",
            pA: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -10.0, y: -10.0),
                    CGPoint(x: -10.0, y: 10.0),
                    CGPoint(x: 10.0, y: 10.0),
                    CGPoint(x: 10.0, y: -10.0)
                ]
            ),
            pB: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -10.0, y: -10.0),
                    CGPoint(x: -10.0, y: 10.0),
                    CGPoint(x: 10.0, y: 10.0),
                    CGPoint(x: 10.0, y: -10.0)
                ]
            )
        ),
        .init(
            name: "Two Rect 9",
            pA: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -10.0, y: -10.0),
                    CGPoint(x: -10.0, y: 10.0),
                    CGPoint(x: 10.0, y: 10.0),
                    CGPoint(x: 10.0, y: -10.0)
                ]
            ),
            pB: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -20.0, y: -10.0),
                    CGPoint(x: -20.0, y:   0.0),
                    CGPoint(x:  10.0, y:   0.0),
                    CGPoint(x:  10.0, y: -10.0)
                ]
            )
        ),
        .init(
            name: "Two Rect 11",
            pA: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -10.0, y: -10.0),
                    CGPoint(x: -10.0, y: 10.0),
                    CGPoint(x: 10.0, y: 10.0),
                    CGPoint(x: 10.0, y: -10.0)
                ]
            ),
            pB: PolygonData(
                isConvex: true,
                points: [
                    CGPoint(x: -10.0, y: -10.0),
                    CGPoint(x: -5.0, y: 10.0),
                    CGPoint(x: 5.0, y: 10.0),
                    CGPoint(x: 5.0, y: -20.0)
                ]
            )
        )
        
    ]

}
