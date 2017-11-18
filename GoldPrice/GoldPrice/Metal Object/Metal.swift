//
//  Metal.swift
//  GoldPrice
//
//  Created by Hassan Bhatti on 17/11/2017.
//  Copyright © 2017 Hassan Bhatti. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class Metal: CustomStringConvertible
{
    var ID:Int?
    var name:String?
    var open:Double?
    var close:Double?
    var high:Double?
    var low:Double?
    var unit:String?
    var date:String?
    var change:Double?
    var percentChange:Double?


    init?(json: Any)
    {
        guard let representation = json as? [String: Any] else
        {
            return nil
        }
        
        if let _ = representation["Message"] as? String
        {
            return nil
        }

        self.name = representation["Name"] as? String
        self.open = representation["Open"] as? Double
        self.close = representation["Close"] as? Double
        self.high = representation["High"] as? Double
        self.low = representation["Low"] as? Double
        self.unit = representation["Unit"] as? String
        self.date = representation["Date"] as? String
        self.change = representation["Change"] as? Double
        self.percentChange = representation["PercentChange"] as? Double
    }

    var description: String
    {
        return "Metal: { name: \(String(describing: name))}"
    }
    
    
    class func createWithJson(json:Any, fileName:String) -> Metal?
    {
        if let metalValue = Metal(json: json)
        {
            //save metal to the file here (if we want to use previous data)
            return metalValue
        }
        else
        {
            if let path = Bundle.main.path(forResource: fileName, ofType: "json")
            {
                do
                {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as AnyObject
                    print("Metal Detail is : \(jsonResult)")
                    return Metal(json: jsonResult)
                }
                catch
                {
                    // handle error
                    return nil
                }
            }
            else
            {
                return nil
            }
        }
    }
    
}




