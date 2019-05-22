//
//  ExecutionModule.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 20/05/2019.
//

import Foundation

class ExecutionModule {
    var triggerPhrases = [""]

    func isMatch(forText: String) -> Bool {
        for trigger in triggerPhrases {
            if forText.starts(with: trigger) {
                return true
            }
        }
        return false
    }

    init(triggers: [String]) {
        triggerPhrases = triggers
    }

    // Meant to be overridden to supply functionality for ExecModule
    func action(kwargs _: [String: Any]?) -> String {
        // return output in readable string
        return "Hello World"
    }
}

class Test: ExecutionModule {
    override func action(kwargs _: [String: Any]?) -> String {
        return "test"
    }
}

class AboutJarvis: ExecutionModule {
    override func action(kwargs _: [String: Any]?) -> String {
        return "I am Jarvis. your personal assistant." +
        "I can do alot of things such as turn the lights on and off," +
        " close the door after you, or suggest an outfit for work."
    }
}

struct Execution {
    static var modules: [ExecutionModule] = [
        Test(triggers: [
            "test",
            "test this"
        ]),
        Weather(triggers: [
            "weather",
            "how is the weather",
            "how's the weather",
            "how hot is it",
            "what's the temperature",
            "what is the temperature"

        ]),
        AboutJarvis(triggers: ["what do you do"])
    ]
}
