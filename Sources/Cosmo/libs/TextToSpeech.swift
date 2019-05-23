//
//  TextToSpeech.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 18/05/2019.
//  Copyright © 2019 Rasmus Wejlgaard. All rights reserved.
//

import AVFoundation
import Foundation

public class VoiceData {
    var name: String
    var langCode: String

    init(letter: String, region: String) {
        name = "\(region)-WaveNet-\(letter.uppercased())"
        langCode = region
    }
}

class Voice {
    var voiceName: VoiceData

    enum VoiceName {
        case indianMale
        case indianFemale
        case americanMale
        case americanFemale
        case australianMale
        case australianFemale
        case britishMale
        case britishFemale
        case danish
    }

    init(name: VoiceName) {
        switch name {
        case .indianMale:
            voiceName = VoiceData(letter: "C", region: "en-IN")

        case .indianFemale:
            voiceName = VoiceData(letter: "A", region: "en-IN")

        case .americanMale:
            voiceName = VoiceData(letter: "B", region: "en-US")

        case .americanFemale:
            voiceName = VoiceData(letter: "F", region: "en-US")

        case .australianMale:
            voiceName = VoiceData(letter: "B", region: "en-AU")

        case .australianFemale:
            voiceName = VoiceData(letter: "A", region: "en-AU")

        case .britishMale:
            voiceName = VoiceData(letter: "B", region: "en-GB")

        case .britishFemale:
            voiceName = VoiceData(letter: "A", region: "en-GB")

        case .danish:
            voiceName = VoiceData(letter: "A", region: "da-DK")
        }
    }
}

enum AudioEngine {
    case local
    case remote
}

class TextToSpeech {
    var chosenVoice: VoiceData
    var audioEngine: AudioEngine

    init(voiceName: Voice.VoiceName, audio: AudioEngine) {
        chosenVoice = Voice(name: voiceName).voiceName
        audioEngine = audio
        speak("Ready")
    }

    init(voiceData: VoiceData, audioEngine: AudioEngine) {
        chosenVoice = voiceData
        self.audioEngine = audioEngine
    }

    func changeVoice(voiceName: Voice.VoiceName) {
        chosenVoice = Voice(name: voiceName).voiceName
    }

    private func getSpeechData(text: String) -> String {
        let endpoint = "https://texttospeech.googleapis.com/v1/text:synthesize?key=" +
        "***REMOVED***"
        let parameters = [
            "audioConfig": [
                "audioEncoding": "LINEAR16",
                "pitch": "-4",
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
        } catch {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        var speechData: String = ""
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, _, error in
            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }
            do {
                // create json object from data
                if let json = try JSONSerialization.jsonObject(with: data,
                                                               options: .mutableContainers) as? [String: Any] {
                    speechData = json["audioContent"] as? String ?? ""
                    sem.signal()
                }
            } catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
        sem.wait()
        return speechData
    }

    func speak(_ text: String) {
        let data = getSpeechData(text: text)
        let decoded = Data(base64Encoded: data)!

        var player: AVAudioPlayer?

        print(">>> \"\(text)\"")

        do {
            player = try AVAudioPlayer(data: decoded)

            guard let player = player else { return }
            player.prepareToPlay()
            player.play()

            while player.isPlaying {}

        } catch {
            print(error.localizedDescription)
        }
    }
}
