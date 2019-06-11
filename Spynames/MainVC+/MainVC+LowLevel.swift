import AVFoundation
import UIKit

//MARK: - startUp functions
extension MainVC {
    var delayBetweenCardsAppear: Double {
        get {
            return 0.72/Double(game.ttlCardsQty)
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
        rightView.widthConstraint?.constant = K.SideView.Right.width
        leftView.widthConstraint?.constant = K.SideView.Left.width
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
//MARK: - Ongoing use functions
extension MainVC {
    func showLegend(fade: Bool, color: CardColor? = nil) {
        for uicard in uicards {
            if color == nil || (uicard.card.color == color!) {
                uicard.showColor(fade: fade)
            }
        }
        if color == nil || color == .red || color == .blue {
            wordsTVC.show()
            game.showLegend = true
        }
    }
    func hideLegend(fade: Bool, color: CardColor? = nil) {
        for uicard in uicards {
            if color == nil || (uicard.card.color == color!) {
                uicard.hideColor(fade: fade)
            }
        }
        if color == nil || color == .red || color == .blue  {
            wordsTVC.hide()
            game.showLegend = false
        }
    }
    func changeLegendVisibility(fade: Bool) {
        if game.showLegend {
            hideLegend(fade: fade)
        } else {
            showLegend(fade: fade)
        }
    }
    func sendToEnterHintVC(enterHintVC: EnterHintVC) {
        enterHintVC.delegate = self
        enterHintVC.hint = notConfirmedHint
        enterHintVC.maxQty = game.leftWordsQty[game.currentPlayer.team]
        enterHintVC.isTutorial = game.isTutorial
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
