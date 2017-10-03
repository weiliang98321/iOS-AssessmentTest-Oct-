//
//  NewCandidateScreenViewController.swift
//  NextAcademy - iOS Assessment Test(Tan Wei Liang)
//
//  Created by Tan Wei Liang on 03/10/2017.
//  Copyright © 2017 Tan Wei Liang. All rights reserved.
//

import UIKit


class NewCandidateScreenViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
 
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loveImageView: UIImageView!
    
    @IBAction func panImage(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        if xFromCenter > 0 {
            loveImageView.image = #imageLiteral(resourceName: "icons8-filled_like_filled")
            loveImageView.tintColor = UIColor.red
        } else {
            loveImageView.image = #imageLiteral(resourceName: "icons8-dislike_filled")
            loveImageView.tintColor = UIColor.black
        }
        
        loveImageView.alpha = abs(xFromCenter) / view.center.x
        
        
        
        if sender.state == UIGestureRecognizerState.ended{
            
            if card.center.x < 75 {
                //Move to the left side
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                return
            } else if card.center.x > (view.frame.width - 75) {
                    //move to the right side
                    UIView.animate(withDuration: 0.3, animations: {
                        card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                        card.alpha = 0
                    })
                    return
                }
            }
            
        
        
        
        
     
        
    }
    
    @IBAction func reset(_ sender: UIButton) {
        resetCard()
    }
    
    func resetCard() {
        UIView.animate(withDuration: 0.2) {
            self.imageView.center = self.view.center
            self.loveImageView.alpha = 0
            self.imageView.alpha = 1
        }
    }
    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view
        let point = sender.translation(in: view)
        
        if sender.state == UIGestureRecognizerState.ended{
            UIView.animate(withDuration: 0.2, animations: {
                card?.center = self.view.center
            })
        }
        
        card?.center = CGPoint(x: view.center.x + point.x , y: view.center.y + point.y)
        
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  
}


