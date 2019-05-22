//
//  ExecutionModule.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 20/05/2019.
//

import Foundation

class ExecutionModule {
    func triggerPhrases() -> [String] {
        return [""]
    }
    
    func isMatch(forText: String) -> Bool {
        for trigger in triggerPhrases() {
            if forText.starts(with: trigger) {
                return true
            }
        }
        return false
    }

    // Meant to be overridden to supply functionality for ExecModule
    func action(kwargs _: [String: Any]?) -> String {
        // return output in readable string
        return "Hello World"
    }
}
