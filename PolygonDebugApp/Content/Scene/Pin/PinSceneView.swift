//
//  PinSceneView.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 16.05.2023.
//

import SwiftUI

struct PinSceneView: View {
 
    @ObservedObject
    var scene: PinScene
    
    var body: some View {
        return HStack {
            GeometryReader { proxy in
                content(size: proxy.size)
            }
        }
    }
    
    private func content(size: CGSize) -> some View {
        scene.initSize(screenSize: size)
        return ZStack {
            Color.white
            VStack {
                Button("Print Test") {
                    scene.printTest()
                }.buttonStyle(.borderedProminent).padding()
                Button("Solve") {
                    scene.solve()
                }.buttonStyle(.borderedProminent).padding()
                HStack {
                    Text("Polygon A").font(.title2).foregroundColor(PinScene.colorA)
                    Text("Polygon B").font(.title2).foregroundColor(PinScene.colorB)
                }
                Spacer()
            }
            scene.editorAView()
            scene.editorBView()
            ForEach(scene.dots) { dot in
                PinDotView(dot: dot)
            }
            ForEach(scene.sections) { sec in
                Path { path in
                    path.addLines(sec.pathA)
                }.stroke(style: .init(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .foregroundColor(sec.color)
                Path { path in
                    path.addLines(sec.pathB)
                }.stroke(style: .init(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .foregroundColor(sec.color)
            }
            
        }.onAppear() {
            scene.onAppear()
        }
    }

}
