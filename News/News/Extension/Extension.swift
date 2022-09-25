//
//  Extension.swift
//  News
//
//  Created by Zensar on 25/09/22.
//

import Foundation
import UIKit

// MARK: - Date Extension
extension String {
    func  UTCToShortLocal() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        dateFormatter.dateFormat = "h:mm a"
        let dateString = dateFormatter.string(from: date)
        return dateString.lowercased()
    }
    func  UTCToLongLocal() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        dateFormatter.dateFormat = "E, d MMM yyyy h:mm a"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
