//
//  DynamicValue.swift
//  WeatherForecast
//
//  Created by Sohanur Rahman on 4/6/23.
//

import UIKit

public struct DynamicValue: Codable {
    
    let numValue: Double
    let stringValue: String

    // Where we determine what type the value is
    public init(from decoder: Decoder) throws {
        let container =  try decoder.singleValueContainer()

        // Check for a Double
        do {
            numValue = try container.decode(Double.self)
            stringValue = ""
        } catch {
            // Check for an integer
            stringValue = try container.decode(String.self)
            numValue = Double(stringValue) ?? 0
        }
    }

    // We need to go back to a dynamic type, so based on the data we have stored, encode to the proper type
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try stringValue.isEmpty ? container.encode(numValue) : container.encode(stringValue)
    }
}
