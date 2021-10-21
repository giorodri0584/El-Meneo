//
//  ApiRequestBuilder.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 7/17/21.
//

import Foundation

class ApiRequestBuilder {
    static let shared = ApiRequestBuilder()
    
    func build(urlPath: String) -> URLRequest? {
        let urlString = "https://pg-app-khvrxioa8t2tcip8u3rdpfac52za71.scalabl.cloud/1/classes/\(urlPath)"
        guard let url = URL(string: urlString) else {
            print("Error creating url")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("sb7n1oX0C6ahV86imtNMDSEIPgo3nr5Td8RFLVRT", forHTTPHeaderField: "X-Parse-Application-Id")
        request.setValue("itmgQULYggZVcbTzGs0GyPKO5OPDWMFIRdgTI9R3", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        return request
    }
}
