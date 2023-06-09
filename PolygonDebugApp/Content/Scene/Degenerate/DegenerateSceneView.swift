//
//  DegenerateSceneView.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 11.06.2023.
//

import SwiftUI

struct DegenerateSceneView: View {
 
    @ObservedObject
    var scene: DegenerateScene
    
    var body: some View {
        HStack {
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
                Spacer()
            }
            scene.editorView()
            ForEach(scene.verts) { vert in
                TVertView(vert: vert)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
