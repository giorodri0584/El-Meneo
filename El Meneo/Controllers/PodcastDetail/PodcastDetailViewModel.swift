//
//  PodcastDetailViewModel.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 10/20/21.
//

import Foundation

class PodcastDetailViewModel: ObservableObject {
    @Published var episodes = [Episode]()
    
    func fetchEpisodes(showId: Int) {
        
        guard let url = URL(string: "https://api.spreaker.com/v2/shows/\(showId)/episodes?limit=15") else {
            log.debug("Invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response , error in
            if let error = error {
                log.debug("Error: \(error.localizedDescription)")
            }
            if let data = data {
                if let response = try? JSONDecoder().decode(EpisodesResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self?.episodes = response.response.items
                    }
                }
            }
        }.resume()
        
    }
}
