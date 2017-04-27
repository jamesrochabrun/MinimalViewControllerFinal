//
//  MovieCell.swift
//  MinimalViewControllerTutotrial
//
//  Created by James Rochabrun on 4/26/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
    
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 40
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let movieTitleLabel: UILabel = {
        let l = UILabel()
        l.sizeToFit()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let descriptionLabel: UILabel = {
        let l = UILabel()
        l.sizeToFit()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        return l
    }()
    
    let dateLabel: UILabel = {
        let l = UILabel()
        l.sizeToFit()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        l.numberOfLines = 0
        return l
    }()
    
    let reviewsCountLabel: UILabel = {
        let l = UILabel()
        l.sizeToFit()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    func setUpViews() {
        
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(reviewsCountLabel)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            movieImageView.heightAnchor.constraint(equalToConstant: 80),
            movieImageView.widthAnchor.constraint(equalToConstant: 80),
            movieImageView.leftAnchor.constraint(equalTo: marginGuide.leftAnchor),
            movieImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 20),
            
            movieTitleLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 15),
            movieTitleLabel.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor),
            
            dateLabel.rightAnchor.constraint(equalTo: marginGuide.rightAnchor),
            dateLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 15),
            dateLabel.leftAnchor.constraint(equalTo: movieTitleLabel.leftAnchor),
            
            descriptionLabel.leftAnchor.constraint(equalTo: movieTitleLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: marginGuide.rightAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 15),
            
            reviewsCountLabel.leftAnchor.constraint(equalTo: movieTitleLabel.leftAnchor),
            reviewsCountLabel.rightAnchor.constraint(equalTo: descriptionLabel.rightAnchor),
            reviewsCountLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            reviewsCountLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -15)
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
