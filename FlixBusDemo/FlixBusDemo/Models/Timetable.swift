//
//  Timetable.swift
//  FlixBusDemo
//
//  Created by Waqas Sultan on 7/28/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import UIKit

class Timetable: Codable {
    let arrivals, departures: [Transit]
    let message: String
    
    init(arrivals: [Transit], departures: [Transit], message: String) {
        self.arrivals = arrivals
        self.departures = departures
        self.message = message
    }
}

extension Timetable {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Timetable.self, from: data)
        self.init(arrivals: me.arrivals, departures: me.departures, message: me.message)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        arrivals: [Transit]? = nil,
        departures: [Transit]? = nil,
        message: String? = nil
        ) -> Timetable {
        return Timetable(
            arrivals: arrivals ?? self.arrivals,
            departures: departures ?? self.departures,
            message: message ?? self.message
        )
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
