//
//  ContentView.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 16.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject
    var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.scenes, selection: $viewModel.sceneId) { scene in
                Text(scene.title)
            }
        } content: {
            ZStack {
                Color.pink
                List(viewModel.tests, selection: $viewModel.testId) { test in
                    Text(test.title)
                }
            }
        } detail: {
            viewModel.sceneView
        }
        .navigationTitle("Polygon App")
        .navigationSubtitle("Test")
        .onAppear() {
            viewModel.onAppear()
        }
    }
}
