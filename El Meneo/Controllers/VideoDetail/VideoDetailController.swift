//
//  VideoDetailController.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 5/28/21.
//

import UIKit
import WebKit

class VideoDetailController: UIViewController {
    var video: YoutubeVideo?
    var videos: [YoutubeVideo]?
    var webPlayer: WKWebView!
    
    let videoView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the title of the video"
        label.numberOfLines = 2
        return label
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        //(tabBarController as! MainTabBarController).showPopupBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        (tabBarController as! MainTabBarController).hidePopupBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdManager.shared.loadInterstitialAd(controller: self)
        
        
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        guard var videos = videos else {
            fatalError("Error with videos")
        }
        guard let video = video else {
            fatalError("Error getting video")
        }
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        
        DispatchQueue.main.async {
            self.webPlayer = WKWebView(frame: self.videoView.bounds, configuration: webConfiguration)
            self.videoView.addSubview(self.webPlayer)
                    
            guard let videoURL = URL(string: "https://www.youtube.com/embed/\(video.videoId)?playsinline=1") else { return }
                    let request = URLRequest(url: videoURL)
                    self.webPlayer.load(request)
        }
        
        videos.shuffle()
        guard let controller = self.navigationController else {
            print("Error parsing controller")
            return
        }
        let moreVideos = MoreVideosListController(videos: videos, controller: controller)
        
        let infoStackView = UIStackView(arrangedSubviews: [
            titleLabel
        ])
        
        setupViewData()
        
        view.addSubview(videoView)
        view.addSubview(infoStackView)
        view.addSubview(moreVideos)

        moreVideos.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(16)
            make.leadingMargin.equalToSuperview()
            make.trailingMargin.equalToSuperview()
            make.bottomMargin.equalToSuperview()
        }
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 16).isActive = true
        infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        videoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        videoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9.0/16.0).isActive = true
        
    }
    
    func setupViewData() {
        titleLabel.text = video?.title
    }
    
    deinit {
        //(tabBarController as! MainTabBarController).showPopupBar()
        print("deinit: VideoDetailController")
    }
}
