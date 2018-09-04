//
//  IntentHandler.swift
//  MovieFeedIntent
//
//  Created by James Rochabrun on 9/3/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        guard intent is MovieFeedIntent else { fatalError() }
        return MovieFeedIntentHandler()
    }
}
