//
//  ImprovViewController.swift
//  trans3
//
//  Created by Teneala Spencer on 8/22/18.
//  Copyright © 2018 Teneala Spencer. All rights reserved.
//

import UIKit
import FirebaseDatabase


class ImprovViewController: UIViewController {

    @IBAction func backBT(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as!ViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBOutlet weak var improve: UIButton!
    
    @IBOutlet weak var newPhrase: UITextField!
    
    @IBAction func switchBT(_ sender: Any) {
    }
    
    
    @IBOutlet weak var successLB: UILabel!
    var passdat: String? = nil
    var ref: DatabaseReference?

    @IBAction func improveBT(_ sender: Any) {
        ref = Database.database().reference().child("Improved Translations")
        
        if (newPhrase.text != "")
        {
            //ref?.child(passdat!).childByAutoId().setValue(newPhrase.text)
            //ref?.child(passdat!).setValue(newPhrase.text)
            ref?.child(passdat!).childByAutoId().setValue(newPhrase.text)
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
            newPhrase.text = ""
            phrase.text = ""
        }
    }
    
    @IBOutlet weak var phrase: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phrase.layer.borderWidth = 0.20
        phrase.layer.cornerRadius = 10
        phrase.layer.borderColor = UIColor.gray.cgColor
        improve.layer.cornerRadius = 10
        improve.clipsToBounds = true
        phrase.text = passdat
        
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
