//
//  AnswersData.swift
//  MagicBall
//
//  Created by Alex Hanina on 1/22/22.
//

import Foundation

import Foundation

struct AnswersData: Codable {
    let magic: Magic
}

struct Magic: Codable {
    let question: String
    let answer: String
    let type: String
}
