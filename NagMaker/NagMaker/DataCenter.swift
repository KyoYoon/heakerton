//
//  DataCenter.swift
//  NagMaker
//
//  Created by HyunJomi on 2017. 7. 6..
//  Copyright © 2017년 HyunJung. All rights reserved.
//

import UIKit

class DataCenter{
    
    static let standard = DataCenter()
    
    var nagArray: [NagData] = []
    
    private let fileManager:FileManager = FileManager()
    private let docPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! + "/NagData.plist"
    
    private init() {
        
        if fileManager.fileExists(atPath: docPath) {
            self.loadFromDoc()
        } else {
            self.loadFromBundle()
        }
        
    }
    
    private func loadFromBundle() {
        let bundlePath: String = Bundle.main.path(forResource: "NagData", ofType: "plist")!
        if let loadedArray = NSArray.init(contentsOfFile: bundlePath) as? [[String:Any]] {
            for i in loadedArray{
                nagArray.append(NagData(with: i))
            }
        
        }
        try? fileManager.copyItem(atPath: bundlePath, toPath: docPath)
    }
    
    private func loadFromDoc() {
        if let loadedArray = NSArray.init(contentsOfFile: docPath) as? [[String:Any]] {
            for i in loadedArray{
                nagArray.append(NagData(with: i))
            }
        }
    }

    private func saveToDoc() {
        let nsArray: NSArray = NSArray.init(array: self.nagArray.map({ (data: NagData) -> [String:Any] in
            return data.dictionary
        }))
        nsArray.write(toFile: docPath, atomically: true)
    }
    
    func addNag(_ dict:[String:Any]) {
        self.nagArray.append(NagData.init(with: dict))
        self.saveToDoc()
    }
    
    func editNag(_ dict:[String:Any], editNag:String) {
        
        var index:Int = 0
        
        print(editNag)
        
        print(self.nagArray)
        
        for nag in self.nagArray {
            
            
            
            if editNag == nag.location {
                print("exist")
                break
            }
            
            index += 1
            
        }
        
        print("Index: \(index)")
        
        self.nagArray[index] = NagData.init(with: dict)
        
        self.saveToDoc()
        
    }
    
    func removeNag(_ dict:[String:Any], removeId:String) {
        var index:Int = 0
        
        print(removeId)
        
        print(self.nagArray)
        
        for nag in self.nagArray {
            
            
            
            if removeId == nag.location {
                print("exist")
                break
            }
            
            index += 1
            
        }
        
        print("Index: \(index)")
        
        self.nagArray.remove(at: index)
        
        self.saveToDoc()
    }

    
}
