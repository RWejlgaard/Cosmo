//
//  weather.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 22/05/2019.
//

import Foundation

class Weather: ExecutionModule {
    override func triggerPhrases() -> [String] {
        return [
            "weather",
            "how is the weather",
            "how's the weather",
            "how hot is it",
            "what's the temperature",
            "what is the temperature"
        ]
    }
    
    override func action(kwargs _: [String: Any]? = nil) -> String {
        return "It's sunny with 24 degrees"
    }
}
