//
//  PanOffsetVC.swift
//  PanOffsetView
//
//  Created by M M Mehedi Hasan on 25/1/23.
//

import UIKit

protocol PanOffsetVCDelegate: NSObjectProtocol {
    
    func beginMovingFromPanOffsetVC(center: CGPoint)
    func changingMovingFromPanOffsetVC(center: CGPoint)
    func endMovingFromPanOffsetVC(center: CGPoint)
    
    func sizeValueChangedFromPanOffsetVC(value: CGFloat)
}

class PanOffsetVC: UIViewController {

    weak var panOffsetVCDelegate: PanOffsetVCDelegate?
    
    @IBOutlet weak var panMainOffsetView: PanOffsetMainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.panMainOffsetView.panOffsetMainViewDelegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func tappedOnBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension PanOffsetVC: PanOffsetMainViewDelegate {
    
    func beginMovingFromPanOffsetMainView(center: CGPoint) {
        self.panOffsetVCDelegate?.beginMovingFromPanOffsetVC(center: center)
    }
    
    func changingMovingFromPanOffsetMainView(center: CGPoint) {
        self.panOffsetVCDelegate?.changingMovingFromPanOffsetVC(center: center)
    }
    
    func endMovingFromPanOffsetMainView(center: CGPoint) {
        self.panOffsetVCDelegate?.endMovingFromPanOffsetVC(center: center)
    }
    
    func sizeValueChangedFromPanOffsetMainView(value: CGFloat) {
        self.panOffsetVCDelegate?.sizeValueChangedFromPanOffsetVC(value: value)
    }
    
}
