//
//  FirebaseStorageClient.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/20/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit
import Firebase

class FirebaseStorageClient{
    
    static var StorageRef = Storage.storage()
    static var UserImageRef = StorageRef.reference().child("UserProfileImages")
    static var EventImageRef = StorageRef.reference().child("EventImages")
    static var metaData = StorageMetadata()
    
    
    static func getImageUrl(imgData : Data,presentingVC :UIViewController)->String{
        
        let imageName = UUID().uuidString
        var imageUrl :String = ""
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        EventImageRef.child(imageName).putData(imgData, metadata: metaData) { (meta, err) in
            if let err = err {
                Alerts.showAlert(title: "Eror",message: "Error uploading image: \(err.localizedDescription)",presentingVC: presentingVC)
               
            }
            
            EventImageRef.downloadURL { (url, err) in
                if let err = err {
                  
                    Alerts.showAlert(title: "Eror",message: "Error fetching url: \(err.localizedDescription)",presentingVC: presentingVC)
                    return
                }
                
                guard let url = url else {
                  
                    Alerts.showAlert(title: "Eror",message: "Error getting url",presentingVC: presentingVC)
                    return
                }
                
                imageUrl = url.absoluteString
                
            }
            
        }
        
        return imageUrl
    }
    
    static func removeExistingImageUrl(url:String){
        
        //delete existing image
        let desertRef = StorageRef.reference(forURL: url)
        
        // Delete the file
        desertRef.delete { error in
            if let error = error {
                print("Cannot remove the image",error)
            }
        }
        
        
    }
    
    
}