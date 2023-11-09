//
//  ItemCollectionViewCell.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import UIKit
import SDWebImage


class ItemCollectionViewCell: UICollectionViewCell {
    
    let margin: CGFloat = 20.0
    var safeContentInsets: UIEdgeInsets?
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let itemDate: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = Fonts.paragraph
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TUESDAY, JUNE 6"
        return label
    }()
    
    private let itemType: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = Fonts.title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2026"
        return label
    }()
    
    private let itemTitle: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = Fonts.title
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Working from home Check-In"
        return label
    }()
    
    private let itemDescription: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = Fonts.subtitle
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "We would like to know how you feel about our work from home..."
        return label
    }()
    
    private let containerView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
    }
    
    private func addSubviews() {
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        addSubview(backgroundImageView)
        addSubview(containerView)
        containerView.addSubview(itemTitle)
        containerView.addSubview(itemDescription)
        containerView.addSubview(itemDate)
        containerView.addSubview(itemType)
        NSLayoutConstraint.activate([
            itemDate.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: margin),
            itemDate.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            itemDate.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -margin),
            
            itemType.topAnchor.constraint(equalTo: itemDate.bottomAnchor, constant: 4),
            itemType.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            itemType.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -margin),
            
            itemDescription.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -margin),
            itemDescription.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            itemDescription.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -100),
            
            itemTitle.bottomAnchor.constraint(equalTo: itemDescription.topAnchor, constant: -4),
            itemTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            itemTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -100),
            
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureCell(item: SurveyViewModel) {
        itemTitle.text = item.title
        itemDescription.text = item.description
        if let urlImage = URL(string: item.coverImageUrl) {
            backgroundImageView.sd_setImage(with: urlImage)
        }
        itemType.text = item.surveyType
        itemDate.text = item.date
    }
    
    
}
