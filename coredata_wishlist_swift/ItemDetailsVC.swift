//
//  ItemDetailsVC.swift
//  coredata_wishlist_swift
//
//  Created by Surasak Wattanapradit on 3/6/2560 BE.
//  Copyright © 2560 Surasak Wattanapradit. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var PriceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    
    var stores = [Store]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil) //ตั้งให้ navigation bar ไม่ขึ้นชื่อยาวๆของหน้าที่แล้ว
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
//        let store = Store(context: context)
//        store.name = "Paragon"
//        let store2 = Store(context: context)
//        store2.name = "Central"
//        let store3 = Store(context: context)
//        store3.name = "Tops"
//        let store4 = Store(context: context)
//        store4.name = "Gourmet Market"
//        let store5 = Store(context: context)
//        store5.name = "The Mall"
//        let store6 = Store(context: context)
//        store6.name = "Robinson"
//        let store7 = Store(context: context)
//        store7.name = "Big C"
//        let store8 = Store(context: context)
//        store8.name = "Tesco Lotus"
//        let store9 = Store(context: context)
//        store9.name = "Makro"
//        let store10 = Store(context: context)
//        store10.name = "Home Pro"
//        let store11 = Store(context: context)
//        store11.name = "Ikea"
//        let store12 = Store(context: context)
//        store12.name = "7-11"
//        let store13 = Store(context: context)
//        store13.name = "Other"
//        
//        ad.saveContext()
        getStores()
    }

    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
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
        
        let item = Item(context: context)
        
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
    
    
    
    
}
