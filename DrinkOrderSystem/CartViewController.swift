//
//  CartViewController.swift
//  DrinkOrderSystem
//
//  Created by Ryan Chang on 2021/5/20.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var CartTableView: UITableView!
    
    var Cartrecords = [CartRecord]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feitchCart()
        // Do any additional setup after loading the view.
    }
    
    
    func feitchCart(){
        let url = URL(string: "https://api.airtable.com/v0/appT2AsMEtXCG8YNH/orderList")!
        var request = URLRequest(url: url)
        request.setValue("Bearer keytFVXh8KVH8kva6", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let content = String(data:data, encoding: .utf8){
                print(content)
                let decoder = JSONDecoder()
                do{
                    let CartResponse = try decoder.decode(Cart.self, from: data)
                    self.Cartrecords = CartResponse.records
                    DispatchQueue.main.async {
                        self.CartTableView.reloadData()
                    }
                }catch{print(error)}
            }
        }.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cartrecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CartTableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        let item = Cartrecords[indexPath.row]
        cell.drinkName.text = item.fields.drinkName
        cell.sizeLabel.text = item.fields.size
        cell.sugarLabel.text = item.fields.sugar
        cell.tempLabel.text = item.fields.temp
        cell.plusLabel.text = item.fields.plus
        cell.orderName.text = item.fields.orderName
        
        return cell
    }
    
    
}
