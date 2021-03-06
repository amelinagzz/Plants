//
//  DataService.swift
//  Plants
//
//  Created by Adriana Gonzalez on 2/11/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    
    static let instance = DataService()
    
    private var _loadedPosts = [Post]()
    let KEY_POSTS = "posts"
    
    var loadedPosts: [Post] {
        
        return _loadedPosts
    }
    
    func savePosts() {
        
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    func loadPosts() {
        
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData {
            if let postsArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                _loadedPosts = postsArray
            }
        }
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
        
    }
    
    func saveImageAndCreatePath(image: UIImage) -> String {
        let imageData = UIImagePNGRepresentation(image)
        let imagePath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        let fullPath = documentsPathForFileName(imagePath)
        imageData?.writeToFile(fullPath, atomically: true)
        return imagePath
    }
    
    func imageForPath(path: String) -> UIImage?{
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func addPost(post: Post) {
        
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
    func documentsPathForFileName(name: String) -> String {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let fullPath = path [0] as NSString
        return fullPath.stringByAppendingPathComponent(name)
    }
    
}