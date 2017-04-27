//
//  MovieViewModel.swift
//  MinimalVCFinal
//
//  Created by James Rochabrun on 4/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation

struct MovieViewModel {
    
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    var voteCount: String?

    init(model: Movie) {
        
        self.title = model.title.uppercased()
        //this endpoint is provided by the API documentation
        self.posterPath = "https://image.tmdb.org/t/p/w342" + model.posterPath
        self.overview = model.overview
        self.releaseDate = "Release date:" + " " + model.releaseDate
        self.voteCount = model.voteCount != nil ? "Number Of Reviews \(model.voteCount!)" : "No reviews"
    }
}
