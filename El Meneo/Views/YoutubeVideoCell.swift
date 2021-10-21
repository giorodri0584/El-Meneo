//
//  YoutubeVideoCell.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 5/25/21.
//

import UIKit
import SDWebImage

class YoutubeViewCell: UICollectionViewCell {
    static let identifier = "YoutubeViewCell"
    
    var video: YoutubeVideo! {
        didSet {
            titleLabel.text = video.title
            channelLabel.text = video.channelName
            
            avatarImageView.sd_setImage(with: URL(string: video.channelImageUrl))
            coverImageView.sd_setImage(with: URL(string: video.videoCoverImageUrl))
        }
    }
    
    let coverImageView: UIImageView = {
        let image = UIImageView()
        //image.heightAnchor.constraint(equalToConstant: 220).isActive = true
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        image.layer.cornerRadius = 40 / 2
        image.clipsToBounds = true
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "This the video title"
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    let channelLabel: UILabel = {
        let label = UILabel()
        label.text = "Capricornio TV"
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            channelLabel
        ])
        
        labelStackView.axis = .vertical
        
        let infoStackView = UIStackView(arrangedSubviews: [
            avatarImageView,
            labelStackView
        ])
        infoStackView.spacing = 12
        infoStackView.alignment = .center
        infoStackView.isLayoutMarginsRelativeArrangement = true
        infoStackView.layoutMargins.left = 10
        infoStackView.layoutMargins.right = 10
        
        
        let overallStackView = UIStackView(arrangedSubviews: [
            coverImageView,
            infoStackView
        ])
        overallStackView.axis = .vertical
        overallStackView.spacing = 12
        
        addSubview(overallStackView)
        
        //16:9 aspect ration on the cover image
        coverImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 9.0/16.0).isActive = true
        
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        overallStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
