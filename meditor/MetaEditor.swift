//
//  MetaEditor.swift
//  meditor
//
//  Created by Jake Kara on 8/12/16.
//  Copyright © 2016 Jake Kara. All rights reserved.
//

import Foundation
let fileManager = NSFileManager.defaultManager()
public class MetaEditor : NSObject {
    
    var fileUrl = ""
    
    init(fileUrl : String) {
        self.fileUrl = fileUrl
    }
    
    func getMeta() -> NSDictionary? {
        do {
            let attr : NSDictionary? = try NSFileManager.defaultManager().attributesOfItemAtPath(self.fileUrl);
            Swift.print (attr);
            return attr;
        }
        catch let error as NSError {
            Swift.print("Ooops! Something went wrong: \(error)")
            return nil;
        }

    }
    
    func setDate(newDate:NSDate) {
        do {
            Swift.print ("Setting date");
            try NSFileManager.defaultManager().setAttributes([
                NSFileCreationDate: newDate],ofItemAtPath:self.fileUrl)
        } catch {
            Swift.print ("ERROR");
        }
    }
    
    func setModificationDate(newDate:NSDate) {
        do {
            Swift.print ("Setting date");
            try NSFileManager.defaultManager().setAttributes([
                NSFileModificationDate: newDate],ofItemAtPath:self.fileUrl)
        } catch {
            Swift.print ("ERROR");
        }
    }

    
}