//
//  Station.swift
//  FlixBusDemo
//
//  Created by Waqas Sultan on 7/23/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//


import Foundation

class Station: Codable {
    let timetable: Timetable
    
    init(timetable: Timetable) {
        self.timetable = timetable
    }
}






// MARK: Convenience initializers and mutators

extension Station {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Station.self, from: data)
        self.init(timetable: me.timetable)
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
        timetable: Timetable? = nil
        ) -> Station {
        return Station(
            timetable: timetable ?? self.timetable
        )
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}







