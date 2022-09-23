// 
//  JSONAdapter.swift
//  CleanJSON
//
//  Created by Pircate(swifter.dev@gmail.com) on 2018/12/13
//  Copyright © 2018 Pircate. All rights reserved.
//

import Foundation

public protocol JSONAdapter {
    
    func adapt(_ decoder: CleanDecoder) throws -> Bool
    
    func adapt(_ decoder: CleanDecoder) throws -> Int
    
    func adapt(_ decoder: CleanDecoder) throws -> Int8
    
    func adapt(_ decoder: CleanDecoder) throws -> Int16
    
    func adapt(_ decoder: CleanDecoder) throws -> Int32
    
    func adapt(_ decoder: CleanDecoder) throws -> Int64
    
    func adapt(_ decoder: CleanDecoder) throws -> UInt
    
    func adapt(_ decoder: CleanDecoder) throws -> UInt8
    
    func adapt(_ decoder: CleanDecoder) throws -> UInt16
    
    func adapt(_ decoder: CleanDecoder) throws -> UInt32
    
    func adapt(_ decoder: CleanDecoder) throws -> UInt64
    
    func adapt(_ decoder: CleanDecoder) throws -> Float
    
    func adapt(_ decoder: CleanDecoder) throws -> Double
    
    func adapt(_ decoder: CleanDecoder) throws -> String
    
    func adapt(_ decoder: CleanDecoder) throws -> Date
    
    func adapt(_ decoder: CleanDecoder) throws -> Data
    
    func adapt(_ decoder: CleanDecoder) throws -> Decimal
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Bool?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Int?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Int8?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Int16?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Int32?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Int64?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> UInt?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> UInt8?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> UInt16?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> UInt32?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> UInt64?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Float?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Double?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> String?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Date?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Data?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> URL?
    
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Decimal?
    
    func adaptIfPresent<T: Decodable>(_ decoder: CleanDecoder) throws -> T?
}

public extension JSONAdapter {
    
    private func adaptInteger<I: FixedWidthInteger & Defaultable>(_ decoder: CleanDecoder) throws -> I {
        guard !decoder.decodeNil() else { return I.defaultValue }
        
        guard let stringValue = try decoder.decodeIfPresent(String.self) else {
            return I.defaultValue
        }
        
        return I(stringValue) ?? I.defaultValue
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> Bool {
        return Bool.defaultValue
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> Int {
        return try adaptInteger(decoder)
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> Int8 {
        return try adaptInteger(decoder)
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> Int16 {
        return try adaptInteger(decoder)
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> Int32 {
        return try adaptInteger(decoder)
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> Int64 {
        return try adaptInteger(decoder)
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> UInt {
        return try adaptInteger(decoder)
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> UInt8 {
        return try adaptInteger(decoder)
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> UInt16 {
        return try adaptInteger(decoder)
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> UInt32 {
        return try adaptInteger(decoder)
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> UInt64 {
        return try adaptInteger(decoder)
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> Float {
        guard !decoder.decodeNil() else { return Float.defaultValue }
        
        guard let stringValue = try decoder.decodeIfPresent(String.self) else {
            return Float.defaultValue
        }
        
        return Float(stringValue) ?? Float.defaultValue
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> Double {
        guard !decoder.decodeNil() else { return Double.defaultValue }
        
        guard let stringValue = try decoder.decodeIfPresent(String.self) else {
            return Double.defaultValue
        }
        
        return Double(stringValue) ?? Double.defaultValue
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> String {
        guard !decoder.decodeNil() else { return String.defaultValue }
        
        return String(describing: decoder.topContainer)
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> Date {
        guard let decoder = decoder as? _CleanJSONDecoder else { return Date.defaultValue }
        
        return Date.defaultValue(for: decoder.options.dateDecodingStrategy)
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> Data {
        return Data.defaultValue
    }
    
    @inline(__always)
    func adapt(_ decoder: CleanDecoder) throws -> Decimal {
        return Decimal.defaultValue
    }
}

public extension JSONAdapter {
    
    private func adaptIntegerIfPresent<I: FixedWidthInteger & Defaultable>(_ decoder: CleanDecoder) throws -> I? {
        guard !decoder.decodeNil() else { return nil }
        
        guard let stringValue = try decoder.decodeIfPresent(String.self) else {
            return nil
        }
        
        return I(stringValue)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Bool? {
        guard !decoder.decodeNil() else { return nil }
        if let string: String = try decoder.decodeIfPresent(String.self) {
            if string == "true" {
                return true
            } else if string == "false" {
                return false
            } else if let double = Double(string) {
                return double != 0
            }
        }
        return nil
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Int? {
        return try adaptIntegerIfPresent(decoder)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Int8? {
        return try adaptIntegerIfPresent(decoder)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Int16? {
        return try adaptIntegerIfPresent(decoder)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Int32? {
        return try adaptIntegerIfPresent(decoder)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Int64? {
        return try adaptIntegerIfPresent(decoder)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> UInt? {
        return try adaptIntegerIfPresent(decoder)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> UInt8? {
        return try adaptIntegerIfPresent(decoder)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> UInt16? {
        return try adaptIntegerIfPresent(decoder)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> UInt32? {
        return try adaptIntegerIfPresent(decoder)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> UInt64? {
        return try adaptIntegerIfPresent(decoder)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Float? {
        guard !decoder.decodeNil() else { return nil }
        
        guard let stringValue = try decoder.decodeIfPresent(String.self) else {
            return nil
        }
        
        return Float(stringValue)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Double? {
        guard !decoder.decodeNil() else { return nil }
        
        guard let stringValue = try decoder.decodeIfPresent(String.self) else {
            return nil
        }
        
        return Double(stringValue)
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> String? {
        return nil
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Date? {
        return nil
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Data? {
        return nil
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> URL? {
        return nil
    }
    
    @inline(__always)
    func adaptIfPresent(_ decoder: CleanDecoder) throws -> Decimal? {
        return nil
    }
    
    @inline(__always)
    func adaptIfPresent<T: Decodable>(_ decoder: CleanDecoder) throws -> T? {
        return nil
    }
}

extension CleanJSONDecoder {
    
    struct Adapter: JSONAdapter {}
}
