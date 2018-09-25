//
//  Bulldog.swift
//  Bulldog
//
//  Created by Suraj Pathak on 19/11/16.
//  Copyright © 2016 Suraj Pathak. All rights reserved.
//

import Foundation

/// Any key type that should be scripted conform to this protocol PathType. For eg. String, Int
public protocol PathType {}
extension String: PathType {}
extension Int: PathType {}

/// Bulldog is a super-fast json parser that will keep attacking until it gets the value you desire, or you give up. Just like a bulldog.

public struct Bulldog {
    let json: Any
    
    // MARK: Initializer
    public init(json: Any) {
        self.json = json
    }
    
    // MARK: Public Methods
    public func value<T: Equatable>(_ keyPath: PathType...) -> T? {
        return raw(keyPath) as? T
    }
    
    public func string(_ keyPath: PathType...) -> String? {
        return raw(keyPath) as? String
    }
    
    public func int(_ keyPath: PathType...) -> Int? {
        return raw(keyPath) as? Int
    }
	
	// Returns int value, even if the original value is in string type
	public func intPromised(_ keyPath: PathType...) -> Int? {
		if let value = raw(keyPath) as? Int {
			return value
		} else if let value = raw(keyPath) as? String, let intValue = Int(value) {
			return intValue
		} else {
			return nil
		}
	}
    
    public func double(_ keyPath: PathType...) -> Double? {
        return raw(keyPath) as? Double
    }
	
	// Returns double value, even if the original value is in string type
	public func doublePromised(_ keyPath: PathType...) -> Double? {
		if let value = raw(keyPath) as? Double {
			return value
		} else if let value = raw(keyPath) as? String, let doubleValue = Double(value) {
			return doubleValue
		} else {
			return nil
		}
	}
    
    public func bool(_ keyPath: PathType...) -> Bool {
        return raw(keyPath) as? Bool ?? false
    }

    public func dictionary(_ keyPath: PathType...) -> [String: Any]? {
        return raw(keyPath) as? [String: Any]
    }
    
    public func array(_ keyPath: PathType...) -> [Any]? {
        return raw(keyPath) as? [Any]
    }
    
    public func rawJson(_ keyPath: PathType...) -> Any? {
        return raw(keyPath)
    }
	
	public func bulldog(_ keyPath: String...) -> Bulldog? {
		guard let json = raw(keyPath) else { return nil }
		return Bulldog(json: json)
	}
    
    // MARK: Private methods
    private func raw(_ keyPath: [PathType]) -> Any? {
        let count = keyPath.count
        var finalJson: Any? = json
        for i in 0..<count {
            let path = keyPath[i]
            if let dictPath = path as? String {
                if let newJson = finalJson as? [String: Any] {
                    finalJson = newJson[dictPath]
                } else {
                    return nil
                }
            } else if let arrayPath = path as? Int {
                if let newJson = finalJson as? [Any], arrayPath < newJson.count {
                    finalJson = newJson[arrayPath]
                } else {
                    return nil
                }
            }
        }
        return finalJson
    }
    
}
