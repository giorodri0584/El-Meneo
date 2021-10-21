//
//  PlayerDetailController.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 7/20/21.
//

import UIKit
import SnapKit
import SDWebImage
import Combine

class PlayerDetailController: UIViewController {
    var station: Station? {
        didSet {
            coverImageView.sd_setImage(with: station?.logoUrl ?? URL(string: ""))
            labelStationName.text = station?.name
            labelSubheader.text = "\(String(describing: station?.ciudad ?? "")) - \(String(describing: station?.frequency ?? "")) FM"
        }
    }
    var subcriptions = Set<AnyCancellable>()
    let logoViewHolder: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 5.0
        view.backgroundColor = UIColor(named: "surface")

        // Set masksToBounds to false, otherwise the shadow
        // will be clipped and will not appear outside of
        // the view’s frame
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 30
        return view
    }()
    let playPauseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = UIColor(named: "controls")
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(togglePlayPauseButton), for: .touchUpInside)
        return button
    }()
    let detailsView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    let coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        return iv
    }()
    let playerControlsView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    let labelStationName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    let labelSubheader: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = UIColor(named: "controls")
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(skipToNext), for: .touchUpInside)
        return button
    }()
    let previousButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.tintColor = UIColor(named: "controls")
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(skipToPrevious), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        self.setupViews()
        MusicPlayer.shared.isPlaying
            .sink { [weak self] (isPlaying) in
                if isPlaying {
                    self?.playPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
                }else {
                    self?.playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
                }
                self?.setupViews()
            }
            .store(in: &subcriptions)
        
        MusicPlayer.shared.currentStation.sink { [weak self] station in
            print(station?.name ?? "No Name")
            self?.station = station
        }
        .store(in: &subcriptions)
        
    }
    
    @objc func togglePlayPauseButton() {
        MusicPlayer.shared.togglePayPause()
    }
    @objc func skipToNext() {
        log.debug("skipToNext()")
        MusicPlayer.shared.skipToNext()
    }
    @objc func skipToPrevious() {
        log.debug("skipToPrevious()")
        MusicPlayer.shared.skipToPrevious()
    }
    
    private func setupViews() {
        let controlsStackView = UIStackView(arrangedSubviews: [
            previousButton,
            playPauseButton,
            nextButton
        ])
        controlsStackView.axis = .horizontal
        controlsStackView.distribution = .equalSpacing
        controlsStackView.alignment = .center
        controlsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailsView)
        
        detailsView.addSubview(logoViewHolder)
        detailsView.addSubview(labelStationName)
        detailsView.addSubview(labelSubheader)
        logoViewHolder.addSubview(coverImageView)
        
        view.addSubview(playerControlsView)
        playerControlsView.addSubview(controlsStackView)
        
        
        logoViewHolder.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
        controlsStackView.snp.makeConstraints { make in
            make.leadingMargin.equalToSuperview().offset(55)
            make.trailingMargin.equalToSuperview().offset(-55)
            make.height.equalTo(70)
        }
        coverImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
        detailsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottomMargin.equalTo(playerControlsView.snp.top)
        }
        
        labelStationName.snp.makeConstraints { (make) in
            make.top.equalTo(coverImageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        labelSubheader.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(labelStationName.snp.bottom).offset(4)
        }
        
        playerControlsView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        playPauseButton.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        previousButton.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        nextButton.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
    
    
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("destroying player controller")
        
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

let deviceNames: [String] = [
    "iPhone SE",
    //"iPhone 11 Pro Max",
    //"iPad Pro (11-inch)"
]

@available(iOS 13.0, *)
struct ViewController_Preview: PreviewProvider {
  static var previews: some View {
    ForEach(deviceNames, id: \.self) { deviceName in
      UIViewControllerPreview {
        PlayerDetailController()
      }.previewDevice(PreviewDevice(rawValue: deviceName))
        .previewDisplayName(deviceName)
    }
  }
}
#endif
