//
//  EnterHintVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 03/02/2019.
//  Copyright © 2019 Dmitry Dementyev. All rights reserved.
//

import UIKit

class EnterHintVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var confirmButton: UIRoundedButton!
    
    var pickerData: [String] = []
    var maxQty: Int!
    weak var delegate: ReturnHintDelegate?
    var hint: Hint!
    var isTutorial: Bool!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        generateData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self

        textField.becomeFirstResponder()
        textField.autocapitalizationType = .sentences
        addTaps(singleTapAction: #selector(singleTap))

        mainView.setBackgroundImage(named: "paper_600x450px", alpha: 1, contentMode: .scaleToFill)
        confirmButton.makeRounded(color: K.Colors.mainVCbuttons, sound: K.Sounds.click)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isTutorial {
            let currentTeam = delegate?.currentTeam()
            textField.addLettersOneByOne(text: Ru.tutorialHint[currentTeam!]!, inDuration: T.Delay.enterHintText)
            DispatchQueue.main.asyncAfter(deadline: .now() + T.Delay.enterHintText, execute: {
                self.pickerView.selectRow(T.picker[currentTeam!]!, inComponent: 0, animated: true)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + T.Delay.enterHintText + T.Delay.changePicker, execute: {
                self.hint = self.hintInPicker
                print(self.hint.qty)
                print(self.hint.text)
                //self.dismiss(animated: true, completion: nil)
                self.pressConfirmButton(self.confirmButton)
            })
        }
    }
}
//MARK: - GestureRecognizer
private extension EnterHintVC {
    @IBAction func pressConfirmButton(_ sender: Any) {
        if hintInPicker.text != "" {
            delegate?.addHint(hint: hintInPicker)
            hint.text = ""
            hint.qty = 1
            dismiss(animated: false, completion: {
                self.delegate?.nextTurn()
            })
        }
    }
    
    @objc private func singleTap(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            if textField.isFirstResponder {
                self.view.endEditing(true)
            } else {
                hint = hintInPicker
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
//MARK: - Private functions
private extension EnterHintVC {
    var hintInPicker: Hint {
        get {
            hint.text = textField.text!
            hint.qty = Helper.IntInf(pickerData[pickerView.selectedRow(inComponent: 0)])
            return hint
        }
        set {
            textField.text = newValue.text
            if let row = pickerData.index(where: {Helper.IntInf($0) == newValue.qty}) {
                pickerView.selectRow(row, inComponent: 0, animated: false)
            }
        }
    }
    func generateData() {
        for i in Array(1...maxQty)+[0,Int.max] {
            pickerData.append(Helper.StrInf(i))
        }
        hintInPicker = hint
    }
}

//MARK: - Delegate functions
extension EnterHintVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EnterHintVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
}
extension EnterHintVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
}
