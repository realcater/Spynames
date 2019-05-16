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
    @IBOutlet weak var hintOrPassButton: UIRoundedButton!
    @IBOutlet weak var guessedScoreView: UIView!
    @IBOutlet weak var leftScoreView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleBar: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet var statusIconBars: [UIView]!
    @IBOutlet var statusIconImages: [UIImageView]!
    @IBOutlet weak var bottomViewImage: UIImageView!
    @IBOutlet weak var topViewImage: UIImageView!
    @IBOutlet weak var mainView: UIScrollView!
    @IBOutlet weak var guessedBlueLabel: UILabel!
    @IBOutlet weak var guessedRedLabel: UILabel!
    @IBOutlet weak var leftBlueLabel: UILabel!
    @IBOutlet weak var leftRedLabel: UILabel!
    
    var statusIcons: [Player: PlayerStatusIcon]!
    var game: Game!
    var notConfirmedHint = Hint()
    var uicards = [UICard]()
    var wordsTVC: WordsTVC!
    var rightViewShown = true
    var leftViewShown = true
}
//MARK: - override functions
extension MainVC {
    override func loadView() {
        super.loadView()
        game = Game()
        game.delegate = self
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
            wordsTVC.delegate = game
            DispatchQueue.main.asyncAfter(deadline: .now() + K.Delays.beforeFadeCardsColors, execute: {
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
                uicard.delegate = self
                uicards.append(uicard)
            }
        }
    }
    func prepareViews() {
        guessedScoreView.makeDoubleColor(leftColor: K.Colors.team[.blueTeam]!, rightColor: K.Colors.team[.redTeam]!)
        guessedScoreView.makeRounded(cornerRadius: K.Sizes.smallCornerRadius)
        leftScoreView.makeDoubleColor(leftColor: K.Colors.team[.blueTeam]!, rightColor: K.Colors.team[.redTeam]!)
        leftScoreView.makeRounded(cornerRadius: K.Sizes.smallCornerRadius)
        leftViewBackground.image = UIImage(named: K.FileNames.leftViewBackground)
        rightViewBackground.image = UIImage(named: K.FileNames.rightViewBackground)
        topViewImage.image = UIImage(named: K.FileNames.titleBarImage)
        topViewImage.addShadow()
        bottomViewImage.addShadow()
        leftViewBackground.addShadow()
        rightView.widthConstraint?.constant = K.SideView.width
        leftView.widthConstraint?.constant = K.SideView.width
        updateScoreLabels()
        updateLeftWordsQtyLabels()
        
    }
    func preparePlayerStatusBar() {
        statusView.makeAllSubviewsRound(cornerRadius: K.Sizes.smallCornerRadius)
        
        statusIcons = [
            Player(team: .redTeam, type: .spymaster):
                PlayerStatusIcon(playerType: .spymaster, team: .redTeam, bar: statusIconBars[0], image: statusIconImages[0]),

            Player(team: .redTeam, type: .operatives):
                PlayerStatusIcon(playerType: .operatives, team: .redTeam, bar: statusIconBars[1], image: statusIconImages[1]),
        
            Player(team: .blueTeam, type: .spymaster):
                PlayerStatusIcon(playerType: .spymaster, team: .blueTeam, bar: statusIconBars[2], image: statusIconImages[2]),
        
            Player(team: .blueTeam, type: .operatives):
                PlayerStatusIcon(playerType: .operatives, team: .blueTeam, bar: statusIconBars[3], image: statusIconImages[3])
        ]
        updateStatusIcons()
        
        
    }
    func prepareChat() {
        hintOrPassButton.makeRounded(color: K.Colors.hintOrPassButton[game.currentPlayer.type])
        chatView.setup()
        view.layoutIfNeeded()
        let m1 = Message(text: "Hi! Red spymaster is here!", team: .redTeam, player: .spymaster)
        let m2 = Message(text: "Hi! Blue spymaster is here!", team: .blueTeam, player: .spymaster)
        let m3 = Message(text: "Hi! Red operatives are here!", team: .redTeam, player: .operatives)
        let m4 = Message(text: "Hi! Blue operatives are here!", team: .blueTeam, player: .operatives)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.chatView.add(m1)
            self.statusIcons[Player(team: .redTeam, type: .spymaster)]!.online = true
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5, execute: {
            self.chatView.add(m2)
            self.statusIcons[Player(team: .blueTeam, type: .spymaster)]!.online = true
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.chatView.add(m3)
            self.statusIcons[Player(team: .redTeam, type: .operatives)]!.online = true
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5, execute: {
            self.chatView.add(m4)
            self.statusIcons[Player(team: .blueTeam, type: .operatives)]!.online = true
            self.statusIcons[Player(team: self.game.currentPlayer.team,
                                    type: self.game.currentPlayer.type)]!.active = true
            self.updateTitleBar()
        })
    }
    func revealCardsColors() {
        changeCardsColorVisibility(fade: true)
        updateTableFromPersonalList(withDelay: true)
    }
}
//MARK: - Ongoing use private functions
private extension MainVC {
    @IBAction func pressHintOrPassButton(_ sender: Any) {
        switch game.currentPlayer.type {
            case .spymaster: performSegue(withIdentifier: "toEnterHintVC", sender: sender)
            case .operatives: nextTurn(withPause: false)
        }
    }
    func sendToEnterHintVC(enterHintVC: EnterHintVC) {
        enterHintVC.delegate = self
        enterHintVC.hint = notConfirmedHint
        enterHintVC.maxQty = game.leftWordsQty[game.currentPlayer.team]
    }
    func updateStatusIcons() {
        for team in Team.allCases {
            for playerType in PlayerType.allCases {
                if (game.currentPlayer.team == team) && (game.currentPlayer.type == playerType) {
                    statusIcons[Player(team: team, type: playerType)]!.active = true
                } else {
                    statusIcons[Player(team: team, type: playerType)]!.active = false
                }
            }
        }
    }
    func updateTableFromPersonalList(withDelay: Bool) {
        wordsTVC.deleteAll()
        let personalList = game.personalList[game.currentPlayer.team]!
        for (i, card) in personalList.enumerated() {
            let delay = withDelay ? Double(i)*K.Delays.betweenWordsToTable+K.Delays.beforeFirstWordToTable : 0
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                self.wordsTVC.insertRow(card: card, at: i)
            })
        }
    }
    
    func updatePersonalListFromTable() {
        game.personalList[game.currentPlayer.team] = wordsTVC.cards
    }
    func setupHintOrPassButton() {
        hintOrPassButton.setTitle(
            K.Labels.Buttons.hintOrPassButton[self.game.currentPlayer.type], for: .normal)
        //hintOrPassButton.backgroundColor = K.Colors.hintOrPassButton[game.currentPlayer.type]
    }
    
}
//MARK: - Ongoing use public functions
extension MainVC {
    func nextTurn(withPause: Bool = true) {
        let delay = withPause ? K.Delays.nextTurnAlert : 0
        if game.currentPlayer.type == .spymaster {
            changeCardsColorVisibility(fade: true, alwaysHide: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            self.addAlertDialog(title: K.Labels.nextTurnAlert.title, message:
                K.Labels.nextTurnAlert.message[self.game.currentPlayer.type]!,
                                buttonText: K.Labels.nextTurnAlert.buttonText, pressedButtonAction: {
                                    if self.game.currentPlayer.type == .spymaster {
                                        self.updatePersonalListFromTable()
                                    } else {
                                        self.changeCardsColorVisibility(fade: true)
                                    }
                                    self.game.nextTurn()
                                    self.updateStatusIcons()
                                    self.updateTitleBar()
                                    self.setupHintOrPassButton()
                                    
                                    if self.game.currentPlayer.type == .spymaster {
                                        self.updateTableFromPersonalList(withDelay: false)
                                    }
            })
        })
    }
    func updateTitleBar() {
        var title = K.Labels.titleBar.waiting[game.currentPlayer.type]!
        if game.currentPlayer.type == .operatives {
            title = title.replacingOccurrences(of: "XXX", with: Helper.StrInf(game.leftToGuessThisTurn))
        }
        UIView.transition(with: self.titleBar, duration: K.Delays.titleBarText,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.titleBar.text = title
        }, completion: nil)
    }
}
//MARK: - UIScrollViewDelegate
extension MainVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomedView
    }
}
