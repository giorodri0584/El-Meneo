//
//  Podcast.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 10/19/21.
//

import Foundation

struct Podcast: Codable {
    let showID: Int
    let title: String
    let imageURL: URL
    let imageOriginalURL: URL
    let explicit: Bool
    let authorID: Int
    let authorName: String
    let lastEpisodeAt: String
    let siteURL: URL
    let category: String

//    enum CodingKeys: String, CodingKey {
//        case showID = "show_id"
//        case title
//        case imageURL = "image_url"
//        case imageOriginalURL = "image_original_url"
//        case explicit
//        case authorID = "author_id"
//        case lastEpisodeAt = "last_episode_at"
//        case siteURL = "site_url"
//    }
}
