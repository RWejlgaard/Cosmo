//
//  main.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 17/05/2019.
//  Copyright © 2019 Rasmus Wejlgaard. All rights reserved.
//

import Foundation

var name = "jarvis"

func main() {
    let voice = TextToSpeech(voiceName: .indianMale, audio: .local)
    let inp = Input(.console)

    while true {
        let text = inp.listen()

        voice.speak(text)

        for mod in Router.modules {
            if mod.isMatch(forText: text) {
                voice.speak(mod.action(kwargs: nil))
            }
        }
    }
}

main()
