//
//  TextToSpeech.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 18/05/2019.
//  Copyright © 2019 Rasmus Wejlgaard. All rights reserved.
//

import Foundation
import AVFoundation

public class VoiceData {
    var name: String
    var langCode: String
    
    init(letter: String, region: String) {
        self.name = "\(region)-WaveNet-\(letter.uppercased())"
        self.langCode = region
    }
}

class Voice {
    var Name: VoiceData
    
    enum VoiceName {
        case IndianMale
        case IndianFemale
        case AmericanMale
        case AmericanFemale
        case AustralianMale
        case AustralianFemale
    }
    
    init(name: VoiceName) {
        switch name {
            case .IndianMale:
                self.Name = VoiceData(letter: "C", region: "en-IN")
            
            case .IndianFemale:
                self.Name = VoiceData(letter: "A", region: "en-IN")
            
            case .AmericanMale:
                self.Name = VoiceData(letter: "B", region: "en-US")
            
            case .AmericanFemale:
                self.Name = VoiceData(letter: "F", region: "en-US")
            
            case .AustralianMale:
                self.Name = VoiceData(letter: "B", region: "en-AU")
            
            case .AustralianFemale:
                self.Name = VoiceData(letter: "A", region: "en-AU")
        }
    }
}

enum AudioEngine {
    case Local
    case Remote
}

class TextToSpeech {
    var chosenVoice: VoiceData
    var audioEngine: AudioEngine
    
    init(voiceName: Voice.VoiceName, audio: AudioEngine) {
        self.chosenVoice = Voice(name: voiceName).Name
        self.audioEngine = audio
    }
    
    func changeVoice(voiceName: Voice.VoiceName) -> Void {
        self.chosenVoice = Voice(name: voiceName).Name
    }
    
    private func getSpeechData(text: String) -> String {
        let endpoint = "https://texttospeech.googleapis.com/v1/text:synthesize?key=***REMOVED***"
        
        let parameters = [
            "audioConfig": [
                "audioEncoding": "LINEAR16",
                "pitch": "1",
                "speakingRate": "1.00"
            ],
            "input": [
                "text": text
            ],
            "voice": [
                "languageCode": self.chosenVoice.langCode,
                "name": self.chosenVoice.name
            ]
        ]
        
        let url = URL(string: endpoint)!
        let session = URLSession.shared
        let sem = DispatchSemaphore(value: 0)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var speechData: String = ""
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    speechData = json["audioContent"] as! String
                    sem.signal()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        sem.wait()
        return speechData
    }
    
    func Speak(_ text: String) -> Void {
        let data = getSpeechData(text: text)
        let decoded = Data(base64Encoded: data)!
        
        var player: AVAudioPlayer?
        
        do {
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(data: decoded)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            player.prepareToPlay()
            player.play()
            
            while player.isPlaying { }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
