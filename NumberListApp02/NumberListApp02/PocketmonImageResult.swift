//
//  PocketmonImageResult.swift
//  NumberListApp02
//
//  Created by 장은새 on 7/11/25.
//

import Foundation

struct PocketmonImageResult: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
}

struct Sprites: Decodable {
    let front_default: String
}
