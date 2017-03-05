//
//  MainVC.swift
//  coredata_wishlist_swift
//
//  Created by Surasak Wattanapradit on 3/5/2560 BE.
//  Copyright © 2560 Surasak Wattanapradit. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var seqment: UISegmentedControl!

//    var fetchedResultsController: NSFetchedResultsController<Item>! //Feching from Item Entity
    var controller: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //generateTestData()
        attemptFetch()
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell //เมื่อเรียก CellForRow ให้เรียก cell และสร้าง cell และส่งข้อมูลนั้นไป configureCell
        configureCell(cell: cell, IndexPath: indexPath as NSIndexPath)
        return cell
    }
   
    func configureCell(cell: ItemCell, IndexPath: NSIndexPath){ //ข้อมูลที่ส่งจะถูกส่งผ่าน cell.configure และไปยัง custom Class
        
        let item = controller.object(at: IndexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0 //ถ้าไม่มี
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150 //ความสูง
    }

    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created" , ascending: false) //seq Newest เพื่อนำไปเปรียบเทียบเวลา วันที่ได้
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        self.controller = controller //set outside controller to inside controller
        //ใช้ do เพราะ fetchRequest สามารถ Fail ได้
        do {
            try controller.performFetch()
        } catch {
            
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) { // insert  delete move update -> kind of change
        
        switch(type) {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                //DO: Update Cell Data ก่อน v
                configureCell(cell: cell, IndexPath: indexPath as NSIndexPath) //เมื่อเรา Update cellจะกลับไปconfigure cell func อีกครั้ง
                
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
        
    }
    
    
//    func generateTestData() {
//        
//        let item = Item(context: context)
//        item.title = "Example Title"
//        item.price = 999999
//        item.details = "This is test wishlist data, You can delete it."
//        
//        let item2 = Item(context: context)
//        item2.title = "Example Title2"
//        item2.price = 1999999
//        item2.details = "This is test wishlist data, You can delete it."
//        
//        let item3 = Item(context: context)
//        item3.title = "Example Title3"
//        item3.price = 2999999
//        item3.details = "This is test wishlist data, You can delete it."
//        
//        ad.saveContext()
//    }

}

