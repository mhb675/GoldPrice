//
//  ViewController.swift
//  GoldPrice
//
//  Created by Hassan Bhatti on 16/11/2017.
//  Copyright © 2017 Hassan Bhatti. All rights reserved.
//

import UIKit
import Alamofire

class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var currencyButton: UIBarButtonItem!
    @IBOutlet weak var metalsCollectionViewController: UICollectionView!
    var metalIcons = [UIImage]()
    
    var gold:Metal? = nil
    var silver:Metal? = nil
    var platinum:Metal? = nil
    var palladium:Metal? = nil

    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 0.0, right: 10.0)

    override func viewDidLoad()
    {
        super.viewDidLoad()

        metalIcons = [#imageLiteral(resourceName: "Gold"), #imageLiteral(resourceName: "Silver"), #imageLiteral(resourceName: "Platinum"), #imageLiteral(resourceName: "Palladium")]
        currencyButton.target = self;
        currencyButton.action = #selector(changeCurrencyMethod)

        if UserDefaults.standard.object(forKey: Constants.CURRENCY) == nil
        {
            //default currency
            UserDefaults.standard.set("USD", forKey: Constants.CURRENCY)
        }
        
        self.currencyButton.title = UserDefaults.standard.object(forKey: Constants.CURRENCY) as? String
        
        getDataFromServer()
    }
    
    func getDataFromServer()
    {
        let selectedCurrency = UserDefaults.standard.object(forKey: Constants.CURRENCY)
        let goldPrice_url = String.init(format: "%@Symbol=XAU&Currency=%@&_token=%@", Constants.serverURL, selectedCurrency as! CVarArg, Constants.user_token)
        let silverPrice_url = String.init(format: "%@Symbol=XAG&Currency=%@&_token=%@", Constants.serverURL, selectedCurrency as! CVarArg, Constants.user_token)
        let platinumPrice_url = String.init(format: "%@Symbol=XPT&Currency=%@&_token=%@", Constants.serverURL, selectedCurrency as! CVarArg, Constants.user_token)
        let palladiumPrice_url = String.init(format: "%@Symbol=XPD&Currency=%@&_token=%@", Constants.serverURL, selectedCurrency as! CVarArg, Constants.user_token)

        let concurrentQueue = DispatchQueue(label: "metalQueue", attributes: .concurrent)
        concurrentQueue.sync {
            
            //for gold
            Alamofire.request(goldPrice_url).responseJSON(queue: concurrentQueue) { response in
                print(response.timeline)

                if let json = response.result.value
                {
                    self.gold = Metal.createWithJson(json: json, fileName: "Gold-USD")
                    
                    DispatchQueue.main.async {
                        self.metalsCollectionViewController.reloadData()
                    }
                }
            }
            
            //for silver
            Alamofire.request(silverPrice_url).responseJSON(queue: concurrentQueue) { response in
                print(response.timeline)

                if let json = response.result.value
                {
                    self.silver = Metal.createWithJson(json: json, fileName: "Silver-USD")
                    
                    DispatchQueue.main.async {
                        self.metalsCollectionViewController.reloadData()
                    }
                }
            }
            
            //for platinum
            Alamofire.request(platinumPrice_url).responseJSON(queue: concurrentQueue) { response in
                print(response.timeline)

                if let json = response.result.value
                {
                    self.platinum = Metal.createWithJson(json: json, fileName: "Platinum-USD")
                    
                    DispatchQueue.main.async {
                        self.metalsCollectionViewController.reloadData()
                    }
                }
            }
            
            //for palladium
            Alamofire.request(palladiumPrice_url).responseJSON(queue: concurrentQueue) { response in
                print(response.timeline)

                if let json = response.result.value
                {
                    self.palladium = Metal.createWithJson(json: json, fileName: "Palladium-USD")
                    
                    DispatchQueue.main.async {
                        self.metalsCollectionViewController.reloadData()
                    }
                }
            }
        }
   }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MetalDetailsCell", for: indexPath) as! MetalDetailsCell
        
        if indexPath.item == 0
        {
            if gold?.name != nil
            {
            cell.updateCell(metalImage: metalIcons[indexPath.item], metal: gold!)
            }
        }
        else if indexPath.item == 1
        {
            if silver?.name != nil
            {
                cell.updateCell(metalImage: metalIcons[indexPath.item], metal: silver!)
            }
        }
        else if indexPath.item == 2
        {
            if platinum?.name != nil
            {
                cell.updateCell(metalImage: metalIcons[indexPath.item], metal: platinum!)
            }
        }
        else if indexPath.item == 3
        {
            if palladium?.name != nil
            {
                cell.updateCell(metalImage: metalIcons[indexPath.item], metal: palladium!)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let paddingSpace = sectionInsets.left * (itemsPerRow) + 10
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let height = (widthPerItem) * 1.65
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return sectionInsets.left
    }

    @objc func changeCurrencyMethod()
    {
        let optionMenu = UIAlertController(title: nil, message: "Select Currency", preferredStyle: .actionSheet)
        
        let usdAction = UIAlertAction(title: "USD", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.currencyButton.title = "USD"
            self.setUserDefaultCurrency(currency: self.currencyButton.title!)
        })
        let audAction = UIAlertAction(title: "AUD", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.currencyButton.title = "AUD"
            self.setUserDefaultCurrency(currency: self.currencyButton.title!)
        })
        let cadAction = UIAlertAction(title: "CAD", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.currencyButton.title = "CAD"
            self.setUserDefaultCurrency(currency: self.currencyButton.title!)
        })
        let chfAction = UIAlertAction(title: "CHF", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.currencyButton.title = "CHF"
            self.setUserDefaultCurrency(currency: self.currencyButton.title!)
        })
        let eurAction = UIAlertAction(title: "EUR", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.currencyButton.title = "EUR"
            self.setUserDefaultCurrency(currency: self.currencyButton.title!)
        })
        let gbpAction = UIAlertAction(title: "GBP", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.currencyButton.title = "GBP"
            self.setUserDefaultCurrency(currency: self.currencyButton.title!)
        })
        let hkoAction = UIAlertAction(title: "HKD", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.currencyButton.title = "HKD"
            self.setUserDefaultCurrency(currency: self.currencyButton.title!)
        })
        let zarAction = UIAlertAction(title: "ZAR", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.currencyButton.title = "ZAR"
            self.setUserDefaultCurrency(currency: self.currencyButton.title!)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenu.addAction(usdAction)
        optionMenu.addAction(audAction)
        optionMenu.addAction(cadAction)
        optionMenu.addAction(chfAction)
        optionMenu.addAction(eurAction)
        optionMenu.addAction(gbpAction)
        optionMenu.addAction(hkoAction)
        optionMenu.addAction(zarAction)
        optionMenu.addAction(cancelAction)

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
        {
            if let currentPopoverpresentioncontroller = optionMenu.popoverPresentationController
            {
                currentPopoverpresentioncontroller.barButtonItem = self.currencyButton
                currentPopoverpresentioncontroller.permittedArrowDirections = UIPopoverArrowDirection.up;
                self.present(optionMenu, animated: true, completion: nil)
            }
        }
        else
        {
            self.present(optionMenu, animated: true, completion: nil)
        }

    }
    
    
    func setUserDefaultCurrency(currency:String)
    {
        UserDefaults.standard.set(currency, forKey: Constants.CURRENCY)
        print(UserDefaults.standard.object(forKey: Constants.CURRENCY) ?? "")
        
        getDataFromServer()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

