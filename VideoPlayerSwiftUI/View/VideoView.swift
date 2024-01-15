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
    
    @State private var player = AVPlayer()
    @State private var index = 0
    @State private var isPlaying = false
    
    var body: some View {
        VStack{
            // View Title
            Text("Video Player")
                .bold()
                .padding(.top, 80)
            
            if !manager.videos.isEmpty {
                // Video
                VideoPlayer(player: player)
                    .disabled(true) // hide dafault controls
                    .frame(height: 250)
                    .overlay(playerControls(), alignment: .center)
                // Details
                videoDetails()
                    .padding()
            }
            
        }
        .ignoresSafeArea()
        .onAppear(){
            Task {
                do {
                    try await manager.fetchVideos()
                    updatePlayer()
                } catch{
                    print("error fetch")
                }
            }
        }
    }
    
    // Update the player with the current video
    private func updatePlayer(){
        let newPlayer = AVPlayerItem(url: manager.videos[index].hlsURL)
        self.player.replaceCurrentItem(with: newPlayer)
    }
    
    // Custom player controls view
    func playerControls() -> some View{
        HStack(spacing: 80) {
            // Previous Button
            Button(action: {
                if index - 1 >= 0 {
                    index -= 1
                    updatePlayer()
                }
            }) {
                Image("previous")
                    .opacity(index == 0 ? 0.2 : 1.0)
            }
            .disabled(index == 0)
            
            
            // Play/Pause Button
            Button(action: {
                if isPlaying {
                    player.pause()
                } else {
                    player.play()
                }
                isPlaying.toggle()
            }) {
                Image(isPlaying ? "pause" : "play")
            }
            
            // Next Button
            Button(action: {
                if index + 1 < manager.videos.count {
                    index += 1
                    updatePlayer()
                }
            }) {
                Image("next")
                    .opacity(index + 1 == manager.videos.count ? 0.2 : 1.0)
            }
            .disabled(index + 1 == manager.videos.count)
        }
    }
    
    func videoDetails() -> some View{
        ScrollView {
            VStack(alignment: .leading){
                HStack{
                    Text(manager.videos[index].title)
                    Spacer()
                }
                HStack{
                    Text(manager.videos[index].author.name)
                    Spacer()
                }
            }
            .padding()
            
            Text(manager.videos[index].description)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
