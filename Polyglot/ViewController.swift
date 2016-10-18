//
//  ViewController.swift
//  Polyglot
//
//  Created by Thang Le Tan on 10/18/16.
//  Copyright © 2016 Thang Le Tan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var words = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let titleAttributes = [NSFontAttributeName: UIFont(name: "AmericanTypeWriter", size: 22)!, NSForegroundColorAttributeName: UIColor.blue]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewWord))
        
        title = "POLYGLOT"
        
        
        
        if let defaults = UserDefaults(suiteName: "group.com.thangcompany.Polyglot") {
            if let savedWords = defaults.object(forKey: "Words") as? [String] {
                words = savedWords
            } else {
                saveInitialWords(to: defaults)
            }
        }
    }
    
    func saveInitialWords(to defaults: UserDefaults) {
        
        words.append("bear::gau")
        words.append("camel::lac da")
        words.append("cow::bo")
        words.append("fox::cao")
        words.append("goat::de")
        words.append("monkey::khi")
        words.append("pig::heo")
        words.append("rabbit::tho")
        
        defaults.set(words, forKey: "Words")

    }
    
    func addNewWord() {
        let alert = UIAlertController(title: "Add new word", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "English"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Vietnamese"
        }
        
        let submitButton = UIAlertAction(title: "Save new word", style: .default) { (action) in
            let text1 = alert.textFields?[0].text ?? ""
            let text2 = alert.textFields?[1].text ?? ""
            self.insertFlashCard(english: text1, vietnamese: text2)
        }
        alert.addAction(submitButton)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func insertFlashCard(english: String, vietnamese: String) {
        guard english.characters.count > 0 && vietnamese.characters.count > 0 else { return }
        
        let newIndexPath = IndexPath(row: words.count, section: 0)
        words.append(english + "::" + vietnamese)
        
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        let word = words[indexPath.row]
        let split = word.components(separatedBy: "::")
        cell.textLabel?.text = split[0]
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let word = words[indexPath.row]
        let split = word.components(separatedBy: "::")
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.detailTextLabel?.text == "" {
            cell.detailTextLabel?.text = split[1]
        } else {
            cell.detailTextLabel?.text = ""
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        words.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        saveWords()
        
    }
    
    func saveWords() {
        if let defaults = UserDefaults(suiteName: "group.com.thangcompany.Polyglot") {
            defaults.set(words, forKey: "Words")
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

