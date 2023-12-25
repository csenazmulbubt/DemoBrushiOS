//
//  File.swift
//  BGTemplate

import Foundation
import UIKit

protocol PanMoveOffsetViewDelegate: NSObjectProtocol {
    func beginMovingFromPanMoveOffsetView(center: CGPoint)
    func changingMovingFromPanMoveOffsetView(center: CGPoint)
    func endMovingFromPanMoveOffsetView(center: CGPoint)
}

class PanMoveOffsetView: UIView {
    
    weak var panMoveOffsetViewDelegate: PanMoveOffsetViewDelegate?
    
    private lazy var moveGesture = {
        return UIPanGestureRecognizer(target: self, action: #selector(handleMoveGesture(_:)))
    }()

    @IBOutlet var containerView: UIView!
    
    var isFIrst: Bool = true
    private var beginningCenter = CGPoint.zero
    
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
            self.layer.cornerRadius = self.bounds.height * 0.5
            self.clipsToBounds = true
        }
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("PanMoveOffsetView", owner: self, options: nil)
        self.containerView.frame = self.bounds
        self.containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(self.containerView)
        self.addGesture()
    }
}

extension PanMoveOffsetView {
    
    func addGesture() {
        self.containerView.addGestureRecognizer(self.moveGesture)
    }
    
    // MARK: - Gesture Handlers
    @objc
    func handleMoveGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.superview)
        switch recognizer.state {
        case .began:
            self.beginningCenter = self.center
            self.panMoveOffsetViewDelegate?.beginMovingFromPanMoveOffsetView(center: self.center)
        case .changed:
            let tempCenter = CGPoint(x: self.beginningCenter.x + translation.x, y: self.beginningCenter.y + translation.y)
            
            self.checkBoundary(bounds: self.superview?.bounds ?? .zero, currCenter: tempCenter)
            self.panMoveOffsetViewDelegate?.changingMovingFromPanMoveOffsetView(center: self.center)
            
        case .ended:
            let tempCenter = CGPoint(x: self.beginningCenter.x + translation.x, y: self.beginningCenter.y + translation.y)
            
            self.checkBoundary(bounds: self.superview?.bounds ?? .zero, currCenter: tempCenter)
            
            self.panMoveOffsetViewDelegate?.endMovingFromPanMoveOffsetView(center: self.center)
        default:
            break
        }
    }
    
    func updateCornerRadius() {
        self.layer.cornerRadius = self.bounds.height * 0.5
        self.clipsToBounds = true
    }
    
    func checkBoundary(bounds: CGRect, currCenter: CGPoint) {
        var finalPoint = currCenter
        
        if currCenter.x < (self.bounds.width * 0.5) {
            finalPoint.x = (self.bounds.width * 0.5)
        }
        
        if currCenter.y < (self.bounds.height * 0.5) {
            finalPoint.y = (self.bounds.height * 0.5)
        }
        
        let maxWidth = bounds.width - (self.bounds.width * 0.5)
        let maxHeight = bounds.height - (self.bounds.height * 0.5)
        if currCenter.x > maxWidth {
            finalPoint.x = maxWidth
        }
        
        if currCenter.y > maxHeight {
            finalPoint.y = maxHeight
        }
        
        self.center = finalPoint
    }
}
