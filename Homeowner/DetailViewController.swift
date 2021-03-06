//
//  DetailViewController.swift
//  Homeowner
//
//  Created by Amrit Kaur on 2019-11-15.
//  Copyright © 2019 Amrit Kaur. All rights reserved.
//

import UIKit
class DetailViewController: UIViewController, UITextFieldDelegate,
UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: Any]) {
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // Store the image in the ImageStore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var imageView: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text =
            numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        // Get the item key
        let key = item.itemKey
        // If there is an associated image with the item
        // display it on the image view
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
}
