//
//  ListViewController.swift
//  TodoListApp
//
//  Created by Song on 2021/04/13.
//

import UIKit
import MobileCoreServices

class ListViewController: UIViewController, ListViewControllerProtocol, PopupViewDelegate, UITableViewDragDelegate, UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        //
        let destinationIndexPath = coordinator.destinationIndexPath
        for dropItem in coordinator.items {
            if let sourceIndexPath = dropItem.sourceIndexPath {
                moveCard(at: sourceIndexPath, to: destinationIndexPath!, in: cardTableView)
                coordinator.drop(dropItem.dragItem, toRowAt: destinationIndexPath!)
            } else {
                //print(tableView) // drop이 일어나는 tableView (destination)
                dropItem.dragItem.itemProvider.loadObject(ofClass: Card.self, completionHandler: { (data, error) in
                    if let subject = data as? Card {
                        self.cards.append(subject)
                        //self.cards.insert(subject, at: destinationIndexPath!.item)
                        DispatchQueue.main.async {
                            self.refreshTableView()
                        }
                    }
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let card = cards[indexPath.section]
        let itemProvider = NSItemProvider(object: card)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
    @IBOutlet weak var headerView: ListHeaderView!
    @IBOutlet weak var cardTableView: UITableView!
    var cards: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.title = self.title
        headerView.badgeButton.setTitle("\(cards.count)", for: .normal)
        headerView.badgeButton.layer.masksToBounds = true
        headerView.badgeButton.layer.cornerRadius = headerView.frame.size.height / 2
        
        cardTableView.dataSource = self
        cardTableView.delegate  = self
        cardTableView.register(CardCell.nib(), forCellReuseIdentifier: CardCell.identifier)
        cardTableView.sectionFooterHeight = 0.0
        
        headerView.addButton.addTarget(self, action: #selector(showPopupViewController), for: .touchUpInside)
        
        cardTableView.dragDelegate = self
        cardTableView.dropDelegate = self
        cardTableView.dragInteractionEnabled = true
    }
    
    func filterCards(of category: String, from allCards: [Card]) {
        cards = allCards.filter { card in
            card.category == category
        }
    }
    
    func refreshTableView() {
        cardTableView.reloadData()
        headerView.badgeButton.setTitle("\(cards.count)", for: .normal)
    }
    
    @objc func showPopupViewController() {
        let popupVC = PopupViewController(nibName: "PopupViewController", bundle: nil)
        popupVC.modalPresentationStyle = .formSheet
        popupVC.modalTransitionStyle = .coverVertical
        popupVC.preferredContentSize = CGSize(width: 400.0, height: 175.0)
        popupVC.delegate = self
        self.present(popupVC, animated: true, completion: nil)
    }
    
    func registerButtonPressed(title: String, description: String) {
        cards.append(Card(title: title, description: description, category: cards.first?.category ?? ""))
        refreshTableView()
    }
    
    func updateViewControllerTitle(with listName: String) {
        self.title = listName
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        DispatchQueue.main.async {
            cell.titleLabel.text = self.cards[indexPath.section].title
            cell.descriptionLabel.text = self.cards[indexPath.section].description
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (action, view, success) in
            self.cards.remove(at: indexPath.section)
            self.refreshTableView()
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func moveCard(at sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath, in tableView: UITableView) {
        tableView.performBatchUpdates({ () -> Void in
            let card = cards[sourceIndexPath.section]
            cards.remove(at: sourceIndexPath.section)
            cards.insert(card, at: destinationIndexPath.section)
            //refreshTableView()
            cardTableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            cardTableView.insertRows(at: [destinationIndexPath], with: .automatic)
        }, completion: nil)
    }
}
