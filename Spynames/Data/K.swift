import UIKit

struct K {
    static let useSmallerFonts = (UIScreen.main.currentMode!.size.width >= 750) ? false : true
    static let cornerRadius : CGFloat = 16
    
    struct Colors {
        static let foreground = UIColor(red: 0, green: 110/256, blue: 182/256, alpha: 1)
        static let foregroundLighter = UIColor(red: 0, green: 165/256, blue: 1, alpha: 1)
        static let foregroundDarker = UIColor(red: 0, green: 73/256, blue: 121/256, alpha: 1)
        static let background = UIColor.white
        static let gray = UIColor.gray
    }
    struct Labels {
        struct Buttons {
            static let startSingleGame = "Играем соло"
            }
        struct Titles {
            static let chooseGameMode = "Choose Game Mode"
            }
        }
    struct Fonts {
        static let navi = UIFont(name: "Google spies", size: 48)
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
