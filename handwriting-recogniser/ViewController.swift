//
//  ViewController.swift
//  handwriting-recogniser
//
//  Created by Raghav Vashisht on 06/06/18.
//  Copyright © 2018 Raghav Vashisht. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    
    //Variables
    var lastPoint:CGPoint!
    var isSwiping:Bool!
    var red:CGFloat!
    var green:CGFloat!
    var blue:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        red = (0.0/255.0)
        green = (0.0/255.0)
        blue = (0.0/255.0)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSwiping = false
        if let touch = touches.first {
            lastPoint = touch.location(in: imageView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSwiping = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: imageView)
            UIGraphicsBeginImageContext(imageView.frame.size)
            imageView.image?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height))
            
        }
    }
    
    
    @IBAction func crearBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func decideBtnPressed(_ sender: UIButton) {
    }
    

}

