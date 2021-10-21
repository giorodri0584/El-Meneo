//
//  Station.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 7/17/21.
//

import Foundation
struct StationResult: Codable {
    let results: [Station]
}

struct Station: Codable {
    let objectId: String
    let name: String
    let createdAt: String
    let updatedAt: String
    let frequency: String
    let isWorking: Bool
    let ciudad: String
    let url: String
    let logoUrl: URL
}
//
//"objectId": "zojekNqeOk",
//      "name": "La Bakana",
//      "createdAt": "2021-06-29T01:50:05.326Z",
//      "updatedAt": "2021-06-29T01:53:44.476Z",
//      "frequency": "105.9",
//      "isWorking": true,
//      "ciudad": "Santiago",
//      "url": "https://radio4.domint.net:8028/stream",
//      "logoUrl"
