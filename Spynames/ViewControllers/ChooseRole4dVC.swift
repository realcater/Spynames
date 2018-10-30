import UIKit

class ChooseRole4dVC: UIViewController {

    @IBOutlet weak var redSpymasterBtn: MyButton!
    @IBOutlet weak var blueSpymasterBtn: MyButton!
    @IBOutlet weak var redOperBtn: MyButton!
    @IBOutlet weak var blueOperBtn: MyButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareBtns()
        prepareTitle()
    }
    private func prepareBtns() {
        redSpymasterBtn.makeRounded(color: K.Colors.redDarker, font: K.Fonts.Buttons.chooseRole, sound: K.Sounds.click)
        redOperBtn.makeRounded(color: K.Colors.redDarker, font: K.Fonts.Buttons.chooseRole, sound: K.Sounds.click)
        blueSpymasterBtn.makeRounded(color: K.Colors.blueDarker, font: K.Fonts.Buttons.chooseRole, sound: K.Sounds.click)
        blueOperBtn.makeRounded(color: K.Colors.blueDarker, font: K.Fonts.Buttons.chooseRole, sound: K.Sounds.click)
    }
    private func prepareTitle() {
        titleLabel.textColor = K.Colors.foreground
        titleLabel.font = K.Fonts.Titles.defaultVC
    }
}
