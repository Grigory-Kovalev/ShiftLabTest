//
//  NetworkServiceModel.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 24.09.2023.
//

import Foundation

struct ContestDTO: Codable {
    let name: String
    let startTime: String
    let endTime: String

    enum CodingKeys: String, CodingKey {
        case name
        case startTime = "start_time"
        case endTime = "end_time"
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
