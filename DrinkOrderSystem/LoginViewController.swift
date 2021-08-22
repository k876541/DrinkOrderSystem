//
//  ViewController.swift
//  DrinkOrderSystem
//
//  Created by Ryan Chang on 2021/5/6.
//

import UIKit

var order = Name(orderName: "")

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let _ = segue.destination as? NewViewController
//    }

    //使用instantiateViewController
    @IBAction func startAct(_ sender: Any) {
        if nameTextField.text == ""{
            let controller = UIAlertController(title: "請輸入名字！", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "確定", style: .cancel,handler: nil)
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
        } else {
            order.name = nameTextField.text!
            if let controller = storyboard?.instantiateViewController(identifier: "DrinkOrderViewController", creator: { NSCoder in
                DrinkOrderViewController(coder: NSCoder,order: self.nameTextField.text!)
            }){
                controller.modalPresentationStyle = .fullScreen
                show(controller, sender: nil)
            }
        }
    }
    
    
    

    
}



