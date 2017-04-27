//
//  Movie.swift
//  MinimalViewControllerTutotrial
//
//  Created by James Rochabrun on 4/26/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation

struct Movie {
    
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    var coverPath: String?
    var voteCount: NSNumber?
}

extension Movie {
    
    struct Key {
        static let titleKey = "title"
        static let posterPathKey = "poster_path"
        static let overviewKey = "overview"
        static let releaseDateKey = "release_date"
        static let coverPathKey = "backdrop_path"
        static let votesKey = "vote_count"
    }
    
    init?(json: [String: AnyObject]) {
        
        guard let title = json[Key.titleKey] as? String,
            let posterPath = json[Key.posterPathKey] as? String,
            let overview = json[Key.overviewKey] as? String,
            let releaseDate = json[Key.releaseDateKey] as? String
            else {
                return nil
        }
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.coverPath = json[Key.coverPathKey] as? String
        self.voteCount = json[Key.votesKey] as? NSNumber ?? 0
    }
}
