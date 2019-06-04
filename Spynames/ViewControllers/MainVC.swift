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
    @IBOutlet weak var leftButton: UIRoundedButton!
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
    var tutorial: Tutorial!
    var notConfirmedHint = Hint()
    var uicards = [UICard]()
    var wordsTVC: WordsTVC!
    var rightViewShown = true
    var leftViewShown = true
    var leftButtonState: LeftButtonState = .hint {
        didSet {
            leftButton.setTitle(
                K.Labels.Buttons.left[leftButtonState], for: .normal)
        }
    }
    
    
}
//MARK: - override functions
extension MainVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
        
        view.setBackgroundImage(named: K.FileNames.mainBackground, alpha: 1)
        prepareViews()
        preparePlayerStatusBar()
        prepareChat()
        addTapsForLeftView()
        addTapsForRightView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //startTutorial()
        tutorial = Tutorial(VCDelegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wordsTVCSegue" {
            wordsTVC = segue.destination as? WordsTVC
        } else if segue.identifier == "toEnterHintVC" {
            let enterHintVC = segue.destination as! EnterHintVC
            sendToEnterHintVC(enterHintVC: enterHintVC)
        }
    }
}

//MARK: - startUp private functions
private extension MainVC {
    
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
        
    }
    func prepareChat() {
        leftButton.makeRounded(color: K.Colors.hintOrPassButton)
        chatView.setup()
        view.layoutIfNeeded()
        
    }
}
//MARK: - Ongoing use public functions
extension MainVC {
    
    func startNewGame() {
        game = Game()
        game.delegate = self
        
        updateScoreLabels()
        updateLeftWordsQtyLabels()
        updateStatusIcons()
        updateTitleBar()
        updateLeftButton()
        updateAndRevealWords()
        updateChat()
        placeCards()
    }
    
    func nextTurn(withPause: Bool = true) {
        var alert: UIAlertController!
        let delay = withPause ? K.Delays.nextTurnAlert : 0
        if game.currentPlayer.type == .spymaster {
            hideLegend(fade: true)
        }
        let alertButton = AlertButton(
            text: K.Labels.nextTurnAlert.buttonText,
            action: {
                if self.game.currentPlayer.type == .spymaster {
                    self.updatePersonalListFromTable()
                } else {
                    self.changeLegendVisibility(fade: true)                                     }
                self.game.nextTurn()
                self.updateStatusIcons()
                self.updateTitleBar()
                self.updateLeftButton()
                
                if self.game.currentPlayer.type == .spymaster {
                    self.updateTableFromPersonalList(withDelay: false)
                }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            alert = self.addAlertDialog(title: K.Labels.nextTurnAlert.title, message:
                K.Labels.nextTurnAlert.message[self.game.currentPlayer.type]!, alertButtons: [alertButton])
        })
        if game.isTutorial {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay+T.Delay.skipAlert, execute: {
                alert.dismiss(animated: true, completion: alertButton.action)
            })
        }
    }

    func placeCards() {
        zoomedView.clearSubviews()
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
    func revealCardsColors(color: CardColor? = nil) {
        showLegend(fade: true, color: color)
        switch color {
        case .red?: updateTableFromPersonalList(withDelay: true, team: .redTeam)
        case .blue?: updateTableFromPersonalList(withDelay: true, team: .blueTeam)
        case nil: updateTableFromPersonalList(withDelay: true, team: game.currentPlayer.team)
        default: break
        }
    }
    func LookAround() {
        if game.isTutorial { return }
        leftButtonState = .newGame
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
    func showSkipTutorialAlert() {
        tutorial.pause()
        let title = "Skip tutorial"
        let message = "Do you really want to skip the tutorial and start a new game?"
        let alertButtons = [
            AlertButton(text: "Skip", action: self.startNewGame),
            AlertButton(text: "Continue", action: tutorial.startContinue)
        ]
        _ = self.addAlertDialog(title: title, message: message, alertButtons: alertButtons)
    }
}
//MARK: - Ongoing use private functions
private extension MainVC {
    @IBAction func pressLeftButton(_ sender: Any) {
        switch leftButtonState {
            case .tutorial: showSkipTutorialAlert()
            case .hint: performSegue(withIdentifier: "toEnterHintVC", sender: sender)
            case .pass: nextTurn(withPause: false)
            case .newGame: startNewGame()
        }
    }
    func sendToEnterHintVC(enterHintVC: EnterHintVC) {
        enterHintVC.delegate = self
        enterHintVC.hint = notConfirmedHint
        enterHintVC.maxQty = game.leftWordsQty[game.currentPlayer.team]
        enterHintVC.isTutorial = game.isTutorial
    }
    func updateStatusIcons() {
        for team in Team.allCases {
            for playerType in PlayerType.allCases {
                statusIcons[Player(team: team, type: playerType)]!.online = true
                statusIcons[Player(team: team, type: playerType)]!.blink = false
                if (game.currentPlayer.team == team) && (game.currentPlayer.type == playerType) {
                    statusIcons[Player(team: team, type: playerType)]!.active = true
                } else {
                    statusIcons[Player(team: team, type: playerType)]!.active = false
                }
            }
        }
    }
    func updateTableFromPersonalList(withDelay: Bool, team: Team? = nil) {
        wordsTVC.deleteAll()
        let personalList = (team == nil) ? self.game.personalList[game.currentPlayer.team]! : self.game.personalList[team!]!
        var i=0
        let delay = withDelay ? K.Delays.betweenWordsToTable : 0
        Timer.scheduledTimer(withTimeInterval: delay, repeats: true) { timer in
            self.wordsTVC.insertRow(card: personalList[i], at: i)
            i+=1
            if i==personalList.count { timer.invalidate() }
        }
    }
    
    func updatePersonalListFromTable() {
        game.personalList[game.currentPlayer.team] = wordsTVC.cards
    }
    func updateLeftButton() {
        if game.isTutorial { return }
        leftButtonState = (game.currentPlayer.type == .spymaster) ? .hint : .pass
    }
    func updateAndRevealWords() {
        wordsTVC.delegate = game
        DispatchQueue.main.asyncAfter(deadline: .now() + K.Delays.beforeFadeCardsColors, execute: {
            self.revealCardsColors()
        })
    }
    func updateChat() {
        chatView.clear()
    }
}

//MARK: - UIScrollViewDelegate
extension MainVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomedView
    }
}
