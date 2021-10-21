//
//  SampleShowSchedule.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 10/10/21.
//

import Foundation

class SampleShowSchedule {
    static let shared = SampleShowSchedule()
    
    func getShowSchedules() -> [ShowSchedule] {
        var schedules = [ShowSchedule]()
        
        schedules.append(
            ShowSchedule(id: "1", name: "El Gobierno de la manana", stationName: "Z Digital", time: "6:00am - 11:00am", featuredImageUrl: URL(string: "http://z101digital.com/wp-content/uploads/2018/06/gobierno-de-la-manana.jpg")!)
        )
        schedules.append(
            ShowSchedule(id: "2", name: "Esto no es radio", stationName: "Alofoke FM", time: "7:00am - 09:30am", featuredImageUrl: URL(string: "https://d3wo5wojvuv7l.cloudfront.net/t_square_limited_720/images.spreaker.com/original/3796de1cd0d6abae064540e0aa4ad319.jpg")!)
        )
        
        return schedules
    }
    
}
