//
//  SamplePodcasts.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 10/19/21.
//

import Foundation

class SamplePodcasts {
    static let shared = SamplePodcasts()
    func fetchPodcast() -> Podcast {
        return Podcast(
            showID: 5057937,
            title: "Esto No Es Radio",
            imageURL: URL(string: "https://d1bm3dmew779uf.cloudfront.net/large/3796de1cd0d6abae064540e0aa4ad319.jpg")!,
            imageOriginalURL: URL(string: "https://d3wo5wojvuv7l.cloudfront.net/images.spreaker.com/original/3796de1cd0d6abae064540e0aa4ad319.jpg")!,
            explicit: false,
            authorID: 14659087,
            authorName: "hero podcaster",
            lastEpisodeAt: "2021-10-01 03:25:15",
            siteURL: URL(string:"https://www.spreaker.com/show/esto-no-es-radio")!,
            category: "Comedia"
        )
    }
    func fetchPodcasts() -> [Podcast] {
        var podcasts = [Podcast]()
        podcasts.append(
            Podcast(
                showID: 5057937,
                title: "Esto No Es Radio",
                imageURL: URL(string: "https://d1bm3dmew779uf.cloudfront.net/large/3796de1cd0d6abae064540e0aa4ad319.jpg")!,
                imageOriginalURL: URL(string: "https://d3wo5wojvuv7l.cloudfront.net/images.spreaker.com/original/3796de1cd0d6abae064540e0aa4ad319.jpg")!,
                explicit: false,
                authorID: 14659087,
                authorName: "hero podcaster",
                lastEpisodeAt: "2021-10-01 03:25:15",
                siteURL: URL(string:"https://www.spreaker.com/show/esto-no-es-radio")!,
                category: "Comedia"
            )
        )
        
        return podcasts
    }
}
