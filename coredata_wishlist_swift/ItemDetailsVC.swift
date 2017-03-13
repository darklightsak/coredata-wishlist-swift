//
//  ItemDetailsVC.swift
//  coredata_wishlist_swift
//
//  Created by Surasak Wattanapradit on 3/6/2560 BE.
//  Copyright © 2560 Surasak Wattanapradit. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var PriceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    var countRowPicker :Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil) //ตั้งให้ navigation bar ไม่ขึ้นชื่อยาวๆของหน้าที่แล้ว
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
            let store = Store(context: context)
            print(countRowPicker)
            store.name = "Paragon"
            let store2 = Store(context: context)
            store2.name = "Central"
            let store3 = Store(context: context)
            store3.name = "Tops"
            let store4 = Store(context: context)
            store4.name = "Gourmet Market"
            let store5 = Store(context: context)
            store5.name = "The Mall"
            let store6 = Store(context: context)
            store6.name = "Robinson"
            let store7 = Store(context: context)
            store7.name = "Big C"
            let store8 = Store(context: context)
            store8.name = "Tesco Lotus"
            let store9 = Store(context: context)
            store9.name = "Makro"
            let store10 = Store(context: context)
            store10.name = "Home Pro"
            let store11 = Store(context: context)
            store11.name = "Ikea"
            let store12 = Store(context: context)
            store12.name = "7-11"
            let store13 = Store(context: context)
            store13.name = "Other"
                    
            ad.saveContext()

        getStores()
        
        if itemToEdit != nil {
            
            loadItemData()  //Load information to textfield
        }
    }

    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        countRowPicker = row
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //DO: Update when selected
    }
    
    
    func getStores(){
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            // handle the error
        }
    }

    
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbImg.image
        
        
        if itemToEdit == nil {
            
            item = Item(context: context)
        
        }else {
            
            item = itemToEdit
        }//
        
        item.toImage = picture //
        
        if let title = titleField.text {
            
            item.title = title
        }
        
        if let price = PriceField.text {
            
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text {
            
            item.details = details
        }
        
        //relation
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: Load information to textfield
    func loadItemData() {
        
        if let item = itemToEdit {
            titleField.text = item.title
            PriceField.text = "\(item.price)"
            detailsField.text = item.details
            
            thumbImg.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if s.name == store.name {
                        
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
            }
        }
    }
    
    //MARK: DELETE BUTTON
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: INSERT IMAGE
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumbImg.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    

    
    
}
