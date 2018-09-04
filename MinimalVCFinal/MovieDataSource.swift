//
//  MovieDataSource.swift
//  MinimalVCFinal
//
//  Created by James Rochabrun on 4/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

class MovieDataSource: NSObject, UITableViewDataSource {
    
    var movies: [Movie]
    init(movies: [Movie]) {
        self.movies = movies
        super.init()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MovieCell
        let movie = movies[indexPath.row]
        let viewModel = MovieViewModel(model: movie)
        cell.setUpWith(viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
}
