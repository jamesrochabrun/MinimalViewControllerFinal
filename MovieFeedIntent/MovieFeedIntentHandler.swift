//
//  MovieFeedIntentHandler.swift
//  MinimalVCFinal
//
//  Created by James Rochabrun on 9/3/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import Foundation

class MovieFeedIntentHandler: NSObject, MovieFeedIntentHandling {
    
    func confirm(intent: MovieFeedIntent, completion: @escaping (MovieFeedIntentResponse) -> Void) {
        
        MovieService.sharedInstance.getNowPlayingMovies { result in
            switch result {
            case .Success(let dataSource):
                completion(MovieFeedIntentResponse(code: .ready, userActivity: nil))
            case .Error(let error):
                print(error)
                completion(MovieFeedIntentResponse(code: .failure, userActivity: nil))
            }
        }
    }
    
    func handle(intent: MovieFeedIntent, completion: @escaping (MovieFeedIntentResponse) -> Void) {
        
        MovieService.sharedInstance.getNowPlayingMovies { result in
            switch result {
            case .Success(let dataSource):
                
                let count = dataSource.movies.count as! NSNumber
                completion(.success(count: count))
            default: break
            }
        }
    }
}
