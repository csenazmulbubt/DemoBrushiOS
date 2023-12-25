//
//  ViewController.swift
//  BurshDemo
//
//  Created by Nazmul on 07/02/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        //Change Something
    }
    
    @IBAction func tappedOnDoneButton(_ sender: UIButton) {
        let panOffsetVC = PanOffsetVC()
        panOffsetVC.modalPresentationStyle = .fullScreen
        self.present(panOffsetVC, animated: true, completion: nil)
    }
    

}

