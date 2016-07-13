//
//  ViewController.swift
//  How's The Weather
//
//  Created by 이승희 on 7/13/16.
//  Copyright © 2016 이승희. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        let url = NSURL(string: "http://www.weather-forecast.com/locations/" + cityNameTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray.count > 1 {
                    let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                    
                    if weatherArray.count > 1 {
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.resultLabel.text = weatherSummary
                            print(weatherSummary)
                        })
                    }
                }
            }
            
        }
        task.resume()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

