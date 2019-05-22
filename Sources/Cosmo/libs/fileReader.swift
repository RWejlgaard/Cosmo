//
//  fileReader.swift
//  Cosmo
//
//  Created by Rasmus Wejlgaard on 21/05/2019.
//

import Foundation

class FileReader {
    var filename: String
    var fileExtension: String
    init(_ filename: String, fileExtension: String) {
        self.filename = filename
        self.fileExtension = fileExtension
    }
}
