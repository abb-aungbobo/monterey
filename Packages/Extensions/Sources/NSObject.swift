//
//  NSObject.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import Foundation

extension NSObject {
    public static var identifier: String {
        return String(describing: self)
    }
}
