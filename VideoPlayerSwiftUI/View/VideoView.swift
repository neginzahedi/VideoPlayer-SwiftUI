//
//  VideoView.swift
//  VideoPlayerSwiftUI
//
//  Created by Michael Gauthier on 2021-01-06.
//

import SwiftUI
import AVKit

struct VideoView: View {
    @ObservedObject private var manager = VideoManager.shared
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear(){
                Task {
                    do {
                        try await manager.fetchVideos()
                    } catch{
                        print("error fetch")
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
