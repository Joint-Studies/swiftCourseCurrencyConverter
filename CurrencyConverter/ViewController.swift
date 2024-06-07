//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Rodrigo Silva on 04/06/24.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cadLabel: UILabel!
     
    @IBOutlet weak var chfLabel: UILabel!
    
    @IBOutlet weak var brlLabel: UILabel!
    
    @IBOutlet weak var jpyLabel: UILabel!
    
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var tryLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        getDateFromApi()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getRatesClicked(_ sender: Any) {
        
        getDateFromApi()
    }
    
    func getDateFromApi()  {
        
        let currentDateTime = Date()
        let dateFormatted = currentDateTime.actualDateFormatted()

        /// Create your account in https://fixer.io/documentation and get your access_key to test
        let url = "http://data.fixer.io/api/latest?access_key=insertyourkeyhere"
        
        let request = URLRequest(url: URL.init(string: url)!, timeoutInterval: Double.infinity)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request){data, response, error in
            if  error != nil{
                print("Erro na requisição: \(error!.localizedDescription)")
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            self.dateLabel.text = "Checked on: \(jsonResponse["date"] as? String ?? "\(dateFormatted)")"
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                                 let cad = rates["CAD"] as? Double
                                let brl = rates["BRL"] as? Double
                                let chf = rates["CHF"] as? Double
                                let jpy = rates["JPY"] as? Double
                                let usd = rates["USD"] as? Double
                                let tryCurrency = rates["TRY"] as? Double
                                
                                self.cadLabel.text = "CAD: \(cad ?? 0)"
                                self.brlLabel.text = "BRL: \(brl ?? 0)"
                                self.chfLabel.text = "CHF: \(chf ?? 0)"
                                self.jpyLabel.text = "JPY: \(jpy ?? 0)"
                                self.usdLabel.text = "USD: \(usd ?? 0)"
                                self.tryLabel.text = "TRY: \(tryCurrency ?? 0)"
                                    
                            }
                        }
                    }catch {
                        print("error")
                    }
                    
                }
            }
            
        }
        task.resume()
    }
}



