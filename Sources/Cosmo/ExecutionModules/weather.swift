//
//  weather.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 22/05/2019.
//

import Foundation

class Weather: ExecutionModule {
    override func action(kwargs _: [String: Any]? = nil) -> String {
        return "It's sunny with 24 degrees"
    }
}
