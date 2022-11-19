// 
//  CaseDefaultable.swift
//  CleanJSON
//
//  Created by Pircate(swifter.dev@gmail.com) on 2018/11/30
//  Copyright © 2018 Pircate. All rights reserved.
//
//  Reference: https://github.com/line/line-sdk-ios-swift/blob/master/LineSDK/LineSDK/Networking/Model/CustomizeCoding/CodingExtension.swift

import Foundation
import SwiftyBeaver

public protocol CaseDefaultable: RawRepresentable {
    
    static var defaultCase: Self { get }
    
    static func adapt(rawValue: RawValue) -> RawValue?
    
}

public extension CaseDefaultable where RawValue: FixedWidthInteger {
    
    static func adapt(rawValue: RawValue) -> RawValue? {
        return nil
    }
    
}

public extension CaseDefaultable where Self: Decodable, Self.RawValue: Decodable {
    
    init(from decoder: Decoder) throws {
        guard let _decoder = decoder as? _CleanJSONDecoder else {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(RawValue.self)
            if let value = Self.init(rawValue: rawValue) {
                self = value
            } else if let adaptedRawValue = Self.adapt(rawValue: rawValue), let value = Self.init(rawValue: adaptedRawValue) {
                #if DEBUG
                SwiftyBeaver.warning("Adapted rawValue=\(rawValue) to rawValue=\(adaptedRawValue) of \(Self.self) at \(decoder.codingPathString)", context: nil)
                #endif
                self = value
            } else {
                #if DEBUG
                SwiftyBeaver.warning("Unknown rawValue=\(rawValue) of \(Self.self) at \(decoder.codingPathString)", context: nil)
                #endif
                self = Self.defaultCase
            }
            return
        }
        
        self = try _decoder.decodeCase(Self.self)
    }
}

public protocol UppercaseDefaultable: CaseDefaultable where RawValue == String {
    
}

public extension UppercaseDefaultable {
    
    static func adapt(rawValue: RawValue) -> RawValue? {
        return rawValue.uppercased()
    }
    
}

public protocol LowercaseDefaultable: CaseDefaultable where RawValue == String {
    
}

public extension LowercaseDefaultable {
    
    static func adapt(rawValue: RawValue) -> RawValue? {
        return rawValue.lowercased()
    }
    
}

private extension _CleanJSONDecoder {
    
    func decodeCase<T>(_ type: T.Type) throws -> T
        where T: CaseDefaultable,
        T: Decodable,
        T.RawValue: Decodable
    {
        guard !decodeNil() else {
            #if DEBUG
            SwiftyBeaver.warning("Unexpected null value at \(codingPathString)", context: nil)
            #endif
            return T.defaultCase
        }
        check(storage.topContainer, as: T.RawValue.self)
        guard !storage.containers.isEmpty, storage.topContainer is T.RawValue else {
            return T.defaultCase
        }
        
        let rawValue: T.RawValue
        if let number = storage.topContainer as? NSNumber,
           (number === kCFBooleanTrue || number === kCFBooleanFalse),
           let boolRawValue = number.boolValue as? T.RawValue
        {
            rawValue = boolRawValue
        } else {
            rawValue = try decode(T.RawValue.self)
        }
        
        if let value = T.init(rawValue: rawValue) {
            return value
        } else if let adaptedRawValue = T.adapt(rawValue: rawValue), let value = T.init(rawValue: adaptedRawValue) {
            #if DEBUG
            SwiftyBeaver.warning("Adapted rawValue=\(rawValue) to rawValue=\(adaptedRawValue) of \(T.self) at \(codingPathString)", context: nil)
            #endif
            return value
        } else {
            #if DEBUG
            SwiftyBeaver.warning("Unknown rawValue=\(rawValue) of \(T.self) at \(codingPathString)", context: nil)
            #endif
            return T.defaultCase
        }
    }
}
