//
//  ViewController.swift
//  meditor
//
//  Created by Jake Kara on 8/12/16.
//  Copyright © 2016 Jake Kara. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
        
    var loadedFile = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateFileButton.enabled = false;
        
        self.dropZone.setCallBack(self.loadFile)
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func updateFileButtonPressed(sender: NSButton) {
        self.updateFile()
    }
    
    @IBOutlet weak var updateFileButton: NSButton!
    @IBAction func fileUnloadButtonPressed(sender: AnyObject) {
        self.unloadFile();
    }
    
    @IBAction func openDocument(sender: AnyObject){
        // Adapted from:
        // http://stackoverflow.com/questions/26609778/nsopenpanel-in-swift-how-to-open
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.beginWithCompletionHandler { (result) -> Void in
            if result == NSFileHandlingPanelOKButton {
                //Do what you will
                //If there's only one URL, surely 'openPanel.URL'
                //but otherwise a for loop works
                //Swift.print(openPanel.URL);
                if (openPanel.URL != nil){
                    self.loadFile(openPanel.URL!.path!);
                }
            }
        }
    }
    
    @IBOutlet weak var metaDataSummary: NSTextField!
    
    @IBOutlet weak var dateField: NSDatePicker!
    
    @IBOutlet weak var dateModifiedField: NSDatePicker!
    
    @IBOutlet weak var fileLoadedTextField: NSTextField!
    
    @IBOutlet weak var dropZone: DropView!
    
    func loadFile(fileUrl: NSString) {
        self.updateFileButton.enabled = false;

        Swift.print("Loading file: \(fileUrl)");
        let meditor = MetaEditor(fileUrl: fileUrl as String);
        let meta = meditor.getMeta()! as Dictionary;

        self.dateField.dateValue = meta[NSFileCreationDate]! as! NSDate;
        self.dateModifiedField.dateValue = meta[NSFileModificationDate]! as! NSDate;

        self.loadedFile = fileUrl as String;
        self.fileLoadedTextField.stringValue = fileUrl as String;
        self.updateFileButton.enabled = true;

    }
    
    func unloadFile(){
        self.updateFileButton.enabled = false;
        self.loadedFile = "";
        self.fileLoadedTextField.stringValue = self.loadedFile;
    }
    
    func updateFile () {
        let meditor = MetaEditor(fileUrl:self.loadedFile);
        meditor.setDate(self.dateField.dateValue);
        meditor.setModificationDate(self.dateModifiedField.dateValue);
    }
}

