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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.makeAllButtonsRound()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //navigationController?.isNavigationBarHidden = false
    }
    private func prepareNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.view.backgroundColor = UIColor.clear
        
        //navigationController?.navigationBar.barTintColor = K.Colors.foreground
        //navigationController?.navigationBar.tintColor = K.Colors.background
        navigationController?.navigationBar.titleTextAttributes = [NSMutableAttributedString.Key.font: K.Fonts.navi!, NSMutableAttributedString.Key.foregroundColor :K.Colors.foreground]
        //navigationController?.navigationBar.topItem?.title = K.Labels.Titles.chooseGameMode
    }
}

