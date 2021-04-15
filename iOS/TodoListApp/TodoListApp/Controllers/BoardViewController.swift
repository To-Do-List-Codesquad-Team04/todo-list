//
//  ViewController.swift
//  TodoListApp
//
//  Created by Song on 2021/04/06.
//

import UIKit

class BoardViewController: UIViewController {
    enum Identifier {
        static let goToTodo = "goToTodo"
        static let goToDoing = "goToDoing"
        static let goToDone = "goToDone"
    }
    
    private let networkManager = NetworkManager()
    private let urlString = "http://13.125.136.48:8080/cards"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! ListViewControllerProtocol
        if segue.identifier == Identifier.goToTodo {
            destinationViewController.updateViewControllerTitle(with: "해야할 일")
            networkManager.performGetRequest(urlString: urlString, to: "todo") { cards in
                destinationViewController.updateCards(with: cards)
            }
        } else if segue.identifier == Identifier.goToDoing {
            destinationViewController.updateViewControllerTitle(with: "하고 있는 일")
            networkManager.performGetRequest(urlString: urlString, to: "doing") { cards in
                destinationViewController.updateCards(with: cards)
            }
        } else if segue.identifier == Identifier.goToDone {
            destinationViewController.updateViewControllerTitle(with: "완료한 일")
            networkManager.performGetRequest(urlString: urlString, to: "done") { cards in
                destinationViewController.updateCards(with: cards)
            }
        }
        DispatchQueue.main.async {
            destinationViewController.refreshTableView()
        }
    }
}
