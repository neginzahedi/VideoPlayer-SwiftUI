//
//  Video.swift
//  VideoPlayerSwiftUI
//
//  Created by Negin Zahedi on 2024-01-15.
//

import Foundation

struct Video: Codable {
    let id: String
    let title: String
    let hlsURL: URL
    let fullURL: URL
    let description: String
    let publishedAt: String
    let author: Author
}
