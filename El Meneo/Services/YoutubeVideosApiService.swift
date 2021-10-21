//
//  YoutubeVideosApiService.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 5/26/21.
//

import Foundation

//api url https://pg-app-khvrxioa8t2tcip8u3rdpfac52za71.scalabl.cloud/1/classes
//X-Parse-Application-Id sb7n1oX0C6ahV86imtNMDSEIPgo3nr5Td8RFLVRT
//X-Parse-REST-API-Key itmgQULYggZVcbTzGs0GyPKO5OPDWMFIRdgTI9R3
//YoutubeVideos?order=-updatedAt

class YoutubeVideosApiService {
    static let shared = YoutubeVideosApiService()
    var videos = [YoutubeVideo]()
    
    func fetchYoutubeVideos(completion: @escaping ([YoutubeVideo], Error?) -> ()) {
        let requestService = ApiRequestBuilder.shared.build(urlPath: "YoutubeVideos?order=-updatedAt")
        guard let request = requestService else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("there was an error: ", error)
                return
            }
            guard let data = data else { return }
            //print(String(decoding: data, as: UTF8.self))
            
            do{
                
                let videosResult = try JSONDecoder().decode(YoutubeVideosResult.self, from: data)
                self.videos = videosResult.results
                completion(videosResult.results, nil)
                
            }catch let error {
                print("Error decoding json: ", error)
            }
        }.resume()
        
    }
    func searchVideos(searchTerm: String, completion: @escaping ([YoutubeVideo]) -> ()) {
        print(searchTerm)
        if searchTerm.isEmpty {
            completion(self.videos)
        }else {
            let filtered = videos.filter { video in
                let title = video.title.lowercased()
                let channel = video.channelName.lowercased()
                return title.contains(searchTerm.lowercased()) || channel.contains(searchTerm.lowercased())
            }
            completion(filtered)
        }
    }
}
