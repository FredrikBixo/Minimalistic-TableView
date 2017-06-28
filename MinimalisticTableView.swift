//
//  Minimalistic ScrollView.swift
//
//  Created by Fredrik Bixo on 2017-01-21.
//  Copyright © 2017 Fredrik Bixo. All rights reserved.
//

import UIKit

fileprivate var animateWidth:CGFloat = 250

// MARK: Delegate

extension MinimalisticTableView:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        for view in self.subviews {
            
            if let view = view as? AnimationView {
                if view.frame.intersects(CGRect(origin: scrollView.contentOffset, size: CGSize(width: scrollView.frame.size.width+20, height: scrollView.frame.size.height))) {
                    // the view is visible
                    view.outAnimate()
                } else {
                    view.inAnimate()
                }
                
            }
            
            if let button = view as? UIButton {
                if button.frame.intersects(CGRect(origin: scrollView.contentOffset, size: CGSize(width: scrollView.frame.size.width+20, height: scrollView.frame.size.height))) {
                    // the view is visible
                    UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseOut, animations: {
                        button.alpha = 1
                    }, completion: nil)
                } else {
                    UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseOut, animations: {
                        button.alpha = 0
                    }, completion: nil)
                }
                
            }
            
            if let label = view as? UILabel {
                if label.frame.intersects(CGRect(origin: scrollView.contentOffset, size: CGSize(width: scrollView.frame.size.width+20, height: scrollView.frame.size.height))) {
                    // the view is visible
                    UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseOut, animations: {
                        label.alpha = 1
                    }, completion: nil)
                } else {
                    UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseOut, animations: {
                        label.alpha = 0
                    }, completion: nil)
                }
                
            }
            
            
        }
        
    }
}

class MinimalisticTableView: UIScrollView {

    var items = [String]()
    
    init(frame:CGRect, items:[String]) {
        super.init(frame: frame)
        self.items = items
        self.setup(width:frame.size.width)
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setup(width:CGFloat) {
        let height = items.count*120
        self.contentSize = CGSize(width:width,height:CGFloat(height))
        
        // create views
        for i in 1...items.count {
            let animationView = AnimationView(frame: CGRect(x: width-animateWidth, y: CGFloat(i*120)-40, width: animateWidth, height: 2))
            animationView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
            self.addSubview(animationView)
            
            let subGoalLabel = UILabel(frame: CGRect(x: width-animateWidth, y: CGFloat(i*120)-35-40, width: animateWidth, height: 30))
            subGoalLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            subGoalLabel.text = items[i-1]
            self.addSubview(subGoalLabel)
            
            let button = UIButton(frame: CGRect(x: width-animateWidth-44-16, y: CGFloat(i*120)-40-22, width: 44, height: 44))
            button.setImage(UIImage.Asset.PlusIcon.image, for: .normal)
            button.addTarget(self, action: #selector(SexyScrollView.checkMarkHandler) , for: .touchUpInside)
            self.addSubview(button)

        }
    
    for view in self.subviews {
        
        if let view = view as? AnimationView {
            if view.frame.intersects(CGRect(origin: self.contentOffset, size: CGSize(width: self.frame.size.width+20, height: self.frame.size.height))) {
                // the view is visible
                view.frame.origin.x = (self.superview?.frame.size.width)!-animateWidth
                view.frame.size.width = animateWidth
            } else {
                view.frame.origin.x = (self.superview?.frame.size.width)!
                view.frame.size.width = 0
            }
            
        }
        
        if let button = view as? UIButton {
            if button.frame.intersects(CGRect(origin: self.contentOffset, size: CGSize(width: self.frame.size.width+20, height: self.frame.size.height))) {
                // the view is visible
                button.alpha = 1
            } else {
                button.alpha = 0
            }
            
        }
        
        if let label = view as? UILabel {
            if label.frame.intersects(CGRect(origin: self.contentOffset, size: CGSize(width: self.frame.size.width+20, height: self.frame.size.height))) {
                // the view is visible
                UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseOut, animations: {
                    label.alpha = 1
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseOut, animations: {
                    label.alpha = 0
                }, completion: nil)
            }
            
        }
        
        
    }
    
    
    }
    
    // MARK: Handlers
    
    func checkMarkHandler() {
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class AnimationView:UIView {
    
    var isAnimating = false
    
    func outAnimate() {
        if isAnimating == true {
            return
        }
        
        self.isAnimating = true
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.frame.origin.x = (self.superview?.frame.size.width)!-animateWidth
            self.frame.size.width = animateWidth
        }, completion: { _ in self.isAnimating = false })
    }
    
    func inAnimate() {
        if isAnimating == true {
            return
        }
        
        self.isAnimating = true
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.frame.origin.x = (self.superview?.frame.size.width)!
            self.frame.size.width = 0
        }, completion: { _ in self.isAnimating = false })
    }
    
}
