// 
//  Defaultable.swift
//  CleanJSON
//
//  Created by Pircate(swifter.dev@gmail.com) on 2018/12/14
//  Copyright © 2018 Pircate. All rights reserved.
//

import Foundation

protocol Defaultable {
    static var defaultValue: Self { get }
}

extension Bool: Defaultable {
    static var defaultValue: Bool {
        return false
    }
}

extension AdditiveArithmetic {
    static var defaultValue: Self {
        return Self.zero
    }
}

extension Int: Defaultable {}
extension Int8: Defaultable {}
extension Int16: Defaultable {}
extension Int32: Defaultable {}
extension Int64: Defaultable {}
extension UInt: Defaultable {}
extension UInt8: Defaultable {}
extension UInt16: Defaultable {}
extension UInt32: Defaultable {}
extension UInt64: Defaultable {}
extension Float: Defaultable {}
extension Double: Defaultable {}
extension Decimal: Defaultable {}

extension String: Defaultable {
    static var defaultValue: String {
        return ""
    }
}

extension URL: Defaultable {
    static var defaultValue: URL {
        return URL(fileURLWithPath: "")
    }
}

extension Date: Defaultable {
    static var defaultValue: Date {
        return Date(timeIntervalSinceReferenceDate: 0)
    }
    
    static func defaultValue(for strategy: JSONDecoder.DateDecodingStrategy) -> Date {
        switch strategy {
        case .secondsSince1970, .millisecondsSince1970:
            return Date(timeIntervalSince1970: 0)
        default:
            return defaultValue
        }
    }
}

extension Data: Defaultable {
    static var defaultValue: Data {
        return Data()
    }
}
