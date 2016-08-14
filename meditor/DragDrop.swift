//
//  DragDrop.swift
//  meditor
//
//  Created by Jake Kara on 8/12/16.
//  Copyright © 2016 Jake Kara. All rights reserved.
//

import Cocoa


// adapted code from here:
// https://stackoverflow.com/questions/31657523/os-x-swift-get-file-path-using-drag-and-drop

class DropView: NSView {
    
    var filePath: String?
    let expectedExt = "kext"
    var callback = {(fileURL : NSString) -> () in return ()}
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.whiteColor().CGColor
        
        registerForDraggedTypes([NSFilenamesPboardType, NSURLPboardType])
    }
    
    internal func setCallBack(f : NSString -> ()) {
        self.callback = f
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
    }
    
    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation {
        self.layer?.backgroundColor = NSColor.lightGrayColor().CGColor
        
        if let pasteboard = sender.draggingPasteboard().propertyListForType("NSFilenamesPboardType") as? NSArray {
            if let path = pasteboard[0] as? String {
                let ext = NSURL(fileURLWithPath: path).pathExtension
                if ext == expectedExt {
                    self.layer?.backgroundColor = NSColor.blueColor().CGColor
                    return NSDragOperation.Copy
                }
            }
        }
        return NSDragOperation.None
    }
    
    override func draggingExited(sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = NSColor.whiteColor().CGColor
    }
    
    override func draggingEnded(sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = NSColor.whiteColor().CGColor
        self.performDragOperation(sender!)
    }
    
    override func performDragOperation(sender: NSDraggingInfo) -> Bool {
        Swift.print ("performDragOperation")
        if let pasteboard = sender.draggingPasteboard().propertyListForType("NSFilenamesPboardType") as? NSArray {
            if let path = pasteboard[0] as? String {
                self.filePath = path
                
                // GET YOUR FILE PATH !!
                // Swift.print("filePath: \(filePath)")
                self.callback(filePath!)
                return true
            }
        }
        return false
    }
}
