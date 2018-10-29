//
//  ChooseGameVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 23/10/2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class ChooseModeVC: UIViewController {

    @IBOutlet weak var threeDevicesBtn: MyButton!
    @IBOutlet weak var fourDevicesBtn: MyButton!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.makeAllButtonsRound(cornerRadius: K.cornerRadius, color: K.Colors.foreground, sound: K.Sounds.click)
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        titleLabel.textColor = K.Colors.foreground
    }
}
