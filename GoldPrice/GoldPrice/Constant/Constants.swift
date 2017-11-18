//
//  Constants.swift
//  GoldPrice
//
//  Created by Hassan Bhatti on 17/11/2017.
//  Copyright © 2017 Hassan Bhatti. All rights reserved.
//

import Foundation

class Constants
{
    static let serverURL = "https://globalmetals.xignite.com/xGlobalMetals.json/GetRealTimeExtendedMetalQuote?"

    static let user_token = "0F96B613394047FCA2D09E10B0071F5F"

    static let CURRENCY = "CURRENCY"

    static let selectedCurrency = UserDefaults.standard.object(forKey: Constants.CURRENCY)
    
    //urls for test cases
    
    //for gold in different currencies
    static let gold_url = String.init(format: "%@Symbol=XAU&Currency=%@&_token=%@", serverURL, selectedCurrency as! CVarArg, user_token)

    //for silver in different currencies
    static let silver_url = String.init(format: "%@Symbol=XAG&Currency=%@&_token=%@", serverURL, selectedCurrency as! CVarArg, user_token)
    
    //for platinum in different currencies
    static let platinum_url = String.init(format: "%@Symbol=XPT&Currency=%@&_token=%@", serverURL, selectedCurrency as! CVarArg, user_token)

    //for palladium in different currencies
    static let palladium_url = String.init(format: "%@Symbol=XPD&Currency=%@&_token=%@", serverURL, selectedCurrency as! CVarArg, user_token)
}
