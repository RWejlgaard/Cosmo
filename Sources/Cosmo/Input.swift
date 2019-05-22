//
//  Input.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 23/05/2019.
//

import Foundation

enum InputType {
    case speech
    case console
}

class Input {
    let inputType: InputType
    
    init(_ type: InputType) {
        inputType = type
    }
    
    func listen() -> String {
        if inputType == .console {
            return readLine()!
        } else if inputType == .speech {
            return ""
        }
        return ""
    }
}
