//
//  MusicPlayer.swift
//  La Radio RD
//
//  Created by Giomar Rodriguez on 12/14/20.
//

import Foundation
import AVFoundation
import MediaPlayer
import SDWebImage
import Combine
import SwiftAudioEx


class MusicPlayer {
    static let shared = MusicPlayer()
    
    let isPlaying = CurrentValueSubject<Bool,Never>(false)
    let currentStation = CurrentValueSubject<Station?,Never>(nil)
    let player = QueuedAudioPlayer()
    var nowPlayingInfo = [String: Any]()
    var stations = [Station]()
    var subscription = Set<AnyCancellable>()
    
    init() {
        player.remoteCommands = [
            .play,
            .pause,
            .togglePlayPause,
            .next,
            .previous
        ]
        player.automaticallyUpdateNowPlayingInfo = true
        
        player.remoteCommandController.handleTogglePlayPauseCommand = { [weak self] (event) in
            print("play command")
            self?.togglePayPause()
            return .success
        }
        player.remoteCommandController.handleNextTrackCommand = { [weak self]  (event) in
            print("next command")
            self?.skipToNext()
            return .success
        }
        player.remoteCommandController.handlePreviousTrackCommand = { [weak self] (event) in
            print("previous command")
            self?.skipToPrevious()
            return .success
        }
        
    }
    
    func loadStationList(stations: [Station]) {
        
        self.stations = stations
        stations.publisher
            .setFailureType(to: URLError.self)
            .flatMap { station in
                URLSession.shared.dataTaskPublisher(for: station.logoUrl)
                    .map(\.data)
                    .compactMap {
                        UIImage(data: $0)
                    }
                    .compactMap {
                        DefaultAudioItem(audioUrl: station.url, artist: station.ciudad, title: station.name, sourceType: .stream, artwork: $0)
                    }
                    
            }
            .collect()
            .sink { completion in
                log.debug("Completetion: \(completion)")
            } receiveValue: { [weak self] audioItems in
                do {
                    try self?.player.add(items: audioItems, playWhenReady: false)

                } catch {
                    print(error)
                }
                
            }
            .store(in: &subscription)
    }
    func togglePayPause() {
        player.togglePlaying()
        isPlaying.value.toggle()
    }
    func skipToNext() {
        do {
            try player.next()
            updateCurrentStation()
        } catch {
            print(error)
        }
        
    }
    func skipToPrevious() {
        do {
            try player.previous()
            updateCurrentStation()
        } catch {
            print(error)
        }
        
    }
    func updateCurrentStation() {
        let item = player.currentItem?.getSourceUrl()
        let station = stations.first(where: { $0.url == item })
        print("index: \(player.currentIndex)")
        currentStation.send(station)
    }
    
    
    func playStation(with station: Station) {
        print(station.name)
        let item = player.items.firstIndex(where: { $0.getSourceUrl() == station.url})
//        if(station.name == "Monumental") {
//            //station stream is too loud
//            player.volume = 0.3
//        }else {
//            player.volume = 0.9
//        }
        do {
            guard let i = item else { return }
            try player.jumpToItem(atIndex: i)
            print("index: \(i)")
        } catch {
            print("Error \(error.localizedDescription)")
            //invalid index error
            //index is already loaded to be played
            player.play()
        }
        activateAudioSession()
        currentStation.send(station)
        isPlaying.send(true)
        print("playing stations......")
    }
    
    private func activateAudioSession() {
        try? AudioSessionController.shared.set(category: .playback)
        //...
        // You should wait with activating the session until you actually start playback of audio.
        // This is to avoid interrupting other audio without the need to do it.
        try? AudioSessionController.shared.activateSession()
    }
    func stopStation() {
        player.pause()
        isPlaying.send(false)
    }
    deinit {
        log.debug("Detroying Music Player!")
    }
    
}
