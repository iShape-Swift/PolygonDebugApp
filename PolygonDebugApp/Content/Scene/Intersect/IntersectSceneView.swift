//
//  IntersectSceneView.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 16.05.2023.
//

import SwiftUI

struct IntersectSceneView: View {
 
    @ObservedObject
    var scene: IntersectScene
    
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
            
            Path { path in
                path.addLines(scene.overlay)
            }.fill(.orange)
            Circle()
                .size(width: 8, height: 8)
                .offset(scene.center)
                .foregroundColor(.purple)
            Text(scene.area)
                .position(scene.areaPos)
                .font(.title2)
                .foregroundColor(.black)
            
            scene.editorAView()
            scene.editorBView()
        }.onAppear() {
            scene.onAppear()
        }
    }

}
