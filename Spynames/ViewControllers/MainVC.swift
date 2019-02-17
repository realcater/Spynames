//
//  mainVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 27/11/2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//
import AVFoundation
import UIKit
//MARK: - state
class MainVC: UIViewController {
    @IBOutlet weak var zoomedView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftViewBackground: UIImageView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var rightViewBackground: UIImageView!
    @IBOutlet weak var chatView: PlayersChatView!
    @IBOutlet weak var giveahintButton: UIRoundedButton!
    @IBOutlet weak var guessedScoreView: UIView!
    @IBOutlet weak var leftScoreView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var statusBar: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet var statusIconBars: [UIView]!
    @IBOutlet var statusIconImages: [UIImageView]!
    @IBOutlet weak var bottomViewImage: UIImageView!
    @IBOutlet weak var topViewImage: UIImageView!
    @IBOutlet weak var mainView: UIScrollView!

    var statusIcons : [PlayerStatusIcon] = []
    var game: Game!
    var notConfirmedHint = Hint()
    var uicards = [UICard]()
    var wordsTVC: WordsTVC!
    var rightViewShown = true
    var leftViewShown = true
}
//MARK: - public functions
extension MainVC {
    override func loadView() {
        super.loadView()
        game = Game()
        placeCards()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.minimumZoomScale = 1.0
        mainView.maximumZoomScale = 2.0
        mainView.delegate = self
        view.setBackgroundImage(named: K.FileNames.mainBackground, alpha: 1)
        prepareViews()
        preparePlayerStatusBar()
        prepareChat()
        addTapsForLeftView()
        addTapsForRightView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wordsTVCSegue" {
            wordsTVC = segue.destination as? WordsTVC
            DispatchQueue.main.asyncAfter(deadline: .now() + K.Durations.beforeFadeCardsColors, execute: {
                self.revealCardsColors()
            })
        } else if segue.identifier == "toEnterHintVC" {
            let enterHintVC = segue.destination as! EnterHintVC
            sendToEnterHintVC(enterHintVC: enterHintVC)
        }
    }
}

//MARK: - startUp private functions
private extension MainVC {
    func placeCards() {
        if K.CardsAnimation.show {
            DispatchQueue.main.asyncAfter(deadline: .now() + K.CardsAnimation.delaySound, execute: {
                K.Sounds.cards?.play()
            })
        }
        for y in 0..<K.Game.sizeY {
            for x in 0..<K.Game.sizeX {
                let num = y*K.Game.sizeX+x
                let place = Place(x: x, y: y)
                let delay = K.CardsAnimation.show ? K.CardsAnimation.betweenCardsAppear * Double(num) : 0
                let uicard = UICard(place: place, card: game.cards[num], showDelay: delay, in: zoomedView)
                uicard.mainVCDelegate = self
                uicards.append(uicard)
            }
        }
    }
    func prepareViews() {
        guessedScoreView.makeDoubleColor(leftColor: K.Colors.team[.blue]!, rightColor: K.Colors.team[.red]!)
        guessedScoreView.makeRounded(cornerRadius: K.Sizes.smallCornerRadius)
        leftScoreView.makeDoubleColor(leftColor: K.Colors.team[.blue]!, rightColor: K.Colors.team[.red]!)
        leftScoreView.makeRounded(cornerRadius: K.Sizes.smallCornerRadius)
        leftViewBackground.image = UIImage(named: K.FileNames.leftViewBackground)
        rightViewBackground.image = UIImage(named: K.FileNames.rightViewBackground)
        topViewImage.addShadow()
        bottomViewImage.addShadow()
        leftViewBackground.addShadow()
        rightView.widthConstraint?.constant = K.SideView.width
        leftView.widthConstraint?.constant = K.SideView.width
    }
    func preparePlayerStatusBar() {
        statusView.makeAllSubviewsRound(cornerRadius: K.Sizes.smallCornerRadius)
        
        statusIcons.append(
            PlayerStatusIcon(playerType: .spymaster, team: .red, bar: statusIconBars[0], image: statusIconImages[0])
        )
        statusIcons.append(
            PlayerStatusIcon(playerType: .operatives, team: .red, bar: statusIconBars[1], image: statusIconImages[1])
        )
        statusIcons.append(
            PlayerStatusIcon(playerType: .spymaster, team: .blue, bar: statusIconBars[2], image: statusIconImages[2])
        )
        statusIcons.append(
            PlayerStatusIcon(playerType: .operatives, team: .blue, bar: statusIconBars[3], image: statusIconImages[3])
        )
        statusIcons[0].active = true
    }
    func prepareChat() {
        giveahintButton.makeRounded(color: K.Colors.mainVCbuttons)
        chatView.setup()
        view.layoutIfNeeded()
        let m1 = Message(text: "Hi! Red spymaster is here!", team: .red, player: .spymaster)
        let m2 = Message(text: "Hi! Blue spymaster is here!", team: .blue, player: .spymaster)
        let m3 = Message(text: "Hi! Red operatives are here!", team: .red, player: .operatives)
        let m4 = Message(text: "Hi! Blue operatives are here!", team: .blue, player: .operatives)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.chatView.add(m1)
            self.statusIcons[0].online = true
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.chatView.add(m2)
            self.statusIcons[2].online = true
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.chatView.add(m3)
            self.statusIcons[1].online = true
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: {
            self.chatView.add(m4)
            self.statusIcons[3].online = true
        })
    }
    func revealCardsColors() {
        changeCardsColorVisibility(fade: true)
        for (i, card) in (game.cardsOfCurrentTeam+game.cardsOf[CardColor.black]!).enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)*K.Durations.betweenWordsToTable+K.Durations.beforeFirstWordToTable, execute: {
                self.wordsTVC.insertRow(card: card, at: i)
            })
        }
    }
}
//MARK: - Ongoing use private functions
private extension MainVC {
    func sendToEnterHintVC(enterHintVC: EnterHintVC) {
        enterHintVC.delegate = self
        enterHintVC.hint = notConfirmedHint
        enterHintVC.maxQty = game.leftWords[game.currentTeam]
    }
}
//MARK: - delegates
extension MainVC: ReturnHintDelegate {
    func addHint(hint: Hint) {
        game.hints[game.currentTeam]!.append(hint)
        let message = Message(text: hint.text+": "+Helper.StrInf(hint.qty), team: game.currentTeam, player: .spymaster)
        chatView.add(message)
    }
}

extension MainVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomedView
    }
}

extension MainVC: MainVCDelegate {
    func changeCardsColorVisibility(fade: Bool) {
        for uicard in uicards {
            uicard.changeShowColor(fade: fade)
        }
        wordsTVC.changeVisibility()
    }
}
