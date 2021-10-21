//
//  MainTabBarController.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 6/11/21.
//

import UIKit
import SnapKit
import Combine
import LNPopupController
import SDWebImage

class MainTabBarController: UITabBarController {
    var station: Station?
    let radioTab = RadioCoordinator(navigationController: UINavigationController())
    let videoTab = VideoCoordinator(navigationController: UINavigationController())
    let podcastTab = PodcastCoordinator(navigationController: UINavigationController())
    var subcriptions = Set<AnyCancellable>()
    let vc = PlayerDetailController()
    let playPauseButtonItem: UIBarButtonItem = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 240, weight: .bold, scale: .large)
        let button = UIBarButtonItem()
        button.style = .plain
        button.image = UIImage(systemName: "pause.circle", withConfiguration: largeConfig)
        button.action = #selector(togglePlayPause)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //in IOS 15 the tab bar and navigation bars becomes transparent
        //disable that feature
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        } else {
            // Fallback on earlier versions
        }
        radioTab.start()
        podcastTab.start()
        videoTab.start()
        viewControllers = [
            podcastTab.navigationController,
            radioTab.navigationController,
            videoTab.navigationController
        ]
        navigationController?.popupBar.barStyle = .compact
        MusicPlayer.shared.isPlaying
            .sink { [weak self] (isPlaying) in
                if isPlaying {
                    self?.playPauseButtonItem.image = UIImage(systemName: "pause.circle")
                } else {
                    self?.playPauseButtonItem.image = UIImage(systemName: "play.circle")
                }
            }
            .store(in: &subcriptions)
        MusicPlayer.shared.currentStation
            .eraseToAnyPublisher()
            .sink { [weak self] station in
                log.debug("tabview: \(station?.name ?? "")")
                self?.station = station
                self?.updateMiniPlayerDetails()
        }
        .store(in: &subcriptions)
    }
    func updateMiniPlayerDetails() {
        vc.popupItem.title = self.station?.name
        vc.popupItem.subtitle = "\(station?.ciudad ?? "") - \(station?.frequency ?? "") FM"
        vc.popupItem.trailingBarButtonItems = [playPauseButtonItem]
        SDWebImageManager.shared.loadImage(
            with: station?.logoUrl,
            options: [.highPriority, .progressiveLoad],
            progress: { (receivedSize, expectedSize, url) in
                //Progress tracking code
            },
            completed: { [weak self] (image, data, error, cacheType, finished, url) in
                guard error == nil else { return }
                if let image = image {
                    self?.vc.popupItem.image = image
                }
            }
        )
    }
    func presentPlayerDetailsView() {
        presentPopupBar(withContentViewController:vc, openPopup: false,animated: true,completion:nil)
        updateMiniPlayerDetails()
        
    }
    func hidePopupBar() {
        if MusicPlayer.shared.isPlaying.value {
            MusicPlayer.shared.stopStation()
            print("calling hidepopupbar")
            dismissPopupBar(animated: true, completion: nil)
        }
        

    }
    
    @objc func togglePlayPause() {
        MusicPlayer.shared.togglePayPause()
    }

    
    deinit {
        log.debug("deinit tabbarcontroller")
    }
}
