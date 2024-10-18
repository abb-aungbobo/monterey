//
//  Data.swift
//
//
//  Created by Aung Bo Bo on 06/05/2024.
//

import Foundation

class DataBundle {}

extension Bundle {
    public static var data: Bundle = {
        let bundleName = "Data_Data"
        
        let candidates = [
            Bundle.main.bundleURL,
            Bundle.main.resourceURL,
            Bundle(for: DataBundle.self).resourceURL,
            Bundle(for: DataBundle.self).resourceURL?.deletingLastPathComponent(),
            Bundle(for: DataBundle.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
            Bundle(for: DataBundle.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
        ]
        
        for candidate in candidates {
            let bundlePathiOS = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePathiOS.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        
        fatalError("unable to find bundle name Data_Data")
    }()
}
