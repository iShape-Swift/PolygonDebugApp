//
//  IntersectScene.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 16.05.2023.
//

import SwiftUI
import iDebug
import iPolygon
import iFixFloat

final class IntersectScene: ObservableObject, SceneContainer {

    static let colorA: Color = .red
    static let colorB: Color = .blue
    
    let id: Int
    let title = "IntersectScene"
    let pinTestStore = PinTestStore()
    var testStore: TestStore { pinTestStore }
    let editorA = ContourEditor(showIndex: true, color: PinScene.colorA)
    let editorB = ContourEditor(showIndex: true, color: PinScene.colorB)
    private (set) var overlay = [CGPoint]()
    private (set) var center = CGPoint.zero
    private (set) var areaPos = CGPoint.zero
    private (set) var area: String = ""
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        pinTestStore.onUpdate = self.didUpdateTest
        
        editorA.onUpdate = { [weak self] _ in
            self?.didUpdateEditor()
        }
        editorB.onUpdate = { [weak self] _ in
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
    
    func makeView() -> IntersectSceneView {
        IntersectSceneView(scene: self)
    }

    func editorAView() -> ContourEditorView {
        editorA.makeView(matrix: matrix)
    }
    
    func editorBView() -> ContourEditorView {
        editorB.makeView(matrix: matrix)
    }
    
    func didUpdateTest() {
        let test = pinTestStore.test
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // TODO validate convex
            self.editorA.set(points: test.pA.points)
            self.editorB.set(points: test.pB.points)
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
        let pA = editorA.points.map({ $0.fixVec })
        let pB = editorB.points.map({ $0.fixVec })

        guard !pA.isEmpty && !pB.isEmpty else { return }
        
        let ctA = pA.isConvex
        let ctB = pB.isConvex

        editorA.set(stroke: 1, color: color(convexTest: ctA, main: PinScene.colorA))
        editorB.set(stroke: 1, color: color(convexTest: ctB, main: PinScene.colorB))
        
        guard ctA == .convex && ctB == .convex else { return }

        let polygon = ConvexOverlaySolver.debugIntersect(polyA: pA, polyB: pB)
        
        self.overlay = matrix.screen(worldPoints: polygon.path.map({ $0.point }))
        self.center = matrix.screen(worldPoint: polygon.centroid.center.point) - CGPoint(x: 4, y: 4)
        self.area = "\(polygon.centroid.area.normalize)"
        self.areaPos = center + CGPoint(x: 0, y: 16)
        
        self.objectWillChange.send()
    }
    
    private func color(convexTest: ConvexTest, main: Color) -> Color {
        switch convexTest {
        case .convex:
            return main
        case .nonConvex:
            return .red
        case .degenerate:
            return .orange
        }
    }
    
    func printTest() {
        print("A: \(editorA.points.prettyPrint())")
        print("B: \(editorB.points.prettyPrint())")
    }
    
}
