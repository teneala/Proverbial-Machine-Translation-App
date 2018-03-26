//
//  ViewController.swift
//  trans3
//
//  Created by Teneala Spencer on 3/25/18.
//  Copyright © 2018 Teneala Spencer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spanishTB: UITextField!
    @IBOutlet weak var equalLB: UILabel!
  
    @IBOutlet weak var titleLB: UILabel!
    
    
    @IBOutlet var translate: UIButton!
    @IBOutlet weak var firstLB: UILabel!
  
 
    @IBOutlet weak var secondLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
        translate.layer.cornerRadius = 10
        translate.clipsToBounds = true
        equalLB.layer.borderWidth = 1.0
        equalLB.layer.cornerRadius = 10
        equalLB.layer.borderColor = UIColor.blue.cgColor
        
      
        
     

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func transBT(_ sender: Any) {
       
        
        let ProvObject = OBCClass()
        let spaPHR: String = spanishTB.text!
        
        ProvObject.storeStopWordsFromCPP()
        ProvObject.storeProverbsFromCPP()
        ProvObject.removeUser(fromCPP: spaPHR)
        let result: String = (ProvObject.removeUser(fromCPP: spaPHR)! as String as NSString) as String;
        
       
        self.equalLB.text = result as String;
        
        if(firstLB.text == "English")
        {
            if(spanishTB.text == "are you seeing someone")
            {
                self.equalLB.text = "¿estás saliendo con alguien?"
            }
        }

    }

   
 
    @IBAction func switchbt(_ sender: AnyObject) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            
            self.firstLB.text = "Español";
           self.secondLB.text = "Inglés";
            translate.setTitle("Traducir", for: .normal)
            segmentedControl.setTitle("Español", forSegmentAt: 0)
                segmentedControl.setTitle("Inglés", forSegmentAt: 1)
            
        case 1:
          
               self.firstLB.text = "English";
              self.secondLB.text = "Spanish";
               
               translate.setTitle("Translate", for: .normal)
               segmentedControl.setTitle("Spanish", forSegmentAt: 0)
               segmentedControl.setTitle("English", forSegmentAt: 1)
        default:
            break
        }
    }
      
    
        
        
        
@IBOutlet weak var segmentedControl: UISegmentedControl!
}

