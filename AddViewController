//
//  SecondViewController.swift
//  trans3
//
//  Created by Teneala Spencer on 6/19/18.
//  Copyright © 2018 Teneala Spencer. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SecondViewController: UIViewController {
    var db: OpaquePointer?
    
    
  /*  @IBAction func backButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(nextViewController, animated:true, completion:nil)
    }*/
    
    @IBOutlet weak var successLB: UILabel!
    @IBOutlet weak var newPhraseTB: UITextField!
    @IBOutlet var nuevafrasetb: [UILabel]!
    @IBOutlet weak var addBT: UIButton!
    @IBOutlet var SecondViewController: UIView!
    @IBOutlet weak var newPhraseEquiv: UITextField!
    
    var ref: DatabaseReference?
    
    @IBAction func add(_ sender: Any) {
        
        ref = Database.database().reference().child("New Translations")
        
        if (newPhraseTB.text != "" || newPhraseEquiv.text != "")
        {
        ref?.childByAutoId().child(newPhraseEquiv.text!).setValue(newPhraseTB.text)            //ref?.childByAutoId()
            newPhraseTB.text = ""
            newPhraseEquiv.text = ""
       
        
            successLB.alpha = 0.0
            
            // fade in
            UIView.animate(withDuration: 0.5, animations: {
                self.successLB.text = "S u c c e s s"
                self.successLB.textColor = #colorLiteral(red: 0.654092578, green: 0.5135419243, blue: 0.005270826363, alpha: 1)
                self.successLB.font = UIFont(name: "destain", size: 24)
                self.successLB.center.y = self.view.center.y
                self.successLB.center.x = self.view.center.x
                self.successLB.alpha = 2.5
                self.view.layoutIfNeeded()

            }) { (finished) in
                // fade out
                UIView.animate(withDuration: 2.5, animations: {
                    self.successLB.alpha = 0.0
                })
            }

            
        }
        
        else{
        }
        
        
        

    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        addBT.layer.cornerRadius = 10
        addBT.clipsToBounds = true
        
     
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
