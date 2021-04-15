//
//  JSONParser.swift
//  TodoListApp
//
//  Created by Song on 2021/04/06.
//

import Foundation

class JSONParser {
    static func parse(_ cardsData: Data, of status: String) -> [Card]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CardsData.self, from: cardsData)
            var tasks: [Task] = []
            switch status {
            case "todo":
                tasks = decodedData.todo
            case "doing":
                tasks = decodedData.doing
            case "done":
                tasks = decodedData.done
            default:
                tasks = []
            }
            let cards = tasks.map { task -> Card in
                let id = task.id
                let title = task.title
                let notes = task.contents
                let category = task.status
                return Card(id: id, title: title, notes: notes, category: category)
            }
            return cards
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
