//
//  Variable.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 03/08/23.
//

import Foundation


var dictSignup:[String:AnyObject] = [:]

var CURRENT_TIME: String {
    get {
        return Date().description(with: Locale.current)
    }
}

var localTimeZoneIdentifier: String { return TimeZone.current.identifier }
