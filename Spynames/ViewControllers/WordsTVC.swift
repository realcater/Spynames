//
//  WordsTVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 20/01/2019.
//  Copyright © 2019 Dmitry Dementyev. All rights reserved.
//

import UIKit

class WordsTVC: UITableViewController {
    
    let clearCard = Card(text: "", color: .neutral)
    var words = [Card]()
    var hidden = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isEditing = true
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        addTaps(doubleTapAction: #selector(doubleTap))
        tableView.isHidden = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordsListItem", for: indexPath)
        let label = cell.viewWithTag(1000) as! UIPaddingLabel
        let word = words[indexPath.row]
        label.text = word.word
        label.backgroundColor = (word.word == "") ? K.Colors.clear : K.Colors.personalWordList[word.color]
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView,
                   shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = words[sourceIndexPath.row]
        words.remove(at: sourceIndexPath.row)
        words.insert(itemToMove, at: destinationIndexPath.row)
    }
    
}
//MARK: - Public functions
extension WordsTVC {
    func deleteRow(at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        words.remove(at: row)
        tableView.endUpdates()
    }
    func insertRow(card: Card, at row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        words.insert(card, at: indexPath.row)
        tableView.endUpdates()
    }
    func changeVisibility() {
        tableView.isHidden = !tableView.isHidden
    }
}

//MARK: - GestureRecognizer
extension WordsTVC {
    @objc private func doubleTap(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            let location = recognizer.location(in: self.view)
            let tappedRow = self.tableView.indexPathForRow(at: location)!.row
            if words[tappedRow].word == "" {
                deleteRow(at: tappedRow)
            } else {
                insertRow(card: clearCard, at: tappedRow)
            }
        }
    }
}

