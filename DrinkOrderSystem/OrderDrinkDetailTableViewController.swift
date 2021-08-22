//
//  OrderDrinkDetailTableViewController.swift
//  DrinkOrderSystem
//
//  Created by Ryan Chang on 2021/5/8.
//

import UIKit

class OrderDrinkDetailTableViewController: UITableViewController, UITextFieldDelegate {

    
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var orderNameLabel: UILabel!
    
    
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var tempTextField: UITextField!
    @IBOutlet weak var sugarTextField: UITextField!
        
    @IBOutlet weak var addCoconaButton: UIButton!
    @IBOutlet weak var addKonjacButton: UIButton!
    @IBOutlet weak var addBigPearlButton: UIButton!
    @IBOutlet weak var addPearlButton: UIButton!
    
    
    @IBOutlet weak var addButton: UIButton!
    
    var drinkName = String()
    var orderName = String()
    var large = Int()
    var medium = Int()
    var addItemNote = ""

    
    var size = ""
    var sugar = ""
    var temp = ""
    var addItem = [false,false,false,false]
    
    var pickerView = UIPickerView()
    var pickerField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizeTextField.delegate = self
        sugarTextField.delegate = self
        tempTextField.delegate = self
        drinkNameLabel.text = drinkName
        orderNameLabel.text = orderName
        
        //從程式碼增加手勢操作，點擊空白處來讓鍵盤消失
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tap)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //點擊空白處讓鍵盤消失
    @objc func dismissKeyBoard(){
        self.view.endEditing(true)
    }

    
    @IBAction func addToCart(_ sender: Any) {
        
        guard  self.orderCheck()  else { return }
        let controller = UIAlertController(title: "確定加入訂單？", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "確定", style: .default) { _ in
            
            //確認加料的部分存在字串裡
            self.addItemCheck()
            
            let order = Order(records:[.init(fields: .init(orderName: self.orderNameLabel.text!, drinkName: self.drinkNameLabel.text!, size: self.sizeTextField.text!, sugar: self.sugarTextField.text!, temp: self.tempTextField.text!, plus: self.addItemNote ))] )
            let url = URL(string: "https://api.airtable.com/v0/appT2AsMEtXCG8YNH/orderList?maxRecords=3&view=Grid%20view")!
            var request = URLRequest(url: url)
            request.setValue("Bearer keytFVXh8KVH8kva6", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let encoder = JSONEncoder()
            request.httpBody = try? encoder.encode(order)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let res = response as? HTTPURLResponse , res.statusCode == 200 {
                    print("success")
                }else {
                    print("error")
                }
            }.resume()
            self.end()
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(action)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    //新增資料後使用UIAlertController來跳回首頁
    func end(){
        let controler = UIAlertController(title: "訂單", message: "新增成功", preferredStyle: .alert)
        let action = UIAlertAction(title: "確定", style: .default) { UIAlertAction in
            self.navigationController?.popToRootViewController(animated: true)
        }
        controler.addAction(action)
        present(controler, animated: true, completion: nil)
    }
    
    //使用字串來記錄點選的加料部分
    func addItemCheck(){
        for i in 0 ... 3 {
            switch i {
            case 0:
                if addItem[i] == true{
                    let a = " 波霸 "
                    addItemNote += a
                }
            case 1:
                if addItem[i] == true{
                    let b = " 珍珠 "
                    addItemNote += b
                }
            case 2:
                if addItem[i] == true{
                    let c = " 蒟蒻 "
                    addItemNote += c
                }
            case 3:
                if addItem[i] == true{
                    let d = " 椰果 "
                    addItemNote += d
                }
            default:
                return
            }
        }
        //因為抓取資料時，如果有空格，則資料無法正常獲取，所以會新增一個判斷來讓無資料的時候變成”無“
        if addItemNote == "" {
            addItemNote = "無"
        }
    }
    
    //修改檢視的價格，在選擇size按下確認的時候進行
    func priceCheck(){
        if sizeTextField.text == ""{
            moneyLabel.text = "共?元"
        }else if sizeTextField.text == "大杯"{
            moneyLabel.text = "共\(large)元"
        }else if sizeTextField.text == "中杯"{
            moneyLabel.text = "共\(medium)元"
        }
    }
    
    //使用IBAction ＋ tag ＋陣列來存取bool，來記錄加料的選項和圓點圖形判斷
    @IBAction func addItem(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if addItem[sender.tag] == false {
                addBigPearlButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
                addItem[sender.tag] = true
                print(addItem[0],sender.tag)
            }else {
                addBigPearlButton.setImage(UIImage(systemName: "circle"), for: .normal)
                addItem[sender.tag] = false
                print(addItem[0],sender.tag)
            }
        case 1:
            if addItem[sender.tag] == false {
                addPearlButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
                addItem[sender.tag] = true
                print(addItem[1],sender.tag)
            }else {
                addPearlButton.setImage(UIImage(systemName: "circle"), for: .normal)
                addItem[sender.tag] = false
                print(addItem[1],sender.tag)
            }
        case 2:
            if addItem[sender.tag] == false {
                addKonjacButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
                addItem[sender.tag] = true
                print(addItem[2],sender.tag)
            }else {
                addKonjacButton.setImage(UIImage(systemName: "circle"), for: .normal)
                addItem[sender.tag] = false
                print(addItem[2],sender.tag)
            }
        case 3:
            if addItem[sender.tag] == false {
                addCoconaButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
                addItem[sender.tag] = true
                print(addItem[3],sender.tag)
            }else {
                addCoconaButton.setImage(UIImage(systemName: "circle"), for: .normal)
                addItem[sender.tag] = false
                print(addItem[3],sender.tag)
            }
            //可以讓true to false // false to truen
//            addItem[sender.tag] = !addItem[sender.tag]
        default:
            break
        }
    }
    

    
    //確認主要格子都有填入
    func orderCheck() -> Bool {
        var check = true
        var message = ""
        
        if sizeTextField.text == "" {
            message = "容量沒有選擇"
            check = false
        }else if tempTextField.text == ""{
            message = "溫度沒有選擇"
            check = false
        }else if sugarTextField.text == ""{
            message = "甜度沒有選擇"
            check = false
        }
        if check == false {
            let controller = UIAlertController(title: "", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "確定", style: .cancel, handler: nil)
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
        }
        return check
    }
    
    //點擊空白出讓鍵盤消失，但是這裡失敗了，所以改使用dissmissKeyBorad的func來執行
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
    
    
    
    // MARK: - Table view data source
/*沒有把這裡隱藏起來會看不到東西
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension來宣告UIPickerViewDelegate, UIPickerViewDataSource
extension OrderDrinkDetailTableViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func initpickerView(thouchAt sender:UITextField){
        pickerView = UIPickerView()
        pickerView.tag = 0
        if sender == sizeTextField {
            pickerView.tag = 0
        }else if sender == sugarTextField {
            pickerView.tag = 1
        }else if sender == tempTextField {
            pickerView.tag = 2
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .systemPurple
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "確認", style: .plain, target: self, action: #selector(submit))
        
        doneButton.tag = pickerView.tag
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancel))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        
        pickerField = UITextField(frame: CGRect.zero)
        view.addSubview(pickerField)
        pickerField.inputView = pickerView
        pickerField.inputAccessoryView = toolBar
        
        pickerField.becomeFirstResponder()
        var index = 0
        if pickerField.tag == 0{
            index = Size.init().level.firstIndex(of: size) ?? 0
        }else if pickerField.tag == 1 {
            index = Sugar.init().level.firstIndex(of: sugar) ?? 0
        }else if pickerField.tag == 2 {
            index = Temp.init().level.firstIndex(of: temp) ?? 0
        }
        pickerView.selectRow(index, inComponent: 0, animated: false)
    }
    
    //pickerView 確認
    @objc func submit(sender: UIBarButtonItem){
        let pickerViewtag = sender.tag
        if pickerViewtag == 0 {
            //裡面都會使用到self,所以可以包在最前面，以下兩種寫法相同
            DispatchQueue.main.async { [self] in
                let row = pickerView.selectedRow(inComponent: 0)
                sizeTextField.text = Size.init().level[row]
                pickerField.resignFirstResponder()
                
                //檢查價格並修改
                priceCheck()
            }
        }else if pickerViewtag == 1 {
            DispatchQueue.main.async {
                let row = self.pickerView.selectedRow(inComponent: 0)
                self.sugarTextField.text = Sugar.init().level[row]
                self.pickerField.resignFirstResponder()
            }
        }else if pickerViewtag == 2 {
            DispatchQueue.main.async { [self] in
                let row = pickerView.selectedRow(inComponent: 0)
                tempTextField.text = Temp.init().level[row]
                pickerField.resignFirstResponder()
            }
        }
        
        
    }
    
    //pickerView 取消
    @objc func cancel(){
            self.pickerField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return Size.init().level.count
        }else if pickerView.tag == 1 {
            return Sugar.init().level.count
        }else if pickerView.tag == 2 {
            return Temp.init().level.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return Size.init().level[row]
        }else if pickerView.tag == 1 {
            return Sugar.init().level[row]
        }else if pickerView.tag == 2 {
            return Temp.init().level[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            self.size = Size.init().level[row]
        } else if pickerView.tag == 1 {
            self.sugar = Sugar.init().level[row]
        } else if pickerView.tag == 2 {
            self.temp = Temp.init().level[row]
        }
    }
}



extension OrderDrinkDetailTableViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.initpickerView(thouchAt: textField)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
