import UIKit

struct K {
    static let useSmallerFonts = (UIScreen.main.currentMode!.size.width >= 750) ? false : true
    static let cornerRadius : CGFloat = 32
    
    struct Sounds {
        static let click = initSound(filename: "click.wav", volume: 0.2)
        //static let correct = initSound(filename: "true.wav", volume: 0.2)
        //static let error = initSound(filename: "false.wav", volume: 0.5)
    }
    struct Colors {
        static let blueLighter = UIColor(red: 0, green: 165/256, blue: 1, alpha: 1)
        static let blueNormal = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
        static let blueDarker = UIColor(red: 0, green: 73/256, blue: 121/256, alpha: 1)
        static let redDarker = UIColor(red: 148/256, green: 17/256, blue: 0, alpha: 1)
        
        static let foreground = blueDarker
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
    }
    struct Alpha {
        struct Background {
            static let main : CGFloat = 0.1
        }
    }
    struct FileNames {
        static let background = "textBackground"
    }
}
