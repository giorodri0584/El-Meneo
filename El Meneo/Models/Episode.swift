//
//  Episode.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 10/20/21.
//

import Foundation

struct EpisodesResponse: Codable {
    let response: Response
}
struct Response: Codable {
    let items: [Episode]
    let nextURL: String

    enum CodingKeys: String, CodingKey {
        case items
        case nextURL = "next_url"
    }
}
struct Episode: Codable{
    let episodeID: Int
    let type, title: String
    let duration: Int
    let explicit: Bool
    let showID, authorID: Int
    let imageURL, imageOriginalURL: String
    let imageTransformation, publishedAt: String
    let downloadEnabled: Bool
    let streamID: Int?
    let waveformURL: String
    let siteURL: String
    let downloadURL, playbackURL: String

    enum CodingKeys: String, CodingKey {
        case episodeID = "episode_id"
        case type, title, duration, explicit
        case showID = "show_id"
        case authorID = "author_id"
        case imageURL = "image_url"
        case imageOriginalURL = "image_original_url"
        case imageTransformation = "image_transformation"
        case publishedAt = "published_at"
        case downloadEnabled = "download_enabled"
        case streamID = "stream_id"
        case waveformURL = "waveform_url"
        case siteURL = "site_url"
        case downloadURL = "download_url"
        case playbackURL = "playback_url"
    }
}

extension Episode {
    func getDuration() -> String {
        let value = duration / 1000
        let (hours, minutes, seconds) = (value / 3600, (value % 3600) / 60, (value % 3600) % 60)
        return "\(hours):\(minutes):\(seconds)"
    }
}
