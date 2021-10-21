//
//  YoutubeVideo.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 5/26/21.
//

import Foundation

struct YoutubeVideosResult: Decodable {
    let results: [YoutubeVideo]
}

struct YoutubeVideo: Codable {
    let title: String
    let videoId: String
    let channelImageUrl: String
    let channelName: String
    let channelUrl: String
    let videoCoverImageUrl: String
}
