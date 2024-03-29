//
//  ViewController.swift
//  Project5
//
//  Created by Jacob on 13.07.2023.
//

import UIKit

class ViewController: UITableViewController{
    
    var  allWords = [String]()
    var usedWords = [String]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: Self, action: #selector(promptForAnswer))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL ){
                allWords = startWords.components(separatedBy: "\n")
            }
            
        }
        if allWords.isEmpty {
            
            allWords = ["silkworm"]
        }
    }
    func startGame(){
        
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word",for: <#T##IndexPath#>)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default)
        [weak, self, weak ac] action in
        guard let answer = ac.textFields?[0].text else {return}
        self?.submit(answer)
        ac.addAction(submitAction)
        present(ac,animated: true)
    }

}

