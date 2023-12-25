//
//  File.swift
//  BGTemplate

import Foundation
import UIKit

protocol PanTopOffsetViewDelegate: NSObjectProtocol {
    func beginMovingFromPanTopOffsetView(center: CGPoint)
    func changingMovingFromPanTopOffsetView(center: CGPoint)
    func endMovingFromPanTopOffsetView(center: CGPoint)
}

class PanTopOffsetView: UIView {
    
    weak var panTopOffsetViewDelegate: PanTopOffsetViewDelegate?
    
    @IBOutlet var containerView: UIView!
    
    var isFIrst: Bool = true
    
    var panMoveOffsetView: PanMoveOffsetView?
    var maxSize: CGFloat = 100.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.isFIrst {
            self.isFIrst = false
            self.layoutIfNeeded()
            self.initializeAll()
        }
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("PanTopOffsetView", owner: self, options: nil)
        self.containerView.frame = self.bounds
        self.containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(self.containerView)
    }

}

extension PanTopOffsetView {
    
    func initializeAll() {
        
        self.panMoveOffsetView = PanMoveOffsetView(frame: CGRect(origin: .zero, size: CGSize(width: self.maxSize * 0.5, height: self.maxSize * 0.5)))
        self.panMoveOffsetView?.center = self.center
        self.panMoveOffsetView?.panMoveOffsetViewDelegate = self
        if let topPanView = self.panMoveOffsetView {
            self.containerView.addSubview(topPanView)
        }
    }
}

extension PanTopOffsetView: PanMoveOffsetViewDelegate {
    
    func beginMovingFromPanMoveOffsetView(center: CGPoint) {
        
        let currDisX = (self.center.x - center.x)
        let currDisY = (self.center.y - center.y)
        let currCenter = CGPoint(x: currDisX, y: currDisY)
        self.panTopOffsetViewDelegate?.beginMovingFromPanTopOffsetView(center: currCenter)
    }
    
    func changingMovingFromPanMoveOffsetView(center: CGPoint) {
        let currDisX = (self.center.x - center.x)
        let currDisY = (self.center.y - center.y)
        let currCenter = CGPoint(x: currDisX, y: currDisY)
        self.panTopOffsetViewDelegate?.changingMovingFromPanTopOffsetView(center: currCenter)
    }
    
    func endMovingFromPanMoveOffsetView(center: CGPoint) {
        let currDisX = (self.center.x - center.x)
        let currDisY = (self.center.y - center.y)
        let currCenter = CGPoint(x: currDisX, y: currDisY)
        self.panTopOffsetViewDelegate?.endMovingFromPanTopOffsetView(center: currCenter)
    }
    
    
}
