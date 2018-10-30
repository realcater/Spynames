//
//  ChooseRoleVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 24/10/2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class ChooseRole3dVC: UIViewController {
    
    @IBOutlet weak var redSpymasterBtn: MyButton!
    @IBOutlet weak var blueSpymasterBtn: MyButton!
    @IBOutlet weak var operBtn: MyButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        titleLabel.textColor = K.Colors.foreground
        initBtns()
    }
    private func initBtns() {
        redSpymasterBtn.makeRounded(color: K.Colors.redDarker, sound: K.Sounds.click)
        blueSpymasterBtn.makeRounded(color: K.Colors.blueDarker, sound: K.Sounds.click)
        operBtn.makeRounded(sound: K.Sounds.click)
        operBtn.makeDoubleColor(topColor: K.Colors.redDarker, bottomColor: K.Colors.blueDarker)
    }
}
