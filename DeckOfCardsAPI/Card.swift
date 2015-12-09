//
//  Card.swift
//  DeckOfCardsAPI
//
//  Created by Skyler Tanner on 12/8/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import UIKit

class Card {
    let image: UIImage?
    let value: String?
    let suit: String?
    let code: String?
    
    init(jsonDictionary:[String: AnyObject]) {
        
        self.image = UIImage(data: NSData(contentsOfURL: NSURL(string: jsonDictionary["image"]! as! String)!)!)
        
        self.value = jsonDictionary["value"] as? String
        self.suit = jsonDictionary["suit"] as? String
        self.code = jsonDictionary["code"] as? String
        
    }
}