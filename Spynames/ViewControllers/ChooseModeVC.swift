import UIKit

class ChooseModeVC: UIViewController {

    @IBOutlet weak var threeDevicesBtn: MyButton!
    @IBOutlet weak var fourDevicesBtn: MyButton!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareButtons()
        prepareTitle()
    }
    private func prepareButtons() {
        threeDevicesBtn.setTitle(K.Labels.Buttons.threeDevices, for: .normal)
        fourDevicesBtn.setTitle(K.Labels.Buttons.fourDevices, for: .normal)
        view.makeAllButtonsRound(cornerRadius: K.cornerRadius, color: K.Colors.foreground,  font: K.Fonts.Buttons.chooseModeVC, sound: K.Sounds.click)
    }
    private func prepareTitle() {
        titleLabel.textColor = K.Colors.foreground
        titleLabel.font = K.Fonts.Titles.defaultVC
        titleLabel.text = K.Labels.Titles.chooseGameMode
    }
}
