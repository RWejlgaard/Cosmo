//
//  Router.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 18/05/2019.
//  Copyright © 2019 Rasmus Wejlgaard. All rights reserved.
//

import Foundation

enum OutputType {
    case Speech
    case Console
    case SpeechAndConsole
}

class Output {
    var OutputType: OutputType
    let tts: TextToSpeech = TextToSpeech(voiceName: .IndianMale, audio: .Local)
    
    init(type: OutputType) {
        self.OutputType = type
    }
    
    private func formatConsoleOutput(_ text: String) -> String {
        return "COSMO >> \"\(text.capitalized)\""
    }
    
    func out(_ text: String) -> Void {
        if self.OutputType == .Console {
            print(formatConsoleOutput(text))
        }
        else if self.OutputType == .Speech {
            tts.Speak(text)
        }
        else if self.OutputType == .SpeechAndConsole {
            print("\(formatConsoleOutput(text))")
            tts.Speak(text)
        }
    }
}



class Router {
    
}
