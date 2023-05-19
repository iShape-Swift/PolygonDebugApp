//
//  PinScene.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 16.05.2023.
//

import SwiftUI
import iDebug
import iConvex
import iFixFloat

struct Section: Identifiable {
    
    let id: Int
    let color: Color
    let pathA: [CGPoint]
    let pathB: [CGPoint]
}



final class PinScene: ObservableObject, SceneContainer {

    static let colorA: Color = .green
    static let colorB: Color = .blue
    
    let id: Int
    let title = "Pin"
    let pinTestStore = PinTestStore()
    var testStore: TestStore { pinTestStore }
    let editorA = ContourEditor(showIndex: true, color: PinScene.colorA)
    let editorB = ContourEditor(showIndex: true, color: PinScene.colorB)
    
    var dots: [PinDot] = []
    var sections: [Section] = []
    
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
    
    func makeView() -> PinSceneView {
        PinSceneView(scene: self)
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
        
        let pins = CrossSolver.intersect(a: pA, b: pB).pins
        
        dots.removeAll()
        for i in 0..<pins.count {
            let d = pins[i].dot
            let center = matrix.screen(worldPoint: d.p.point)
            dots.append(.init(id: i, center: center, color: .red, title: "Pin \(i)"))
        }
        
        
        let secs = IntersectSolver.debugIntersect(a: pA, b: pB)
        
        self.sections.removeAll()
        
        for i in 0..<secs.count {
            let sec = secs[i]
            let aPath = sec.a.map({ $0.point })
            let bPath = sec.b.map({ $0.point })
            let color = Color(index: i)
            sections.append(.init(
                id: i,
                color: color,
                pathA: matrix.screen(worldPoints: aPath),
                pathB: matrix.screen(worldPoints: bPath)
            ))
        }
        
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
