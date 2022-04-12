//
//  StringExtension.swift
//  GoGuards
//
//  Created by Abhishek Agarwal on 26/08/21.
//  Copyright © 2021 Deepak. All rights reserved.
//

import Foundation

extension String {
    func nameAbbreviated() -> String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(
            from: self
        ) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return self
    }
    
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }

    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
}

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
