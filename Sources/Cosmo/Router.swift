//
//  Router.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 18/05/2019.
//  Copyright © 2019 Rasmus Wejlgaard. All rights reserved.
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
