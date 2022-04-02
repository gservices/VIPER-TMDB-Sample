//
//  MovieCell.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import UIKit

class MovieCell: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .natural
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontSizeToFitWidth = true
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.textAlignment = .left
        label.numberOfLines = 5
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViewLayout()
        self.backgroundColor = .clear
        self.selectionStyle = .default
        self.animateCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView.image = nil
    }
    
    private func setupViewLayout() {
        self.addSubview(containerView)
        self.containerView.pinToSuperview(forAtrributes: [.top, .leading], constant: 12)
        self.containerView.pinToSuperview(forAtrributes: [.trailing], constant: -12)
        self.containerView.pinToSuperview(forAtrributes: [.bottom], constant: 2)
        
        self.containerView.addSubview(thumbnailImageView)
        self.thumbnailImageView.pinToSuperview(forAtrributes: [.leading, .top], constant: 2)
        self.thumbnailImageView.pinToSuperview(forAtrributes: [.bottom], constant: -2)
        self.thumbnailImageView.pinToSuperview(forAtrributes: [.width], multiplier: 0.4)
        
        self.containerView.addSubview(nameLabel)
        self.nameLabel.pinToSuperview(forAtrributes: [.top], constant: 5)
        self.nameLabel.pin(attribute: .leading, toView: self.thumbnailImageView, toAttribute: .trailing, constant: 8)
        self.nameLabel.pinToSuperview(forAtrributes: [.trailing], constant: -8)
        
        self.containerView.addSubview(releaseDateLabel)
        self.releaseDateLabel.pin(attribute: .top, toView: self.nameLabel, toAttribute: .bottom, constant: 4)
        self.releaseDateLabel.pin(attribute: .leading, toView: self.thumbnailImageView, toAttribute: .trailing, constant: 8)
        self.releaseDateLabel.pinToSuperview(forAtrributes: [.trailing], constant: -8)
        
        self.containerView.addSubview(overViewLabel)
        self.overViewLabel.pin(attribute: .top, toView: self.thumbnailImageView, toAttribute: .centerY, constant: -16)
        self.overViewLabel.pin(attribute: .height, toView: self.thumbnailImageView, toAttribute: .height, multiplier: 0.5)
        self.overViewLabel.pin(attribute: .leading, toView: self.thumbnailImageView, toAttribute: .trailing, constant: 8)
        self.overViewLabel.pinToSuperview(forAtrributes: [.trailing], constant: -8)
    }
    
    private func animateCell() {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        self.layer.transform = rotationTransform
        self.alpha = 0.5
        UIView.animate(withDuration: 1.0) {
            self.layer.transform = CATransform3DIdentity
            self.alpha = 1.0
        }
    }
}

extension MovieCell: PopularMoviesItemView {
    func configView(with viewModel: PopularMoviesPresentable) {
        if let url = viewModel.thumbnailURL {
            self.thumbnailImageView.loadImageFromUrl(url: url)
        }
        self.nameLabel.text = viewModel.name
        self.releaseDateLabel.text = viewModel.releaseDate
        self.overViewLabel.text = viewModel.overView
    }
}
