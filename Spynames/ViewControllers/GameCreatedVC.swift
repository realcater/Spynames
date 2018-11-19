//
//  GameCreatedVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 30/10/2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class GameCreatedVC: UIViewController {

    @IBOutlet weak var waitOrStartGameBtn: MyButton!
    
    @IBOutlet weak var redSpymasterLabel: UILabel!
    @IBOutlet weak var blueSpymasterLabel: UILabel!
    @IBOutlet weak var redOperativesLabel: UILabel!
    @IBOutlet weak var blueOperativesLabel: UILabel!
    @IBOutlet weak var redSpymasterImage: UIImageView!
    @IBOutlet weak var blueSpymasterImage: UIImageView!
    @IBOutlet weak var redOperativesImage: UIImageView!
    @IBOutlet weak var blueOperativesImage: UIImageView!
    @IBOutlet weak var redSpymasterStatusImage: UIImageView!
    @IBOutlet weak var blueSpymasterStatusImage: UIImageView!
    @IBOutlet weak var blueOperativesStatusImage: UIImageView!
    @IBOutlet weak var redOperativesStatusImage: UIImageView!
    @IBAction func waitOrStartGameBtnPressed(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.blueSpymasterStatusImage.stopRotating()
            self.blueSpymasterStatusImage.image = UIImage(named: K.FileNames.joined)
            
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.redOperativesStatusImage.stopRotating()
            self.redOperativesStatusImage.image = UIImage(named: K.FileNames.joined)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.blueOperativesStatusImage.stopRotating()
            self.blueOperativesStatusImage.image = UIImage(named: K.FileNames.joined)
        })
        waitOrStartGameBtn.setTitle(K.Labels.Buttons.startGame, for: .normal)
        waitOrStartGameBtn.backgroundColor = K.Colors.foreground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        waitOrStartGameBtn.makeRounded()
        setUpLabels()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    private func setUpLabels() {
        //view.setForAllImages(tintColor: K.Colors.icons)
        redSpymasterLabel.backgroundColor = .clear
        blueSpymasterLabel.backgroundColor = .clear
        redOperativesLabel.backgroundColor = .clear
        blueOperativesLabel.backgroundColor = .clear
        
        redSpymasterLabel.textColor = K.Colors.redDarker
        blueSpymasterLabel.textColor = K.Colors.blueDarker
        redOperativesLabel.textColor = K.Colors.redDarker
        blueOperativesLabel.textColor = K.Colors.blueDarker
        
        redSpymasterImage.tintColor = K.Colors.redDarker
        blueSpymasterImage.tintColor = K.Colors.blueDarker
        redOperativesImage.tintColor = K.Colors.redDarker
        blueOperativesImage.tintColor = K.Colors.blueDarker
        
        redSpymasterStatusImage.tintColor = K.Colors.redDarker
        blueSpymasterStatusImage.tintColor = K.Colors.blueDarker
        blueOperativesStatusImage.tintColor = K.Colors.blueDarker
        redOperativesStatusImage.tintColor = K.Colors.redDarker
        
        blueSpymasterStatusImage.rotate(duration: 6)
        redOperativesStatusImage.rotate(duration: 6)
        blueOperativesStatusImage.rotate(duration: 6)
    }
}
