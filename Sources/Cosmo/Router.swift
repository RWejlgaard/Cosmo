//
//  Router.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 18/05/2019.
//  Copyright © 2019 Rasmus Wejlgaard. All rights reserved.
//

import Foundation

struct Router {
    static var activatedModules: [ExecutionModule] = [
        Weather(),
        AboutJarvis(),
        Joke()
    ]
}
