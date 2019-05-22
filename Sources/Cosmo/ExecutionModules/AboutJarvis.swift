//
//  AboutJarvis.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 23/05/2019.
//

import Foundation

class AboutJarvis: ExecutionModule {
    override func triggerPhrases() -> [String] {
        return [
            "what do you do"
        ]
    }
    
    override func action(kwargs _: [String: Any]?) -> String {
        return "I am Jarvis. your personal assistant. " +
            "I can do alot of things such as turn the lights on and off," +
        " close the door for you, or suggest an outfit for work."
    }
}
