import UIKit
import AVFoundation

struct K {
    struct Game {
        static let sizeX = 5
        static let sizeY = 5
        static let ttlCardsQty = 25
        static let cardsQty = [
            CardColor.red: [Team.red: 9, Team.blue: 8],
            CardColor.blue: [Team.red: 8, Team.blue: 9],
            CardColor.neutral: [Team.red: 7, Team.blue: 7],
            CardColor.black: [Team.red: 1, Team.blue: 1]
        ]
    }
    
    static let allDeviceRoles = [DeviceRoles.redSpymaster,
                                 DeviceRoles.blueSpymaster,
                                 DeviceRoles.redOperatives,
                                 DeviceRoles.blueOperatives
    ]
    static let imageForDeviceConnectStatus = [DeviceConnectStatus.you: "you-icon-80px",
                                                  DeviceConnectStatus.joined: "joined-icon-80px",
                                                  DeviceConnectStatus.waited: "wait-S80px"]
    
    static let useSmallerFonts = (UIScreen.main.currentMode!.size.width >= 750) ? false : true
    
    
    struct Sizes {
        static let bigButtonCornerRadius : CGFloat = 32
        static let cardsCornerRadius : CGFloat = 12
        static let smallCornerRadius : CGFloat = 6
        struct Chat {
            //static let width: CGFloat = 170
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
    }
    struct Sounds {
        static let click = initSound(filename: "click.wav", volume: 0.2)
        //static let correct = initSound(filename: "true.wav", volume: 0.2)
        //static let error = initSound(filename: "false.wav", volume: 0.5)
        static let messageSoundID: SystemSoundID = 1016
    }
    struct Colors {
        static let blueLighter = UIColor(red: 0, green: 165/256, blue: 1, alpha: 1)
        static let blueNormal = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
        static let blueDarker = UIColor(red: 0, green: 73/256, blue: 121/256, alpha: 1)
        static let redDarker = UIColor(red: 148/256, green: 17/256, blue: 0, alpha: 1)
        static let green = UIColor(red: 0, green: 110/256, blue: 0, alpha: 1)
        static let greenDarker = UIColor(red: 0, green: 75/256, blue: 0, alpha: 1)
        static let gray = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        static let Brown = UIColor(red: 190/256, green: 180/256, blue: 150/256, alpha: 1)
        static let lightBrown = UIColor(red: 250/256, green: 240/256, blue: 220/256, alpha: 1)
        static let clear = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        
        static let foreground = blueDarker
        static let buttonsText = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        static let forRole = [DeviceRoles.redSpymaster: redDarker,
                                  DeviceRoles.blueSpymaster: blueDarker,
                                  DeviceRoles.redOperatives: redDarker,
                                  DeviceRoles.blueOperatives: blueDarker
                                  ]
        static let team = [Team.red: K.Colors.redDarker, Team.blue: K.Colors.blueDarker]
        static let teamChat = [Team.red: K.Colors.redDarker, Team.blue: K.Colors.blueNormal]
        static let word = [
            CardColor.red: K.Colors.redDarker,
            CardColor.blue: K.Colors.blueDarker,
            CardColor.neutral: K.Colors.lightBrown,
            CardColor.black: UIColor.black
        ]
        static let mainVCbuttons = greenDarker
    }
    struct Labels {
        struct Buttons {
            static let newGame = "New game"
            static let joinGame = "Join a game"
            static let howToPlay = "How to play"
            static let threeDevices = "3 Devices"
            static let fourDevices = "4 Devices"
            static let redSpymaster = "Red Spymaster"
            static let blueSpymaster = "Blue Spymaster"
            static let redOperatives = "Red Operatives"
            static let blueOperatives = "Blue Operatives"
            static let operatives = "Operatives"
            static let startGame = "Start a game!"
            
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
            static let chooseRole =  UIFont(name: "Top Secret Stamp", size: 28)
        }
        static let chat = UIFont.systemFont(ofSize: 18)
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
        static let icon = [PlayerType.spymaster: "Crown1-80px", PlayerType.operatives: "Pawn2-80px"]
        
    }
    struct Durations {
        static let clockTurnAround = 4.0
    }
}
