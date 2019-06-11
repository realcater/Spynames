import UIKit

class ChooseRoleVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet var buttons: [UIRoundedButton]!
    
    @IBAction func btnIsPressed(_ sender: Any) {
        performSegue(withIdentifier: "toGameCreatedVC", sender: sender)
    }
    var devicesQty: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareTitle()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBtns()
    }
    private func prepareBtns() {
        view.setConstraint(identifier: "fromFirstBtnToTitle",
                           size: K.ChooseRole.fromFirstBtnToTitle[devicesQty]!)
        view.setConstraint(identifier: "verticalSpaceBetween1and2btns",
                           size: K.ChooseRole.verticalSpaceBetween1and2btns[devicesQty]!)
        buttons[0].setConstraint(identifier: "btnHeight",
                                 size: K.ChooseRole.btnHeight[devicesQty]!)
        view.layoutIfNeeded()
        
        for (i,button) in buttons.enumerated() {
            button.isHidden = (K.Labels.Buttons.chooseMode[devicesQty!]![i] == nil)
            if button.isHidden { continue }

            button.setTitle(K.Labels.Buttons.chooseMode[devicesQty!]![i], for: .normal)
            button.makeRounded(color: K.ChooseRole.btnColor[devicesQty!]![i],
                               textColor: K.Colors.buttonsText,
                               tintColor: K.Colors.buttonsText,
                               font: K.Fonts.Buttons.chooseRole,
                               sound: K.Sounds.click)
            let image = UIImage(named: K.ChooseRole.btnImages[devicesQty!]![i]!)
            button.setImage(image, for: .normal)
            if K.ChooseRole.btnColor[devicesQty!]![i] == nil {
                button.makeDoubleColor(topColor: K.Colors.redDarker, bottomColor: K.Colors.blueDarker)
            }
        }
    }
    private func prepareTitle() {
        titleLabel.textColor = K.Colors.foreground
        titleLabel.font = K.Fonts.Titles.defaultVC
        titleLabel.text = K.Labels.Titles.chooseDeviceRole
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameCreatedVC" {
            let gameCreatedVC = segue.destination as? GameCreatedVC
            gameCreatedVC!.devicesQty = devicesQty
            let btnPressed = sender as! UIRoundedButton
            if let btnIndex = buttons.firstIndex(of: btnPressed) {
                gameCreatedVC!.thisDeviceRole = K.Device.roles[devicesQty]![btnIndex]
            }
        } else if segue.identifier == "backToGameChooseModeVC" {
            let chooseModeVC = segue.destination as? ChooseModeVC
            chooseModeVC!.devicesQty = devicesQty
        } 
    }
    
}
