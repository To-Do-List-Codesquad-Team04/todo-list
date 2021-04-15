//
//  CardsData.swift
//  TodoListApp
//
//  Created by Song on 2021/04/15.
//

import Foundation

struct CardsData: Codable {
    let todo: [Task]
    let doing: [Task]
    let done: [Task]
}

struct Task: Codable {
    let id: Int
    let title: String
    let contents: String
    let status: String
    let dateTime: String
}
