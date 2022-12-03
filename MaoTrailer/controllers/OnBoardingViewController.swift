//
//  ViewController.swift
//  MaoTrailer
//
//  Created by mohab on 9/11/22.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    var index = 0
    
    var listOfOnBoardingTexts = [
    """
    Get the first Movie
    &TV information
""",
    """
Know the movie
is not worth Watching
""",
    """
Real-time
updates movie Trailer
"""
    ]
    var listOfImages = [
    "onBoarding_1",
    "onBoarding_2",
    "onBoarding_3"
    ]
    
    var buttonColor = [
        UIColor(red: 255/255, green: 163/255, blue: 0, alpha: 1.0).cgColor,
        UIColor(red: 219/255, green: 48/255, blue: 105/255, alpha: 1.0).cgColor
    ]
    
    var listOfColors = [
        [
           UIColor.systemOrange.cgColor.copy(alpha: 0.1)!,
           UIColor(red: 228/255, green: 81/255, blue: 73/255, alpha: 1.0).cgColor.copy(alpha: 1.0)!,
       ],
        [
            UIColor.clear.cgColor,
           UIColor(red: 245/255, green: 213/255, blue: 71/255, alpha: 1.0).cgColor.copy(alpha: 1.0)!,
       ],
        [
            UIColor.clear.cgColor,
           UIColor(red: 52/255, green: 92/255, blue: 197/255, alpha: 1.0).cgColor.copy(alpha: 1.0)!,
       ],
    ]

    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var onBoardingLabel: UILabel!
    let gradientLayer   = CAGradientLayer()
    let buttonGradient = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonGradient.startPoint = CGPointMake(0.0, 0.5);
        buttonGradient.endPoint = CGPointMake(1.0, 0.5);
        buttonGradient.frame = nextButton.bounds
        buttonGradient.colors = buttonColor
        buttonGradient.cornerRadius = 30
        nextButton.layer.borderWidth = 2
        nextButton.layer.cornerRadius = 30
        nextButton.layer.borderColor = UIColor.white.cgColor

        gradientLayer.frame = view.bounds
        gradientLayer.colors = listOfColors[0]
        bgView.image = UIImage(named: listOfImages[0])
        bgView.layer.addSublayer(gradientLayer)
        onBoardingLabel.text = listOfOnBoardingTexts[0]
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        index += 1
        if index < 3{
            onBoardingLabel.text = listOfOnBoardingTexts[index]

            gradientLayer.colors = listOfColors[index]
            bgView.image = UIImage(named: listOfImages[index])

            // comments here for if we reversed
//            buttonGradient.removeFromSuperlayer()
//            nextButton.layer.borderWidth = 2
//            nextButton.layer.cornerRadius = 30
//            nextButton.layer.borderColor = UIColor.white.cgColor
//            nextButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
//            nextButton.setTitle("Next", for: .normal)
            if(index == 2){
                nextButton.layer.borderColor = UIColor.clear.cgColor
                nextButton.layer.borderWidth = 0
                nextButton.layer.insertSublayer(buttonGradient,at: 0)
                nextButton.setImage(UIImage(), for: [])
                nextButton.setTitle("Done", for: .normal)
            }
        }else{
            //Navigate to Home
            self.performSegue(withIdentifier: "goToHome", sender: self)

            // comments here for if we reversed
//            index = 0
//            nextButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
//            nextButton.setTitle("Next", for: .normal)
//            gradientLayer.colors = listOfColors[index]
//            bgView.image = UIImage(named: listOfImages[index])
//            buttonGradient.removeFromSuperlayer()
//            nextButton.layer.borderWidth = 2
//            nextButton.layer.cornerRadius = 30
//            nextButton.layer.borderColor = UIColor.white.cgColor
//            onBoardingLabel.text = listOfOnBoardingTexts[index]
        }
    }
}

