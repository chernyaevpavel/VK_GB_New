//
//  ApiError.swift
//  VK_GB
//
//  Created by Павел Черняев on 18.07.2021.
//

import Foundation

struct ApiError: Error {
    let code: Int?
    let description: String
}
