//
//  RadioShowCell.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 10/6/21.
//

import UIKit
import SnapKit
import SDWebImage

class RadioShowCell: UICollectionViewCell {
    static let identifier = "RadioShowCell"
    var radioShow: ShowSchedule? {
        didSet {
            showTitleLabel.text = radioShow?.name
            showCaptionLabel.text = "Por: \(radioShow?.stationName ?? "") - \(radioShow?.time ?? "")"
            backgroundImageView.sd_setImage(with: radioShow?.featuredImageUrl)
        }
    }
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "gobierno")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.60)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return view
    }()
    let showTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "El Gobierno de la manana"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .white
        return label
    }()
    let showCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Por Z Digital - 06:00AM - 11:00AM"
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.textColor = UIColor(white: 0.75, alpha: 1)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
    }
    
    private func setupViews() {
        addSubview(backgroundImageView)
        addSubview(overlayView)
        overlayView.addSubview(showTitleLabel)
        overlayView.addSubview(showCaptionLabel)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        overlayView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        showTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
        }
        showCaptionLabel.snp.makeConstraints { make in
            make.top.equalTo(showTitleLabel.snp_bottomMargin).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct RadioShowCell_Preview: PreviewProvider {
  static var previews: some View {
    UIViewPreview {
      let cell = RadioShowCell() // change the view name to preview
      return cell
    }.previewLayout(.sizeThatFits)
     .padding(10)
  }
}
#endif

