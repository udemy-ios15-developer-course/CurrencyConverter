//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Chris Hand on 9/4/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        // yeah, I know, don't check in API key. This will get deleted in the future.
        let apiKey = "4nRlNOZXvTyTVIzmfDKAX6wkaxwGU9c0"
        let url = URL(string: "https://api.apilayer.com/fixer/latest?apikey=\(apiKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(button)
                self.present(alert, animated: true)
                return
            }
            
            if data == nil {
                print("request made, no data recieved")
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! Dictionary<String, Any>
                let rates = jsonResponse["rates"] as! [String: Double]
                
                DispatchQueue.main.async {
                    if let cad = rates["CAD"] {
                        self.cadLabel.text = "CAD: \(cad)"
                    }
                    
                    if let chf = rates["CHF"] {
                        self.chfLabel.text = "CHF: \(chf)"
                    }
                    
                    if let gbp = rates["GBP"] {
                        self.gbpLabel.text = "GBP: \(gbp)"
                    }
                    
                    if let jpy = rates["JPY"] {
                        self.jpyLabel.text = "JPY: \(jpy)"
                    }
                    
                    if let usd = rates["USD"] {
                        self.usdLabel.text = "USD: \(usd)"
                    }
                    
                    if let tky = rates["TRY"] {
                        self.tryLabel.text = "TRY: \(tky)"
                    }
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}

