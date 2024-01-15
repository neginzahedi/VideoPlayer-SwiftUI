//
//  VideoManager.swift
//  VideoPlayerSwiftUI
//
//  Created by Negin Zahedi on 2024-01-15.
//

import Foundation

enum FetchError: Error {
    case invalidURL
    case failedToFetch(Error)
}

class VideoManager: ObservableObject {
    
    @Published var videos = [Video]()
    static let shared = VideoManager()
    
    let apiUrl = "http://localhost:4000/videos"
    
    private init(){}
    
    func fetchVideos() async throws{
        
        guard let url = URL(string: apiUrl) else {
            throw FetchError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let videos = try JSONDecoder().decode([Video].self, from: data)
            
            DispatchQueue.main.async {
                self.videos = videos.sorted(by: { $0.publishedAt > $1.publishedAt })
            }
            
        } catch{
            throw FetchError.failedToFetch(error)
        }
    }
}
