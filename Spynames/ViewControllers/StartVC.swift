//
//  ViewController.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 23/10/2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var newGameBtn: UIButton!
    @IBOutlet weak var joinGameBtn: UIButton!
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftSpyImg: UIImageView!
    @IBOutlet weak var rightSpyImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.makeAllButtonsRound(color: K.Colors.foreground, sound: K.Sounds.click)
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        titleLabel.textColor = K.Colors.foreground
        prepareNavigationBar()
        leftSpyImg.tintColor = K.Colors.blueDarker
        rightSpyImg.tintColor = K.Colors.redDarker
    }
    private func prepareNavigationBar() {
        self.navigationController?.makeInvisible()
        navigationController?.navigationBar.titleTextAttributes = [NSMutableAttributedString.Key.font: K.Fonts.navi!, NSMutableAttributedString.Key.foregroundColor :K.Colors.foreground]
        self.navigationController?.navigationBar.tintColor = K.Colors.foreground
    }
}

