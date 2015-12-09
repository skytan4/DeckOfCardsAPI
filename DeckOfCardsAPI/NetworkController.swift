//
//  NetworkController.swift
//  DeckOfCardsAPI
//
//  Created by Skyler Tanner on 12/8/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import Foundation


class NetworkController {
    
    
    static func getDeckOfCards(newOrdeckID: String, callback: (resultData: [Card]?, NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        
        let deckIdURL = NSURL(string:"http://deckofcardsapi.com/api/deck/\(newOrdeckID)/draw/?count=52")
        
        if let deckIdURL = deckIdURL {
            let dataTask = session.dataTaskWithURL(deckIdURL) { (data, response, error) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let data = data else {
                    callback(resultData: [], error)
                    print("Error getting data")
                    return
                }
                
                let jsonObject: AnyObject
                
                do{
                    jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                } catch(let error as NSError) {
                    callback(resultData: [], error)
                    return
                }
                print(jsonObject)
                let cardsArray = jsonObject["cards"] as? [[String: AnyObject]]
                if let cardObjects = cardsArray {
                    
                    var cards: [Card] = []
                    
                    for cardDictionary in cardObjects {
                        
                        let cardObject = Card(jsonDictionary: cardDictionary)
                            cards.append(cardObject)
                            
                    }
                    callback(resultData: cards, nil)
                }
                print(jsonObject)
            }
            dataTask.resume()
        }
    }
}