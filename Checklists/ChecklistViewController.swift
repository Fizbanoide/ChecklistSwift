//
//  ViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 Johnny la Détente. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
var checklistitem = [ChecklistItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        checklistitem.append(ChecklistItem(text: "Se lever à l'heure"))
        checklistitem.append(ChecklistItem(text: "Coder un joli projet"))
        checklistitem.append(ChecklistItem(text: "Manger Macdal"))
        checklistitem.append(ChecklistItem(text: "Faire le plein"))
        checklistitem.append(ChecklistItem(text: "Rentrer à la maison"))
        checklistitem.append(ChecklistItem(text: "Jouer comme un ouf"))
        checklistitem.append(ChecklistItem(text: "Rattraper mon sommeil de retard"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return checklistitem.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for:
            indexPath)
        //cell.textLabel?.text = checklistitem[indexPath.row].text
        configureTextFor(cell: cell, withItem: checklistitem[indexPath.row])
        configureCheckmarkFor(cell: cell, withItem: checklistitem[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        checklistitem[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    func configureCheckmarkFor(cell: UITableViewCell, withItem item: ChecklistItem){
        if item.checked {
            cell.viewWithTag(6)?.isHidden = true;
        }
        else {
            cell.viewWithTag(6)?.isHidden = false;

        }
    }
    
    func configureTextFor(cell: UITableViewCell, withItem item: ChecklistItem){
        (cell.viewWithTag(5) as? UILabel)?.text = item.text
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        checklistitem.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddItem", let destination = segue.destination as? UINavigationController, let viewController = destination.topViewController as? AddItemViewController
        {
            viewController.delegate = self
        }
        else if segue.identifier == "EditItem", let destination = segue.destination as? UINavigationController, let viewController = destination.topViewController as? AddItemViewController
        {
            viewController.delegate = self
            viewController.itemToEdit = checklistitem[(tableView.indexPath(for: (sender as! UITableViewCell))?.row)!]
            
            
        }
    }
    
    
}

extension ChecklistViewController: AddItemViewControllerDelegate
{
    func addItemViewControllerDidCancel(controller: AddItemViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
        controller.dismiss(animated: true, completion: nil)
        checklistitem.append(item)
        tableView.insertRows(at: [IndexPath(item: checklistitem.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
    }
    
    func addItemViewController(controller: AddItemViewController, didFinishEditingItem item: ChecklistItem) {
        controller.dismiss(animated: true, completion: nil)
        print(checklistitem.index(where: {$0 === item}))
        tableView.reloadRows(at: [IndexPath(item: checklistitem.index(where: {$0 === item})!, section: 0)], with: UITableViewRowAnimation.automatic)
    }
}

