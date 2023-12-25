//
//  File.swift
//  BGTemplate

import Foundation
import UIKit
import AVKit

protocol PanOffsetMainViewDelegate: NSObjectProtocol {
    func beginMovingFromPanOffsetMainView(center: CGPoint)
    func changingMovingFromPanOffsetMainView(center: CGPoint)
    func endMovingFromPanOffsetMainView(center: CGPoint)
    
    func sizeValueChangedFromPanOffsetMainView(value: CGFloat)
}

class PanOffsetMainView: UIView {
    
    
    weak var panOffsetMainViewDelegate: PanOffsetMainViewDelegate?
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var yCordSlider: UISlider!
    @IBOutlet weak var xCordSlider: UISlider!
    @IBOutlet weak var sizeSlider: UISlider!
    
    @IBOutlet weak var panTopOffsetView: PanTopOffsetView!
    
    var isFIrst: Bool = true
    var maxSize: CGFloat = 100.0
    var initCenter: CGPoint = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("PANNNNN11111")
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("PANNNNN2222")
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.isFIrst {
            self.isFIrst = false
            self.layoutIfNeeded()
        }
    }
    
    func commonInit() {
        print("PANNNNN")
        Bundle.main.loadNibNamed("PanOffsetMainView", owner: self, options: nil)
        self.containerView.frame = self.bounds
        self.containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(self.containerView)

        
        self.sizeSlider.addTarget(self, action: #selector(changeSizeCordinateSlider), for: .valueChanged)
        self.xCordSlider.addTarget(self, action: #selector(changeXCordinateSlider), for: .valueChanged)
        self.yCordSlider.addTarget(self, action: #selector(changeYCordinateSlider), for: .valueChanged)
        
        self.panTopOffsetView.panTopOffsetViewDelegate = self
    }
    
    @objc func changeYCordinateSlider(sender: UISlider, event: UIEvent) {
        
        if let touchEvent = event.allTouches?.first {
            
            switch touchEvent.phase {
            case .began:
                self.initCenter =  self.panTopOffsetView.panMoveOffsetView?.center ?? .zero
                
                let currCenter = CGPoint(x:self.panTopOffsetView.center.x - self.initCenter.x, y: self.panTopOffsetView.center.y - self.initCenter.y)
                
                self.panOffsetMainViewDelegate?.beginMovingFromPanOffsetMainView(center: currCenter)
                break
            case .moved:
                
                let maxHeight = self.panTopOffsetView.bounds.height - (self.panTopOffsetView.panMoveOffsetView!.bounds.height * 1)
                
                let originY = maxHeight * CGFloat(sender.value)
                self.panTopOffsetView.panMoveOffsetView?.frame.origin.y = originY
               
                let center = self.panTopOffsetView.panMoveOffsetView?.center ?? .zero
                
                let currCenter = CGPoint(x:self.panTopOffsetView.center.x - center.x, y: self.panTopOffsetView.center.y - center.y)
                
                self.panOffsetMainViewDelegate?.changingMovingFromPanOffsetMainView(center: currCenter)
                break
            case .ended:
               // let currS = CGFloat(max(0.2, sender.value)) * self.maxSize
                let center = self.panTopOffsetView.panMoveOffsetView?.center ?? .zero
                
                let currCenter = CGPoint(x:self.panTopOffsetView.center.x - center.x, y: self.panTopOffsetView.center.y - center.y)
                
                self.panOffsetMainViewDelegate?.endMovingFromPanOffsetMainView(center: currCenter)
              
                break
            default:
                break
            }
        }
    }
    
    @objc func changeXCordinateSlider(sender: UISlider, event: UIEvent) {
        
        if let touchEvent = event.allTouches?.first {
            
            switch touchEvent.phase {
            case .began:
                self.initCenter =  self.panTopOffsetView.panMoveOffsetView?.center ?? .zero
                
                let currCenter = CGPoint(x:self.panTopOffsetView.center.x - self.initCenter.x, y: self.panTopOffsetView.center.y - self.initCenter.y)
                
                self.panOffsetMainViewDelegate?.beginMovingFromPanOffsetMainView(center: currCenter)
                break
            case .moved:
            
                let maxWidth = self.panTopOffsetView.bounds.width - (self.panTopOffsetView.panMoveOffsetView!.bounds.width * 1)
                
                let maxHeight = self.panTopOffsetView.bounds.height - (self.panTopOffsetView.panMoveOffsetView!.bounds.height * 1)
                
                let originX = maxWidth * CGFloat(sender.value)
                self.panTopOffsetView.panMoveOffsetView?.frame.origin.x = originX
                
                let center = self.panTopOffsetView.panMoveOffsetView?.center ?? .zero
                
                
                let currCenter = CGPoint(x:self.panTopOffsetView.center.x - center.x, y: self.panTopOffsetView.center.y - center.y)
                
                self.panOffsetMainViewDelegate?.changingMovingFromPanOffsetMainView(center: currCenter)
                
                break
            case .ended:
              
                let center = self.panTopOffsetView.panMoveOffsetView?.center ?? .zero
                
                let currCenter = CGPoint(x:self.panTopOffsetView.center.x - center.x, y: self.panTopOffsetView.center.y - center.y)
                
                self.panOffsetMainViewDelegate?.endMovingFromPanOffsetMainView(center: currCenter)
                break
            default:
                break
            }
        }
        
    }

    @objc func changeSizeCordinateSlider(sender: UISlider, event: UIEvent) {
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                self.initCenter =  self.panTopOffsetView.panMoveOffsetView?.center ?? .zero
                break
            case .moved:
                let currS = CGFloat(max(0.2, sender.value)) * self.maxSize
                self.panTopOffsetView.panMoveOffsetView?.frame.size = CGSize(width: currS, height: currS)
                
                self.panOffsetMainViewDelegate?.sizeValueChangedFromPanOffsetMainView(value: currS)
                
                self.panTopOffsetView.layoutIfNeeded()
                self.panTopOffsetView.panMoveOffsetView?.updateCornerRadius()
                self.panTopOffsetView.panMoveOffsetView?.center = self.initCenter
                
                self.panTopOffsetView.panMoveOffsetView?.checkBoundary(bounds: self.panTopOffsetView.bounds, currCenter: self.initCenter)
                self.changingMovingFromPanTopOffsetView(center: self.center)
                
                break
            case .ended:
                let currS = CGFloat(max(0.2, sender.value)) * self.maxSize
                self.panTopOffsetView.panMoveOffsetView?.frame.size = CGSize(width: currS, height: currS)
                self.panOffsetMainViewDelegate?.sizeValueChangedFromPanOffsetMainView(value: currS)
                self.panTopOffsetView.layoutIfNeeded()
                let center = self.panTopOffsetView.panMoveOffsetView?.center ?? .zero
                self.panTopOffsetView.panMoveOffsetView?.updateCornerRadius()
                
                self.panTopOffsetView.panMoveOffsetView?.center = self.initCenter
                
                self.panTopOffsetView.panMoveOffsetView?.checkBoundary(bounds: self.panTopOffsetView.bounds, currCenter: self.initCenter)
                break
            default:
                break
            }
        }
    }
    
}

extension PanOffsetMainView: PanTopOffsetViewDelegate {
    
    func beginMovingFromPanTopOffsetView(center: CGPoint) {
        self.panOffsetMainViewDelegate?.beginMovingFromPanOffsetMainView(center: center)
    }
    
    func changingMovingFromPanTopOffsetView(center: CGPoint) {
        
        let maxWidth = self.panTopOffsetView.bounds.width - (self.panTopOffsetView.panMoveOffsetView!.bounds.width * 1)
        let maxHeight = self.panTopOffsetView.bounds.height - (self.panTopOffsetView.panMoveOffsetView!.bounds.height * 1)
        
        let originX = self.panTopOffsetView.panMoveOffsetView!.frame.origin.x
        let originY = self.panTopOffsetView.panMoveOffsetView!.frame.origin.y
        
        let ratioX = (originX) / maxWidth
        let ratioY = (originY) / maxHeight
        
        print("Ratioooo  ", maxWidth,"  ", originX,"   ")
        
        self.xCordSlider.value = Float(ratioX) //* 0.8
        
        self.yCordSlider.value = Float(ratioY) //* 0.8
        
        self.panOffsetMainViewDelegate?.changingMovingFromPanOffsetMainView(center: center)
    }
    
    func endMovingFromPanTopOffsetView(center: CGPoint) {
        self.panOffsetMainViewDelegate?.endMovingFromPanOffsetMainView(center: center)
    }
    
}
