//
//  main.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 17/05/2019.
//  Copyright © 2019 Rasmus Wejlgaard. All rights reserved.
//

import Foundation
import CoreAudio
import CoreAudioKit

var name = "jarvis"

func main() {
    let voice = TextToSpeech(voiceName: .britishMale, audio: .local)
    let inp = Input(.console)

    while true {
        let text = inp.listen()

        var moduleFound = false
        for mod in Router.activatedModules {
            if mod.isMatch(forText: text) {
                moduleFound = true
                voice.speak(mod.action(kwargs: nil))
            }
        }
        if !moduleFound {
            voice.speak(text)
        }
    }
}

main()
