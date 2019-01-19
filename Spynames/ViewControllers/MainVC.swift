//
//  mainVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 27/11/2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftViewBackground: UIImageView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var rightViewBackground: UIImageView!
    @IBOutlet weak var chatView: ChatView!
    @IBOutlet weak var answerButton: MyButton!
    
    @IBOutlet weak var guessedScoreView: UIView!
    @IBOutlet weak var leftScoreView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var statusBar: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var redCrownImage: UIImageView!
    @IBOutlet weak var redOperativesImage: UIImageView!
    @IBOutlet weak var blueCrownImage: UIImageView!
    @IBOutlet weak var blueOperativesImage: UIImageView!
    
    @IBOutlet weak var redCrownBox: UIView!
    @IBOutlet weak var redOperativesBox: UIView!
    @IBOutlet weak var blueOperativesBox: UIView!
    @IBOutlet weak var blueCrownBox: UIView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.makeAllButtonsRound(cornerRadius: K.Sizes.cardsCornerRadius)
        view.setBackgroundImage(named: K.FileNames.mainBackground, alpha: 1)

        prepareChat()
        prepareViews()
        answerButton.makeRounded(sound: K.Sounds.click)
    }
    private func prepareViews() {
        guessedScoreView.makeDoubleColor(leftColor: K.Colors.blueDarker, rightColor: K.Colors.redDarker)
        guessedScoreView.makeRounded(cornerRadius: K.Sizes.smallCornerRadius)
        leftScoreView.makeDoubleColor(leftColor: K.Colors.blueDarker, rightColor: K.Colors.redDarker)
        leftScoreView.makeRounded(cornerRadius: K.Sizes.smallCornerRadius)
        leftViewBackground.image = UIImage(named: K.FileNames.leftViewBackground)
        rightViewBackground.image = UIImage(named: K.FileNames.rightViewBackground)
        
        redCrownBox.isHidden = false
        redOperativesBox.isHidden = true
        blueCrownBox.isHidden = true
        blueOperativesBox.isHidden = true
        
        //redCrownImage.tintColor = K.Colors.redDarker
        redOperativesImage.tintColor = K.Colors.redDarker
        blueCrownImage.tintColor = K.Colors.blueDarker
        blueOperativesImage.tintColor = K.Colors.gray

        statusView.makeAllSubviewsRound(cornerRadius: K.Sizes.smallCornerRadius)
    }
    private func prepareChat() {
        //rightView.setConstraint(identifier: "chatViewWidth", size: K.Sizes.Chat.width)
        view.layoutIfNeeded()
        let m1 = Message(text: "Hi! Red spymaster is here!", team: .red, player: .spymaster)
        let m2 = Message(text: "Hi! Blue spymaster is here!", team: .blue, player: .spymaster)
        let m3 = Message(text: "Hi! Red operatives are here!", team: .red, player: .operatives)
        let m4 = Message(text: "Hi! Blue operatives are here!", team: .blue, player: .operatives)
        chatView.add(m1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.chatView.add(m2)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.chatView.add(m3)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.chatView.add(m4)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.chatView.add(m1)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.chatView.add(m2)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: {
            self.chatView.add(m3)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0, execute: {
            self.chatView.add(m4)
        })
    }
    
}
