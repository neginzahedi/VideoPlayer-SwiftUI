//
//  VideoManager.swift
//  VideoPlayerSwiftUI
//
//  Created by Negin Zahedi on 2024-01-15.
//

import Foundation

class VideoManager: ObservableObject {
    
    @Published var videos = [Video]()
    static let shared = VideoManager()
    
    let apiUrl = "http://localhost:4000/videos"
    
    private init(){}
    
    func fetchVideos() async throws{
        
        guard let url = URL(string: apiUrl) else {
            print("invalid url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("data recieved")
            
            let videos = try JSONDecoder().decode([Video].self, from: data)
            
            DispatchQueue.main.async {
                self.videos = videos.sorted(by: { $0.publishedAt > $1.publishedAt })
                print("Videos updated and sorted")
                print(videos)
            }
        } catch{
            print("Failed to fetch videos with error: \(error)")
        }
    }
}
