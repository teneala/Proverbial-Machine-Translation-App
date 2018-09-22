//
//  ViewController.swift
//  trans3
//
//  Created by Teneala Spencer on 3/25/18.
//  Copyright © 2018 Teneala Spencer. All rights reserved.
//

import UIKit
import Speech
import Foundation
import FirebaseDatabase


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, SFSpeechRecognizerDelegate{
    
    @IBOutlet weak var dialectPicker: UIPickerView!
   // @IBOutlet var translate: UIButton!
    @IBOutlet weak var navigation: UINavigationItem!
    
    @IBOutlet weak var notConnectedPic: UIImageView!
    @IBOutlet weak var moreInfoBT: UIButton!
    
    @IBOutlet weak var notConnectedLB: UILabel!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var microBT: UIButton!
    @IBOutlet weak var spanishTB: UITextField!
    @IBOutlet weak var equalLB: UILabel!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet var translate: UIButton!
    @IBOutlet weak var firstLB: UILabel!
    @IBOutlet weak var secondLB: UILabel!
    
    @IBOutlet weak var moreInfoLB: UILabel!
    @IBOutlet weak var newPhraseTB: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var spanishCodeDidRun: Bool = false
    var englishCodeDidRun: Bool = false
    
    var dialectSelected: String = "Spanish International"
    var languages = ["Spanish International", "Dominican Republic", "Guatemala","Puerto Rico", "Mexico"]
    var language = ["Inglés-US"]
    var dataSource = ["Inglés-US"]
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        equalLB.text = ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "destain", size: 19)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = dataSource[row]
        pickerLabel?.textColor = #colorLiteral(red: 0.3782545262, green: 0.6675550189, blue: 0.4860304322, alpha: 1)
        return pickerLabel!
    
        
     
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
                  return dataSource.count
        
   
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        
        dialectSelected = dataSource[row] as String
    }
    

    
        func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }


    
    
    
    @IBAction func moreInformation(_ sender: Any) {
        if(moreInfoLB.text == ""){
            moreInfoLB.text = "Press the 'Add' button to add new slang to the database! It can be anything from memes, internet culture, or tv. The more slang the more bettah lmbo."
        }
        else{
            moreInfoLB.text = ""
        }
    }
  
 
    
    private var speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "spa"))  //1
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    

    

    
    
  
    @IBAction func editDidChange(_ sender: Any) {
        textFieldDidBeginEditing(spanishTB)

    }
   
    

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool)
    
    {
        
        if available {
            microBT.isEnabled = true
        } else {
            microBT.isEnabled = false
        }
    }
       
    func startRecording()
    
    {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.spanishTB.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.microBT.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
       // textView.text = "Say something, I'm listening!"
        
    }
  
    
    let ProvObject = OBCClass()
    let EngObject = OBCClass()
    var spaPHR: String = "" //= spanishTB.text!
    var result: String = ""
    var res: String = ""
    


    
    @IBAction func transBT(_ sender: Any) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        spaPHR = spaPHR.lowercased();
        spaPHR = spanishTB.text!

        let connectedRef = Database.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
            if let connected = snapshot.value as? Bool, connected {
                self.notConnectedLB.text = ""
                self.notConnectedPic.isHidden = true


            } else {
                self.notConnectedLB.text = "Error: You are not connected to the internet!"
                self.notConnectedLB.font = UIFont(name: "SFMono", size: 9)
                self.notConnectedLB.textColor = UIColor.red;
                self.notConnectedPic.isHidden = false
            }
        })
        
        
        if (translate.titleLabel?.text == "Traducir" && spanishTB.text != ""){
            
    
            
            let dialectFlag: String =  "Inglés-US"
            
            var see: String = spanishTB.text!
            see = removeSpecialCharsFromString(text: see)
            see = stemWordSpanish(firstPhrase: see, langSetting: "spa")
            let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
            let components = see.components(separatedBy: chararacterSet)
            

            
            
            let proverb = components.filter { !$0.isEmpty }
            var proverbCount: Int
            proverbCount = (proverb.count)
            var stemmed: String = see
            
            stemmed = stemmed.folding(options: .diacriticInsensitive, locale: .current)
    


            res = ProvObject.removeUser(stemmed, fromCPP: Int32(proverbCount), additional: dialectFlag)
         
            
            if(res == ""){
                self.equalLB.text = "SORRY fam, I don't know what this phrase means yet. Click 'Add' if you want to see this translation in the future."
                self.equalLB.textColor = UIColor.red;
                 equalLB.font = equalLB.font.withSize(12)
            }
            else{
                self.equalLB.textColor = UIColor.black;
                equalLB.font = equalLB.font.withSize(15)
                res = String(res.characters.first!).capitalized + String(res.characters.dropFirst())
                self.equalLB.text = res as String;
            }
            
        }
            
        else if (translate.titleLabel?.text == "Translate" && spanishTB.text != ""){
            
            
            

            let dialectFlag: String =  dialectSelected
            
            var see: String = spanishTB.text!
            see = removeSpecialCharsFromString(text: see)
            see = stemWordSpanish(firstPhrase: see, langSetting: "eng")
            let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
            let components = see.components(separatedBy: chararacterSet)
            let proverb = components.filter { !$0.isEmpty }
            var proverbCount: Int
            proverbCount = (proverb.count)
            let stemmed: String = see
        
            
            result = EngObject.removeUser(stemmed as String!, fromCPP: Int32(proverbCount), additional: dialectFlag)

            if(result == ""){
                self.equalLB.text = "SORRY fam, I don't know what this phrase means yet. Click 'Add' if you want to see this translation in the future."
                self.equalLB.textColor = UIColor.red;
                equalLB.font = equalLB.font.withSize(12)

            }
            else{
                self.equalLB.textColor = UIColor.black;
                equalLB.font = equalLB.font.withSize(15)
                result = String(result.characters.first!).capitalized + String(result.characters.dropFirst())
                self.equalLB.text = result as String;
            }
          
            
        }
        
        
    }
   
    @IBAction func microTapped(_ sender: AnyObject) {
        
        
    
        
            if self.audioEngine.isRunning
                
            {
                self.audioEngine.stop()
                self.recognitionRequest?.endAudio()
                self.microBT.isEnabled = false
                //textView.text = ""
                //self.microBT.setTitle("", for: .normal)
            }
                
            else {
                self.startRecording()
                
                
                //self.microBT.setTitle("", for: .normal)
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
            speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "spa"))
            dataSource = language;
            self.dialectPicker.reloadAllComponents()

            
        case 1:
            
            self.firstLB.text = "English";
            self.secondLB.text = "Spanish";
            //translate.layer.backgroundColor = UIColor.orange.cgColor;
            translate.setTitle("Translate", for: .normal)
            segmentedControl.setTitle("Spanish", forSegmentAt: 0)
            segmentedControl.setTitle("English", forSegmentAt: 1)
            speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
            dataSource = languages;
            self.dialectPicker.reloadAllComponents()

        default:
            break
        }
    }
    
    
    var codeDidRun: Bool = false
    
    func stemWordSpanish(firstPhrase: String, langSetting: String)-> String{
        //eng = self.removeSpecialCharsFromString(text: eng as! String) as AnyObject
        //second = second.lowercased();
        //var second: String = secondPhrase
        //spaPhrase.lowercased()
        
        var first: String = firstPhrase
        let language: String = langSetting
        var stemmed: String = ""
        
        
        first = first.lowercased();
        first = (self.removeSpecialCharsFromString(text: first ) as AnyObject) as! String
        
        let stmt: NSString = first as NSString
        let options: NSLinguisticTagger.Options = .omitWhitespace
        let stringRange = NSMakeRange(0, stmt.length)
        let languageMap = ["Latn":[language]]
        let orthography = NSOrthography(dominantScript: "Latn", languageMap: languageMap)
        
        stmt.enumerateLinguisticTags(
            in: stringRange,
            scheme: NSLinguisticTagSchemeLemma,
            options: options,
            orthography: orthography)
        { ( tag, tokenRange, sentenceRange, _) -> () in
            
            let currentEntity = stmt.substring(with: tokenRange)
            //print(">\(currentEntity):\(tag)")
            
            if(tag == ""){
                
                stemmed = stemmed + " " + currentEntity as String
                
                stemmed = stemmed.folding(options: .diacriticInsensitive, locale: .current)
            }
                
            else{
                stemmed = stemmed + " " + tag as String
                
                stemmed = stemmed.folding(options: .diacriticInsensitive, locale: .current)
            }
        }
        stemmed = stemmed.folding(options: .diacriticInsensitive, locale: .current)
        
        return stemmed

    }

    
    func spanishToEnglish(){
        var ref2: DatabaseReference?
        var ref3: DatabaseReference?
        var ref4: DatabaseReference?
        var ref5: DatabaseReference?
        var ref6: DatabaseReference?
        var ref7: DatabaseReference?
        
        ref2 = Database.database().reference().child("Stop Words")
        ref3 = Database.database().reference().child("Dialects").child("Spanish International")
        ref4 = Database.database().reference().child("Dialects").child("Mexico")
        ref5 = Database.database().reference().child("Dialects").child("Dominica")
        ref6 = Database.database().reference().child("Dialects").child("Puerto Rico")
        ref7 = Database.database().reference().child("Dialects").child("Guatemala")
        
        
        
        
        
        
        
        // ref2?.observe(DataEventType.value, with:{(DataSnapshot) in
       ref2?.observe(DataEventType.value, with:{(DataSnapshot) in
            if DataSnapshot.childrenCount > 0{
                for Spanish in DataSnapshot.children.allObjects as![DataSnapshot]{
                    let provObj = Spanish.value as? [String: AnyObject]
                    var spastop = provObj?["Stop Words"]
                    spastop = spastop?.lowercased as AnyObject;
                    self.ProvObject.storeStopWords(fromCPP: spastop as! String)
                    
                }
                
            }
            
            ref3?.observe(DataEventType.value, with:{(DataSnapshot) in
                if DataSnapshot.childrenCount > 0{
                    for Slang in DataSnapshot.children.allObjects as![DataSnapshot]{
                        let provObj = Slang.value as? [String: AnyObject]
                        let spa: String = provObj?["Espanol Originales"] as! String
                        let eng: String = provObj?["Intepretaciones de Ingles"] as! String
                        let stemmed: String = self.stemWordSpanish(firstPhrase: spa, langSetting: "spa")
                        self.ProvObject.storeProverbs(stemmed, fromCPP: eng, additional: "Inglés-US")
                        
                    }
                    
                }
                
                ref4?.observe(DataEventType.value, with:{(DataSnapshot) in
                    if DataSnapshot.childrenCount > 0{
                        for Slang in DataSnapshot.children.allObjects as![DataSnapshot]{
                            let provObj = Slang.value as? [String: AnyObject]
                            let spa: String = provObj?["Espanol Originales"] as! String
                            let eng: String = provObj?["Interpretaciones de Ingles"] as! String
                            let stemmed: String = self.stemWordSpanish(firstPhrase: spa, langSetting: "spa")
                            self.ProvObject.storeProverbs(stemmed, fromCPP: eng, additional: "Inglés-US")
                            
                        }
                        
                    }
                    
                    ref5?.observe(DataEventType.value, with:{(DataSnapshot) in
                        if DataSnapshot.childrenCount > 0{
                            for Slang in DataSnapshot.children.allObjects as![DataSnapshot]{
                                let provObj = Slang.value as? [String: AnyObject]
                                let spa: String = provObj?["Espanol Originales"] as! String
                                let eng: String = provObj?["Interpretaciones de Ingles"] as! String
                                let stemmed: String = self.stemWordSpanish(firstPhrase: spa, langSetting: "spa")
                                self.ProvObject.storeProverbs(stemmed, fromCPP: eng, additional: "Inglés-US")
                                
                            }
                            
                        }
                        
                        
                        ref6?.observe(DataEventType.value, with:{(DataSnapshot) in
                            if DataSnapshot.childrenCount > 0{
                                for Slang in DataSnapshot.children.allObjects as![DataSnapshot]{
                                    let provObj = Slang.value as? [String: AnyObject]
                                    let spa: String = provObj?["Espanol Originales"] as! String
                                    let eng: String = provObj?["Interpretaciones de Ingles"] as! String
                                    let stemmed: String = self.stemWordSpanish(firstPhrase: spa, langSetting: "spa")
                                    self.ProvObject.storeProverbs(stemmed, fromCPP: eng, additional: "Inglés-US")
                                    
                                }
                                
                            }
                            
                            ref7?.observe(DataEventType.value, with:{(DataSnapshot) in
                                if DataSnapshot.childrenCount > 0{
                                    for Slang in DataSnapshot.children.allObjects as![DataSnapshot]{
                                        let provObj = Slang.value as? [String: AnyObject]
                                        let spa: String = provObj?["Espanol Originales"] as! String
                                        let eng: String = provObj?["Interpretaciones de Ingles"] as! String
                                        let stemmed: String = self.stemWordSpanish(firstPhrase: spa, langSetting: "spa")
                                        self.ProvObject.storeProverbs(stemmed, fromCPP: eng, additional: "Inglés-US")
                                        
                                    }
                                    
                                }
                                
                                
                            })
                            
                        })
                        
                    })
                    
                    
                })
                
                
            })
            
            
        })
        
        englishCodeDidRun = true
        
    }

    func englishToSpanish(){
        
            // Perform an action that will only be done once
            var ref2: DatabaseReference?
            var ref3: DatabaseReference?
            var ref4: DatabaseReference?
            var ref5: DatabaseReference?
            var ref6: DatabaseReference?
            var ref7: DatabaseReference?
        
            ref2 = Database.database().reference().child("Stop Words")
            ref3 = Database.database().reference().child("Dialects").child("Spanish International")
            ref4 = Database.database().reference().child("Dialects").child("Mexico")
            ref5 = Database.database().reference().child("Dialects").child("Dominica")
            ref6 = Database.database().reference().child("Dialects").child("Puerto Rico")
            ref7 = Database.database().reference().child("Dialects").child("Guatemala")
            
            
        
            
            
            
            
            // ref2?.observe(DataEventType.value, with:{(DataSnapshot) in
          ref2?.observe(DataEventType.value, with:{(DataSnapshot) in
                if DataSnapshot.childrenCount > 0{
                    for Spanish in DataSnapshot.children.allObjects as![DataSnapshot]{
                        let provObj = Spanish.value as? [String: AnyObject]
                        var spastop = provObj?["Stop Words"]
                        spastop = spastop?.lowercased as AnyObject;
                        self.ProvObject.storeStopWords(fromCPP: spastop as! String)
                        
                    }
                    
                }
                
                ref3?.observe(DataEventType.value, with:{(DataSnapshot) in
                    if DataSnapshot.childrenCount > 0{
                        for Slang in DataSnapshot.children.allObjects as![DataSnapshot]{
                            let provObj = Slang.value as? [String: AnyObject]
                            let spa: String = provObj?["Espanol Originales"] as! String
                            let eng: String = provObj?["Intepretaciones de Ingles"] as! String
                            let stemmed: String = self.stemWordSpanish(firstPhrase: eng, langSetting: "eng")
                            self.ProvObject.storeProverbs(stemmed, fromCPP: spa, additional: "Spanish International")
                            
                        }
                        
                    }
                    
                    ref4?.observe(DataEventType.value, with:{(DataSnapshot) in
                        if DataSnapshot.childrenCount > 0{
                            for Slang in DataSnapshot.children.allObjects as![DataSnapshot]{
                                let provObj = Slang.value as? [String: AnyObject]
                                let spa: String = provObj?["Espanol Originales"] as! String
                                let eng: String = provObj?["Interpretaciones de Ingles"] as! String
                                let stemmed: String = self.stemWordSpanish(firstPhrase: eng, langSetting: "eng")
                                self.ProvObject.storeProverbs(stemmed, fromCPP: spa, additional: "Mexico")
                                
                            }
                            
                        }
                        
                        ref5?.observe(DataEventType.value, with:{(DataSnapshot) in
                            if DataSnapshot.childrenCount > 0{
                                for Slang in DataSnapshot.children.allObjects as![DataSnapshot]{
                                    let provObj = Slang.value as? [String: AnyObject]
                                    let spa: String = provObj?["Espanol Originales"] as! String
                                    let eng: String = provObj?["Interpretaciones de Ingles"] as! String
                                    let stemmed: String = self.stemWordSpanish(firstPhrase: eng, langSetting: "eng")
                                    self.ProvObject.storeProverbs(stemmed, fromCPP: spa, additional: "Dominican Republic")
                                    
                                }
                                
                            }
                            
                            
                            ref6?.observe(DataEventType.value, with:{(DataSnapshot) in
                                if DataSnapshot.childrenCount > 0{
                                    for Slang in DataSnapshot.children.allObjects as![DataSnapshot]{
                                        let provObj = Slang.value as? [String: AnyObject]
                                        let spa: String = provObj?["Espanol Originales"] as! String
                                        let eng: String = provObj?["Interpretaciones de Ingles"] as! String
                                        let stemmed: String = self.stemWordSpanish(firstPhrase: eng, langSetting: "eng")
                                        self.ProvObject.storeProverbs(stemmed, fromCPP: spa, additional: "Puerto Rico")
                                        
                                    }
                                    
                                }
                                
                                ref7?.observe(DataEventType.value, with:{(DataSnapshot) in
                                    if DataSnapshot.childrenCount > 0{
                                        for Slang in DataSnapshot.children.allObjects as![DataSnapshot]{
                                            let provObj = Slang.value as? [String: AnyObject]
                                            let spa: String = provObj?["Espanol Originales"] as! String
                                            let eng: String = provObj?["Interpretaciones de Ingles"] as! String
                                            let stemmed: String = self.stemWordSpanish(firstPhrase: eng, langSetting: "eng")
                                            self.ProvObject.storeProverbs(stemmed, fromCPP: spa, additional: "Guatemala")
                                            
                                        }
                                        
                                    }
                                    
                                    
                                })
                                
                            })
                            
                        })
                        
                        
                    })
                    
                    
                })
                
                
            })
            
  
        spanishCodeDidRun = true
        
    }

    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        

        if(spanishCodeDidRun == false  && englishCodeDidRun == false){
            englishToSpanish()
            spanishToEnglish()
            
            
            
        }
     
        
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    
        //if(UIDevice.current.userInterfaceIdiom != .pad){
        notConnectedPic.isHidden = true
        

        translate.layer.cornerRadius = 10
        translate.clipsToBounds = true
        equalLB.layer.borderWidth = 0.20
        equalLB.layer.cornerRadius = 10
        equalLB.layer.borderColor = UIColor.gray.cgColor
    
        
        microBT.isEnabled = false  //2
        speechRecognizer?.delegate = self  //3
        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4
        var isButtonEnabled = false
            
            switch authStatus
            
            {  //5
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.microBT.isEnabled = isButtonEnabled
            }
            
        }
        
    
       
        
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "improve"){
        let receiverVC: ImprovViewController = segue.destination as! ImprovViewController
        receiverVC.passdat = spanishTB.text!
        }
    }


   
}

