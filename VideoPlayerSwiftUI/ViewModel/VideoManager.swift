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
    
}
