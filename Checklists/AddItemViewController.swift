//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 Johnny la Détente All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    
    var itemToEdit : ChecklistItem!
    
    var delegate: ItemDetailViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit != nil)
        {
            textField.text = itemToEdit.text
        }
        
        
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close()
    {
        delegate?.itemDetailViewControllerDidCancel(controller: self)
    }
    
    @IBAction func done()
    {
        if itemToEdit != nil {
            itemToEdit.text = textField.text!
            delegate?.itemDetailViewController(controller: self, didFinishEditingItem: itemToEdit!)
        }
        else {
            delegate?.itemDetailViewController(controller: self, didFinishAddingItem: ChecklistItem(text: textField.text!))
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let beforeText: NSString = textField.text! as NSString
        let afterText: NSString = beforeText.replacingCharacters(in: range, with: string) as NSString
        
        if afterText.length > 0 {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
        
        return true
    }
    
    
}

protocol ItemDetailViewControllerDelegate : class
{
    func itemDetailViewControllerDidCancel(controller:ItemDetailViewController
    )
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}
