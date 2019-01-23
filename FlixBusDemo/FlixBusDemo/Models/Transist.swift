//
//  Transist.swift
//  FlixBusDemo
//
//  Created by Waqas Sultan on 7/28/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import UIKit
class Transit: Codable {
    let throughTheStations: String
    let datetime: Datetime
    let lineDirection: String
    let rideID: Int
    let lineCode, direction: String
    
    enum CodingKeys: String, CodingKey {
        case throughTheStations = "through_the_stations"
        case datetime
        case lineDirection = "line_direction"
        case rideID = "ride_id"
        case lineCode = "line_code"
        case direction
    }
    
    init(throughTheStations: String, datetime: Datetime, lineDirection: String, rideID: Int, lineCode: String, direction: String) {
        self.throughTheStations = throughTheStations
        self.datetime = datetime
        self.lineDirection = lineDirection
        self.rideID = rideID
        self.lineCode = lineCode
        self.direction = direction
    }
}

extension Transit {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(Transit.self, from: data)
        self.init(throughTheStations: me.throughTheStations, datetime: me.datetime, lineDirection: me.lineDirection, rideID: me.rideID, lineCode: me.lineCode, direction: me.direction)
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
        throughTheStations: String? = nil,
        datetime: Datetime? = nil,
        lineDirection: String? = nil,
        rideID: Int? = nil,
        lineCode: String? = nil,
        direction: String? = nil
        ) -> Transit {
        return Transit(
            throughTheStations: throughTheStations ?? self.throughTheStations,
            datetime: datetime ?? self.datetime,
            lineDirection: lineDirection ?? self.lineDirection,
            rideID: rideID ?? self.rideID,
            lineCode: lineCode ?? self.lineCode,
            direction: direction ?? self.direction
        )
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
