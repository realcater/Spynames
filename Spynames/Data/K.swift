import UIKit
import AVFoundation

enum LeftButtonState {
    case tutorial
    case hint
    case pass
    case newGame
}

struct K {
    static let idLength = 32
    
    static let redSpymaster = Player(team: .redTeam, type: .spymaster)
    static let blueSpymaster = Player(team: .blueTeam, type: .spymaster)
    static let redOperatives = Player(team: .redTeam, type: .operatives)
    static let blueOperatives = Player(team: .blueTeam, type: .operatives)
    
    static let spymasterIcon = UIImage(named: FileNames.playerTypeIcon[.spymaster]!)!
    static let operativesIcon = UIImage(named: FileNames.playerTypeIcon[.operatives]!)!
    
    static let useSmallerFonts = (UIScreen.main.currentMode!.size.width >= 750) ? false : true
    
    struct Game {
        static let sizeX = 5
        static let sizeY = 5
    }
    struct CardsAnimation {
        static let show = true
        static let turns = 1.0
        static let duration = 0.4
        static let delaySound = 0.4
        
    }
    
    struct Device {
        // deviceRoles[deviceQty][indexBtnPressed] -> [Player]
        static let roles: [Int: [Int: [Player]]] = [
            1: [
                0: [redSpymaster, blueSpymaster, redOperatives, blueOperatives]
            ],
            2: [
                0: [redSpymaster, blueSpymaster],
                1: [redOperatives, blueOperatives]
            ],
            3: [
                0: [redSpymaster],
                1: [blueSpymaster],
                2: [redOperatives, blueOperatives]
            ],
            4: [
                0: [redSpymaster],
                1: [blueSpymaster],
                2: [redOperatives],
                3: [blueOperatives]
            ]
        ]
        // deviceRoles[deviceQty][indexBtnPressed] -> UIImage
        static let icons: [Int: [Int: UIImage]] = [
            2: [
                0: spymasterIcon,
                1: operativesIcon
                ],
            3: [
                0: spymasterIcon,
                1: spymasterIcon,
                2: operativesIcon
                ],
            4: [
                0: spymasterIcon,
                1: spymasterIcon,
                2: operativesIcon,
                3: operativesIcon
                ]
        ]
        
    }
    struct ChooseMode {
        
        static let imagesName = [
            "1dev",
            "2dev",
            "3dev",
            "4dev"
        ]
        static let defaultDevicesQty = 1
    }
    struct ChooseRole {
        static let fromFirstBtnToTitle: [Int: CGFloat] = [
            2: 55,
            3: 40,
            4: 40
        ]
        static let btnHeight: [Int: CGFloat] = [
            2: 60,
            3: 50,
            4: 40
        ]
        static let verticalSpaceBetween1and2btns: [Int: CGFloat] = [
            2: 20,
            3: 10,
            4: 10
        ]
        static let btnColor: [Int: [UIColor?]] = [
            2: [nil, nil, nil, nil], //=nil if button is hidden or DoubleColor
            3: [Colors.redDarker, Colors.blueDarker, nil, nil],
            4: [Colors.redDarker, Colors.blueDarker, Colors.redDarker, Colors.blueDarker]
        ]
        
        static let btnImages = [
            2: [FileNames.playerTypeIcon[.spymaster], FileNames.playerTypeIcon[.operatives], nil, nil],
            3: [FileNames.playerTypeIcon[.spymaster], FileNames.playerTypeIcon[.spymaster],
                FileNames.playerTypeIcon[.operatives], nil],
            4: [FileNames.playerTypeIcon[.spymaster], FileNames.playerTypeIcon[.spymaster],
                FileNames.playerTypeIcon[.operatives], FileNames.playerTypeIcon[.operatives]]
        ]
    }
    
    struct SideView {
        struct Left {
            static let hiddenWidth: CGFloat = 30
            static let width: CGFloat = 200
            static let shiftWhenHidden: CGFloat = hiddenWidth-width
        }
        struct Right {
            static let hiddenWidth: CGFloat = 30
            static let width: CGFloat = 150
            static let shiftWhenHidden: CGFloat = hiddenWidth-width
        }
        static let animationLength = 0.5
    }
    struct Sizes {
        static let bigButtonCornerRadius : CGFloat = 32
        static let cardsCornerRadius : CGFloat = 12
        static let smallCornerRadius : CGFloat = 6
        struct Chat {
            static let vertSpace: CGFloat = 8
            static let border = CGSize(width: 20, height: 10)
            static let inset = CGSize(width: 21, height: 17)
            static let widthUsePerc: CGFloat = 0.66
            static let margin: CGFloat = 8
        }
        struct WordTable {
            static let cellHeight: CGFloat = 36
            static let labelHeight: CGFloat = 30
        }
        struct Cards {
            static let inset: CGFloat = 4
            static let startPoint = CGPoint(x: 0, y: -100)
            //in percentage of card size
            static let marginX = 0.4
            static let marginTop = 1.1
            static let marginBottom = 1.6
            static let distX = 0.1
            static let distY = 0.2
        }
    }
    struct Sounds {
        static let click = initSound(filename: "click.wav", volume: 0.1)
        static let cards = initSound(filename: "cards.wav", volume: 0.5)
        //static let message = initSound(filename: "stairs.mp3", volume: 0.5)
        //static let correct = initSound(filename: "true.wav", volume: 0.2)
        //static let error = initSound(filename: "false.wav", volume: 0.5)
        static let messageSoundID: SystemSoundID = 1016
    }
    struct Colors {
        static let blueLighter = UIColor(red: 0, green: 165/256, blue: 1, alpha: 1)
        static let blueNormal = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
        static let blueDarker = UIColor(red: 0, green: 73/256, blue: 121/256, alpha: 1)
        static let redDarker = UIColor(red: 148/256, green: 17/256, blue: 0, alpha: 1)
        static let redNormal = UIColor(red: 192/256, green: 23/256, blue: 0/256, alpha: 1)
        static let redLighter = UIColor(red: 222/256, green: 26/256, blue: 0/256, alpha: 1)
        
        static let green = UIColor(red: 0, green: 110/256, blue: 0, alpha: 1)
        static let greenDarker = UIColor(red: 0, green: 75/256, blue: 0, alpha: 1)
        static let gray = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        //static let brown = UIColor(red: 215/256, green: 180/256, blue: 135/256, alpha: 1)
        static let brown = UIColor(red: 235/256, green: 200/256, blue: 155/256, alpha: 1)
        static let brownLighter = UIColor(red: 250/256, green: 240/256, blue: 220/256, alpha: 1)
        static let brownDarker = UIColor(red: 148/256, green: 82/256, blue: 0, alpha: 1)
        static let clear = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        static let almostBlack = UIColor(red: 20/256, green: 20/256, blue: 20/256, alpha: 1)
        
        static let foreground = blueDarker
        static let buttonsText = UIColor.white
        
        static let team = [
            Team.redTeam: K.Colors.redDarker,
            Team.blueTeam: K.Colors.blueDarker
        ]
        static let teamChat = [
            Team.redTeam: K.Colors.redDarker,
            Team.blueTeam: K.Colors.blueDarker
        ]
        static let personalWordList = [
            CardColor.red: redDarker,
            CardColor.blue: blueDarker,
            CardColor.neutral: brownLighter,
            CardColor.black: almostBlack
        ]
        static let cardBackground = [
            CardColor.red: [false: redLighter, true: redDarker],
            CardColor.blue: [false: blueLighter, true: blueDarker],
            CardColor.neutral: [false: brownLighter, true: brown],
            CardColor.black: [false: almostBlack, true: almostBlack]
        ]
        static let cardText = [
            CardColor.red: UIColor.white,
            CardColor.blue: UIColor.white,
            CardColor.neutral: UIColor.darkGray,
            CardColor.black: UIColor.white
        ]
        static let imageColor = [
            CardColor.red: brownLighter,
            CardColor.blue: brownLighter,
            CardColor.neutral: almostBlack,
            CardColor.black: brownLighter
        ]
        static let shadowColor = [
            CardColor.red: redDarker,
            CardColor.blue: blueDarker,
            CardColor.neutral: almostBlack,
            CardColor.black: almostBlack,
            nil: almostBlack
        ]
        static let hintOrPassButton = greenDarker

        static let mainVCbuttons = greenDarker
        static let messageShadowOpacity: Float = 0.8
    }
    struct Labels {
        static let redText = "Red"
        static let blueText = "Blue"
        static let spymasterText = "Spymaster"
        static let operativesText = "Operatives"
        
        static let modeDescription = [
            "HOTSEAT - all players use the same device one by one",
            "Spymasters of both teams use one device and Operatives of both teams use another device",
            "Each Spymaster use their own device and Operatives of both teams use the third device",
            "Each Spymaster and Operatives of each team use their own device"
        ]
        struct nextTurnAlert {
            static let title = "Next turn"
            static let message = [
                PlayerType.spymaster: "Excellent hint! Please, pass the gadget to your Operatives.",
                PlayerType.operatives: "Your watch is over! Please, pass the gadget to the opposite Spymaster."]
            static let buttonText = "OK"
        }
        struct gameOverAlert {
            static let title = "XXX team wins!"
            static let message = [
                false: "Your party guessed all the words! Congratulations!",
                true: "Your party detonated a Bomb! Sorry..."
            ]
            static let buttonsText = ["New game", "Let me see"]
        }
        struct titleBar {
            static let waiting = [
                PlayerType.spymaster: "Waiting for your hint, Master!",
                PlayerType.operatives: "Please, choose your Cards! (up to XXX)"
            ]
        }
        struct Buttons {
            static let newGame = "New game"
            static let joinGame = "Join a game"
            static let howToPlay = "How to play"
            
            static let startGame = "Start a game!"
            static let left = [
                LeftButtonState.tutorial: "Skip",
                LeftButtonState.hint: "Give a hint",
                LeftButtonState.pass: "PASS",
                LeftButtonState.newGame: "New game"
                ]
            static let chooseMode = [
                2: ["  Spymasters", "  Operatives", nil, nil],
                3: ["Red Spymaster", "Blue Spymaster", "Operatives", nil],
                4: ["Red Spymaster", "Blue Spymaster", "Red Operatives", "Blue Operatives"]
            ]
            }
        struct Titles {
            static let spyNames = "Spy Names"
            static let chooseGameMode = "Choose game mode"
            static let chooseDeviceRole = "Choose device role"
            }
        }
    struct Fonts {
        struct Titles {
            static let startVC = UIFont(name: "Google spies", size: 72)
            static let defaultVC = UIFont(name: "Google spies", size: 48)
        }
        struct Buttons {
            static let startVC =  UIFont(name: "Top Secret Stamp", size: 32)
            static let chooseModeVC =  UIFont(name: "Top Secret Stamp", size: 32)
            static let chooseModeVCSmall =  UIFont(name: "Top Secret Stamp", size: 22)
            static let chooseRole =  UIFont(name: "Top Secret Stamp", size: 28)
            static let chooseRoleBigger =  UIFont(name: "Top Secret Stamp", size: 32)
        }
        static let chat = UIFont.systemFont(ofSize: 18)
        static let cardText = UIFont.systemFont(ofSize: 18)
    }
    struct Alpha {
        struct Background {
            static let main : CGFloat = 0.1
        }
    }
    struct FileNames {
        static let background = "wood_1624x750"
        static let mainBackground = "poker-background-1624x750px"
        static let joined = "joined-icon-80px"
        static let bubbleSent = "bubbleSent"
        static let bubbleReceived = "bubbleReceived"
        static let leftViewBackground = "paper_750x400px-left"
        static let rightViewBackground = "paper_750x400px-right"
        static let playerTypeIcon = [PlayerType.spymaster: "Crown1-80px", PlayerType.operatives: "Pawn2-80px"]
        static let titleBarImage = "paper_370x40px"
        static let cardBackgroundImage = [
            CardColor.red: "spy-badge-256px",
            CardColor.blue: "spy-badge-256px",
            CardColor.neutral: "peacemaker-256px",
            CardColor.black: "bomb-200px"
        ]
        static let leftNote = "paper_600x450px"
        static let rightNote = "paper_600x450px-2"
        static let deviceConnectStatus = [DeviceConnectStatus.you: "you-icon-80px",
                                        DeviceConnectStatus.joined: "joined-icon-80px",
                                        DeviceConnectStatus.waited: "wait-S80px"]
    }
    struct Delays {
        static let clockTurnAround = 4.0
        static let fadeTimeAppearCard = 1.5
        static let beforeFadeCardsColors = 1.0
        static let betweenWordsToTable = 0.2
        static let nextTurnAlert = 1.0
        static let titleBarText = 0.5
        static let showAllWords = 1.0
        static let playerStatusIconsBlink = 0.6
        static let moveOneRow = 0.5
    }
}
