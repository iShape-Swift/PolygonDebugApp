//
//  AreaScene.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 18.05.2023.
//

import SwiftUI
import iDebug
import iPolygon
import iFixFloat

final class AreaScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "Area"
    let areaTestStore = AreaTestStore()
    var testStore: TestStore { areaTestStore }
    let editor = PointsEditor()
    var start: CGPoint?
    var end: CGPoint?
    var polygon: [CGPoint] = []
    var areaPos: CGPoint?
    var area: String = ""
    var areaColor: Color = .gray
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        areaTestStore.onUpdate = self.didUpdateTest
        
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
    
    func makeView() -> AreaSceneView {
        AreaSceneView(scene: self)
    }

    func dotsEditorView() -> PointsEditorView {
        editor.makeView(matrix: matrix)
    }
    
    func didUpdateTest() {
        let test = areaTestStore.test
        
        let points = [test.p1, test.p0] + test.path
        
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
        let vecs = points.map { $0.fixVec }
        guard !vecs.isEmpty else { return }
        start = matrix.screen(worldPoint: vecs[0].point)
        end = matrix.screen(worldPoint: vecs[1].point)
        
        let area = vecs.area
        self.polygon = matrix.screen(worldPoints: points)
        self.area = String(format: "%.2f", area.float)
        self.areaPos = matrix.screen(worldPoint: points.reduce(.zero, { $0 + $1 }) / CGFloat(points.count))
        
        if area == 0 {
            self.areaColor = .gray.opacity(0.4)
        } else {
            self.areaColor = area > 0 ? .blue.opacity(0.4) : .red.opacity(0.4)
        }

        self.objectWillChange.send()
    }
    
}
