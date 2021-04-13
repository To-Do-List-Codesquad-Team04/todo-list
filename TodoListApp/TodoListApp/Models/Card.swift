//
//  Card.swift
//  TodoListApp
//
//  Created by Song on 2021/04/06.
//

import Foundation
import MobileCoreServices

final class Card: NSObject,
            NSItemProviderWriting,
            NSItemProviderReading,
            Codable {
    //This function actually has a return type of Self, but that really messes things up when you are trying to return your object, so if you mark your class as final as I've done above, the you can change the return type to return your class type.
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Card {
        let decoder = JSONDecoder()
        do {
            //Here we decode the object back to it's class representation and return it
            let card = try decoder.decode(Card.self, from: data)
            return card
        } catch {
            fatalError()
        }
    }
    
    var title: String
    var desc: String
    let createdAt: Date
    let category: String
    
    init(title: String, description: String, category: String) {
        self.title = title
        self.desc = description
        self.createdAt = Date()
        self.category = category
    }
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        //We know that we want to represent our object as a data type, so we'll specify that
        return [kUTTypeData as String]
    }
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            //Here the object is encoded to a JSON data object and sent to the completion handler
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return progress
    }
    static var readableTypeIdentifiersForItemProvider: [String] {
        //We know we want to accept our object as a data representation, so we'll specify that here
        return [kUTTypeData as String]
    }
    
    func replaceTitle(with newTitle: String) {
        title = newTitle
    }
    
    func replaceDescription(with newDescription: String) {
        desc = newDescription
    }
}
