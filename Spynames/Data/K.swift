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
        static let background = UIColor.white
        static let gray = UIColor.gray
    }
    struct Labels {
        struct Buttons {
            static let startSingleGame = "Играем соло"
            }
        struct Titles {
            static let chooseGameMode = "Choose Game Mode"
            static let startGame = "Spy games!"
            }
        }
    struct Fonts {
        static let navi = UIFont(name: "Google spies", size: 64)
        struct Name {
            //static let systemRegular = UIFont.systemFont(ofSize: 20, weight: .regular).fontName
            //static let systemSemibold = UIFont.systemFont(ofSize: 20, weight: .semibold).fontName
        }
        struct Size {
            struct TextView {
                static let zoomed : CGFloat = 18
                static let normal : CGFloat = 21
            }
            static let naviBar: CGFloat = 20
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
