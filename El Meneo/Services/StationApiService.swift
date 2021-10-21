//
//  StationApiService.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 7/17/21.
//

import Foundation

class StationApiService {
    static let shared = StationApiService()
    
    func fetchStations(completion: @escaping ([Station], Error?) -> Void) {
        let requestService = ApiRequestBuilder.shared.build(urlPath: "Stations")
        
        guard let request = requestService else {
            return
        }
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                print("Error fetching stations: \(error.localizedDescription)")
                completion([], error)
            }
            guard let data = data else { return }
            //print(String(decoding: data, as: UTF8.self))
            
            do {
                let result = try JSONDecoder().decode(StationResult.self, from: data)
                completion(result.results, nil)
            } catch {
                print("Error decoding json: \(error.localizedDescription)")
                completion([], error)
            }
        }.resume()
    }
}
