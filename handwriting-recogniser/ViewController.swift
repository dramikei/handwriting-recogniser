//
//  ViewController.swift
//  handwriting-recogniser
//
//  Created by Raghav Vashisht on 06/06/18.
//  Copyright © 2018 Raghav Vashisht. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    
    //Variables
    var lastPoint:CGPoint!
    var isSwiping:Bool!
    //Constants
    let model = try! VNCoreMLModel(for: HandRecogniser2().model)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            let currentContext = UIGraphicsGetCurrentContext()
            currentContext?.move(to: lastPoint)
            currentContext?.addLine(to: currentPoint)
            currentContext?.setLineCap(.round)
            currentContext?.setLineWidth(9.0)
            currentContext?.setStrokeColor(UIColor.black.cgColor)
            currentContext?.setAlpha(1)
            currentContext?.strokePath()
            imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isSwiping {
            UIGraphicsBeginImageContext(imageView.frame.size)
            imageView.image?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height))
            let currentContext = UIGraphicsGetCurrentContext()
            currentContext?.setLineCap(.round)
            currentContext?.setLineWidth(9.0)
            currentContext?.setStrokeColor(UIColor.black.cgColor)
            currentContext?.setAlpha(1)
            currentContext?.move(to: lastPoint)
            currentContext?.addLine(to: lastPoint)
            currentContext?.strokePath()
            imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }
    
    @IBAction func crearBtnPressed(_ sender: UIButton) {
        imageView.image = nil
    }
    
    @IBAction func decideBtnPressed(_ sender: UIButton) {
        if imageView.image != nil {
            makePrediction(image: imageView.image!)
        } else {
            predictionLabel.isHidden = false
            predictionLabel.text = "Write A Character First!"
        }
    }
    func results(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation]
            else { fatalError("huh") }
        
        for classification in results {
            if classification.confidence > 0.6 {
                let identification = classification.identifier
                self.predictionLabel.text = identification
                break
            }
        }
        
    }
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        return context.createCGImage(inputImage, from: inputImage.extent)
    }
    
    func makePrediction(image: UIImage) {
        let request = VNCoreMLRequest(model: model, completionHandler: results)
        let handler = VNImageRequestHandler(cgImage:  convertCIImageToCGImage(inputImage: CIImage(image: image)!))
        do {
            try handler.perform([request])
        }
        catch {
            fatalError("Huh")
        }
  
    }
    
    
    
}

