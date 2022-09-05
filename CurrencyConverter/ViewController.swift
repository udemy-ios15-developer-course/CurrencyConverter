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
            
            print(String(data: data!, encoding: .utf8)!)
        }
        
        task.resume()
    }
}

