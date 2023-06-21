//
//  FCWScene.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 18.06.2023.
//
import SwiftUI
import iDebug
import iPolygon
import iFixFloat

struct FCWEdge: Identifiable {
    let id: Int
    let color: Color
    let p0: CGPoint
    let p1: CGPoint
}

final class FCWScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "FCW"
    let fcwTestStore = FCWTestStore()
    var testStore: TestStore { fcwTestStore }
    let editor = PointsEditor()
    var edges = [FCWEdge]()
    
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        fcwTestStore.onUpdate = self.didUpdateTest
        
        editor.onUpdate = { [weak self] _ in
            self?.didUpdateEditor()
        }
    }
    
    func initSize(screenSize: CGSize) {
        if !matrix.screenSize.isIntSame(screenSize) {
            matrix = Matrix(screenSize: screenSize, scale: 10, inverseY: true)
            DispatchQueue.main.async { [weak self] in
                self?.solve()
            }
        }
    }
    
    func makeView() -> FCWSceneView {
        FCWSceneView(scene: self)
    }

    func dotsEditorView() -> PointsEditorView {
        editor.makeView(matrix: matrix)
    }
    
    func didUpdateTest() {
        let test = fcwTestStore.test

        let points = [test.center, test.p0, test.p1, test.p2]
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.editor.set(points: points)
            self.solve()
        }
    }
    
    func didUpdateEditor() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // TODO validate convex
            self.solve()
        }
    }
    
    func onAppear() {
        didUpdateTest()
    }

    func solve() {
        let points = editor.points
        guard !points.isEmpty else { return }

        let screenPoints = matrix.screen(worldPoints: points)
        
        edges.removeAll()
        
        let center = points[0].fix
        let start = points[1].fix
        let p0 = points[2].fix
        let p1 = points[3].fix
        
        let isFirst = FCWScene.isFirstClockwise(center: center, start: start, p0: p0, p1: p1)
        
        edges.append(.init(id: 0, color: .black, p0: screenPoints[0], p1: screenPoints[1]))
        edges.append(.init(id: 1, color: isFirst ? .green : .gray, p0: screenPoints[0], p1: screenPoints[2]))
        edges.append(.init(id: 2, color: !isFirst ? .green : .gray, p0: screenPoints[0], p1: screenPoints[3]))

        self.objectWillChange.send()
    }
    
    
    private static func isFirstClockwise(center: FixVec, start: FixVec, p0: FixVec, p1: FixVec) -> Bool {
        let v0 = center - start
        let v1 = center - p0
        let v2 = center - p1
        
        let c1 = v0.unsafeCrossProduct(v1)
        let c2 = v0.unsafeCrossProduct(v2)
        
        if c1 == 0 || c2 == 0 {

            let c1Dot = v0.unsafeDotProduct(v1)
            let c2Dot = v0.unsafeDotProduct(v2)
            
            if c1 == 0 && c2 == 0 {
                if c1Dot > 0 && c2Dot > 0 || c1Dot < 0 && c2Dot < 0 {
                    debugPrint("0 - 1")
                    let d1 = v1.sqrLength
                    let d2 = v2.sqrLength
                    if c1Dot > 0 {
                        debugPrint("0 - 2")
                        return d1 < d2
                    } else {
                        debugPrint("0 - 3")
                        return d1 > d2
                    }
                } else {
                    debugPrint("0 - 4")
                    return c1Dot < 0
                }
            } else if c1 == 0 {
                if c1Dot > 0 {
                    debugPrint("c1 - 0")
                    return false
                } else {
                    debugPrint("c1 - 1")
                    return c2 > 0
                }
            } else {
                if c2Dot > 0 {
                    debugPrint("c2 - 0")
                    return true
                } else {
                    debugPrint("c2 - 1")
                    return c1 < 0
                }
            }
        } else {
            if c1 > 0 {
                if c2 > 0 {
                    debugPrint("1 - 1")
                    return v1.unsafeCrossProduct(v2) < 0
                } else {
                    debugPrint("1 - 2")
                    return false
                }
            } else {
                if c2 > 0 {
                    debugPrint("2 - 1")
                    return true
                } else {
                    debugPrint("2 - 2")
                    return v1.unsafeCrossProduct(v2) < 0
                }
            }
        }
    }
    
}
