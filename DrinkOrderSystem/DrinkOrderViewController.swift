//
//  DrinkOrderViewController.swift
//  DrinkOrderSystem
//
//  Created by Ryan Chang on 2021/5/7.
//

import UIKit

class DrinkOrderViewController: UIViewController {

    @IBOutlet weak var menuScrollView: UIScrollView!
    @IBOutlet weak var menuSelectSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var secondTableView: UITableView!
    @IBOutlet weak var thirdTableView: UITableView!
    @IBOutlet weak var fourthTableView: UITableView!
    
    var GTrecords = [GoodTeaRecords]()
    var Lrecords = [LetteRecords]()
    var MTrecords = [MilkTeaRecords]()
    var FTrecords = [FreshTeaRecords]()
    
    let order:String
    
    @IBOutlet weak var loadingAnimate: UIActivityIndicatorView!
    
    
    init?(coder:NSCoder, order:String) {
        self.order = order
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feitchGoodTea()
        feitchLette()
        feitchMilkTea()
        feitchFreshTea()

        // Do any additional setup after loading the view.
    }
    
    
    @IBSegueAction func menuDetail(_ coder: NSCoder) -> OrderDrinkDetailTableViewController? {
        guard let row = firstTableView.indexPathForSelectedRow?.row else{return nil}
        let item = GTrecords[row]
        let controller = OrderDrinkDetailTableViewController(coder: coder)
        controller?.drinkName = item.fields.drinkName
        controller?.large = item.fields.large
        controller?.medium = item.fields.medium
        controller?.orderName = order
        return controller
    }
        

    @IBSegueAction func letteDetail(_ coder: NSCoder) -> OrderDrinkDetailTableViewController? {
        guard let row = secondTableView.indexPathForSelectedRow?.row else { return nil }
        let item = Lrecords[row]
        let controller = OrderDrinkDetailTableViewController(coder: coder)
        controller?.drinkName = item.fields.drinkName
        controller?.large = item.fields.large
        controller?.medium = item.fields.medium
        controller?.orderName = order
        return controller
    }
    
    @IBSegueAction func milkTeaDetail(_ coder: NSCoder) -> OrderDrinkDetailTableViewController? {
        guard let row = thirdTableView.indexPathForSelectedRow?.row else { return nil }
        let item = MTrecords[row]
        let controller = OrderDrinkDetailTableViewController(coder: coder)
        controller?.drinkName = item.fields.drinkName
        controller?.large = item.fields.large
        controller?.medium = item.fields.medium
        controller?.orderName = order
        return controller
    }

    @IBSegueAction func freshTeaDetail(_ coder: NSCoder) -> OrderDrinkDetailTableViewController? {
        guard let row = fourthTableView.indexPathForSelectedRow?.row else { return nil }
        let item = FTrecords[row]
        let controller = OrderDrinkDetailTableViewController(coder: coder)
        controller?.drinkName = item.fields.drinkName
        controller?.large = item.fields.large
        controller?.medium = item.fields.medium
        controller?.orderName = order
        return controller
    }
    
        
    
    func feitchGoodTea(){
        self.loadingAnimate.startAnimating()
        let url = URL(string:"https://api.airtable.com/v0/appT2AsMEtXCG8YNH/goodTea")!
        var request = URLRequest(url: url)
        request.setValue("Bearer keytFVXh8KVH8kva6", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               //content用來驗證有無抓到資料
               let content = String(data:data, encoding: .utf8){
//                print(content)
                
                let decoder = JSONDecoder()
                do{print("success")
                    let goodTeaResponse = try decoder.decode(GoodTea.self, from: data)
                    self.GTrecords = goodTeaResponse.records
                    DispatchQueue.main.async {
                        self.loadingAnimate.stopAnimating()
                        self.firstTableView.reloadData()
                    }
                }catch {print(error)}
            }
        }.resume()
    }
    
    func feitchLette(){
        self.loadingAnimate.startAnimating()
        let url = URL(string:"https://api.airtable.com/v0/appT2AsMEtXCG8YNH/lette")!
        var request = URLRequest(url: url)
        request.setValue("Bearer keytFVXh8KVH8kva6", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               //content用來驗證有無抓到資料
               let content = String(data:data, encoding: .utf8){
//                print(content)
                
                let decoder = JSONDecoder()
                do{
                    let letteResponse = try decoder.decode(Lette.self, from: data)
                    self.Lrecords = letteResponse.records
                    DispatchQueue.main.async {
                        self.loadingAnimate.stopAnimating()
                        self.secondTableView.reloadData()
                    }
                }catch {print(error)}
            }
        }.resume()
    }
    
    func feitchMilkTea(){
        self.loadingAnimate.startAnimating()
        let url = URL(string:"https://api.airtable.com/v0/appT2AsMEtXCG8YNH/milkTea")!
        var request = URLRequest(url: url)
        request.setValue("Bearer keytFVXh8KVH8kva6", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               //content用來驗證有無抓到資料
               let content = String(data:data, encoding: .utf8){
//                print(content)
                
                let decoder = JSONDecoder()
                do{
                    let milkTeaResponse = try decoder.decode(MilkTea.self, from: data)
                    self.MTrecords = milkTeaResponse.records
                    DispatchQueue.main.async {
                        self.loadingAnimate.stopAnimating()
                        self.thirdTableView.reloadData()
                    }
                }catch {print(error)}
            }
        }.resume()
    }
    
    func feitchFreshTea(){
        self.loadingAnimate.startAnimating()
        let url = URL(string:"https://api.airtable.com/v0/appT2AsMEtXCG8YNH/freshTea")!
        var request = URLRequest(url: url)
        request.setValue("Bearer keytFVXh8KVH8kva6", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               //content用來驗證有無抓到資料
               let content = String(data:data, encoding: .utf8){
//                print(content)
                
                let decoder = JSONDecoder()
                do{print("1")
                    let freshTeaResponse = try decoder.decode(FreshTea.self, from: data)
                    print("2")
                    self.FTrecords = freshTeaResponse.records
                    DispatchQueue.main.async {
                        print("3")
                        self.loadingAnimate.stopAnimating()
                        self.fourthTableView.reloadData()
                    }
                }catch {print(error)}
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
    
    //segmentControl來控制scroll View 的位置
    @IBAction func pageChange(_ sender: UISegmentedControl) {
        let point = CGPoint(x: menuScrollView.bounds.width * CGFloat(sender.selectedSegmentIndex), y: 0)
        
        menuScrollView.setContentOffset(point, animated: true)
    }
    
}

//tableView 放進scroll View後讓scroll View 的位置來控制segmentcontrol
extension DrinkOrderViewController: UIScrollViewDelegate  {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        menuSelectSegmentControl.selectedSegmentIndex = Int(page)
    }
}

//回傳不同的tableView 的numberOfRowsInSection 和 cell
extension DrinkOrderViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView : UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.firstTableView {
            return GTrecords.count
        }else if tableView == self.secondTableView {
            return Lrecords.count
        }else if tableView == self.thirdTableView {
            return MTrecords.count
        }else  {
            return FTrecords.count
        }
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.firstTableView {
        let cell = firstTableView.dequeueReusableCell(withIdentifier: "GoodTeaTableViewCell", for: indexPath) as! GoodTeaTableViewCell
        let item = GTrecords[indexPath.row]
        cell.drinkNameLabel.text = item.fields.drinkName
        cell.largeLabel.text = "大杯:\(item.fields.large)"
        cell.mediumLabel.text = "中杯:\(item.fields.medium)"
        
        return cell
        }else if tableView == self.secondTableView {
            let cell = secondTableView.dequeueReusableCell(withIdentifier: "letteTableViewCell", for: indexPath) as! letteTableViewCell
            let item = Lrecords[indexPath.row]
            cell.drinkNameLabel.text = item.fields.drinkName
            cell.largeLabel.text = "大杯:\(item.fields.large)"
            cell.mediumLabel.text = "中杯:\(item.fields.medium)"
            
            return cell
        }else if tableView == self.thirdTableView{
            let cell = thirdTableView.dequeueReusableCell(withIdentifier: "milkTeaTableViewCell", for: indexPath) as! milkTeaTableViewCell
            let item = MTrecords[indexPath.row]
            cell.drinkNameLabel.text = item.fields.drinkName
            cell.largeLabel.text = "大杯:\(item.fields.large)"
            cell.mediumLabel.text = "中杯:\(item.fields.medium)"
            
            return cell
        } else {
            let cell = fourthTableView.dequeueReusableCell(withIdentifier: "freshTeaTableViewCell", for: indexPath) as! freshTeaTableViewCell
            let item = FTrecords[indexPath.row]
            cell.drinkNameLabel.text = item.fields.drinkName
            cell.largeLabel.text = "大杯:\(item.fields.large)"
            cell.mediumLabel.text = "中杯:\(item.fields.medium)"
            
            return cell
        }
    }
    
    
}
