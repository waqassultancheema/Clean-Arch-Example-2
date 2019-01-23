//
//  DateTime.swift
//  FlixBusDemo
//
//  Created by Waqas Sultan on 7/28/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import UIKit

class Datetime: Codable {
    let timestamp: Int
    let tz: String
    
    init(timestamp: Int, tz: String) {
        self.timestamp = timestamp
        self.tz = tz
    }
}

extension Datetime {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Datetime.self, from: data)
        self.init(timestamp: me.timestamp, tz: me.tz)
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
        timestamp: Int? = nil,
        tz: String? = nil
        ) -> Datetime {
        return Datetime(
            timestamp: timestamp ?? self.timestamp,
            tz: tz ?? self.tz
        )
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


