//
//  Dictionary.swift
//  Quotes
//
//  Created by Romain Le Drogo on 28/09/2020.
//

import Foundation

extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}
