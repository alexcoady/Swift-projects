//
//  FourLines.swift
//  13 - Persistence
//
//  Created by Alex Coady on 18/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import Foundation

class FourLines: NSObject, NSCoding, NSCopying {
    
    var lines: [String]!
    let linesKey = "linesKey"
    
    
    // Necessary to confirm with NSCoding
    override init () {}
    
    
    // Necessary to confirm with NSCoding
    required init (coder aDecoder: NSCoder) {
        
        // Optional (as?) because the key:value pair might not exist
        lines = aDecoder.decodeObjectForKey(linesKey) as? [String]
    }
    
    
    // Necessary to confirm with NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        
        if let saveLines = lines {
            aCoder.encodeObject(saveLines, forKey: linesKey)
        }
    }
    
    
    // Necessary to confirm with NSCopying
    func copyWithZone(zone: NSZone) -> AnyObject {
        
        let copy = FourLines()
        
        if var linesToCopy = lines {
            
            var newLines = Array<String>()
            for line in linesToCopy {
                newLines.append(line)
            }
            copy.lines = newLines
        }
        
        return copy
    }
}