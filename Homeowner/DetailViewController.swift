//
//  DetailViewController.swift
//  Homeowner
//
//  Created by Amrit Kaur on 2019-11-15.
//  Copyright © 2019 Amrit Kaur. All rights reserved.
//

import UIKit
class DetailViewController: UIViewController {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    var item: Item!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialNumberField.text=item.serialNumber
        
           valueField.text=numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
    }
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
