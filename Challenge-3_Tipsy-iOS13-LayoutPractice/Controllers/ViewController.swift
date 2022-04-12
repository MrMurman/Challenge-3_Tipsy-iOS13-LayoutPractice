//
//  ViewController.swift
//  Challenge-3_Tipsy-iOS13-LayoutPractice
//
//  Created by Андрей Бородкин on 12.04.2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Variables
    
    
    
    //MARK: UI
    
    var enterBillLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "Enter bill total"
        lbl.font = UIFont.systemFont(ofSize: 25)
        lbl.textColor = .lightGray
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    var selectTipLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "Select Tip"
        lbl.font = UIFont.systemFont(ofSize: 25)
        lbl.textColor = .lightGray
        
        return lbl
    }()
    
    var chooseSplitLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "Choose Split"
        lbl.font = UIFont.systemFont(ofSize: 25)
        lbl.textColor = .lightGray
        
        return lbl
    }()
    
   lazy var numberOfGuestsLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "2"
       lbl.font = UIFont.systemFont(ofSize: 35)
        lbl.textColor = ColorPalette.textColorStandard
        
        return lbl
    }()
    
    var billTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "e.g. 123.56"
        textField.textColor = ColorPalette.textColorStandard
        textField.font = UIFont.systemFont(ofSize: 40)
        textField.keyboardType = UIKeyboardType.decimalPad
        
        return textField
    }()
    
    lazy var numberOfGuestsStepper: UIStepper = {
        var stepper = UIStepper()
        stepper.value = 2
        stepper.addTarget(self, action: #selector(splitCosen(_:)), for: .touchUpInside)
        
        return stepper
    }()
    
    var calculateButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("Calculate", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        btn.backgroundColor = ColorPalette.buttonColor
        btn.addTarget(self, action: #selector(calculateButtonPressed(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var buttonsArray = [getDiscountButton(for: "0%", tag: 0), getDiscountButton(for: "10%", tag: 1), getDiscountButton(for: "20%", tag: 2)]
    
    
    //MARK: Other vars
    
    var tipCalculator = TipCalculator()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        billTextField.delegate = self
        updateUI()
    }
    
    

    // MARK: - Methods
    
    
    
    
    // MARK: General
    
    @objc func discountButtonPressed(_ sender: UIButton) {
                
        billTextField.endEditing(true)
        tipCalculator.tipSelected = sender.tag
        buttonsArray.forEach({button in
            if button.tag == tipCalculator.tipSelected {
                button.isSelected = true
                button.backgroundColor = ColorPalette.buttonColor
            } else {
                button.isSelected = false
                button.backgroundColor = .clear
            }
        })
    }
    
    @objc func splitCosen(_ sender: UIStepper) {
        
        if sender.value > 0 {
            tipCalculator.split = sender.value
            updateUI()
        }
    }
    
    func updateUI() {
        numberOfGuestsLabel.text = String(format: "%.0f", tipCalculator.split)
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let allowedCharacters = CharacterSet.decimalDigits
//        let characterSet = CharacterSet(charactersIn: string)
//        
//        return allowedCharacters.isSuperset(of: characterSet)
//    }
    
    @objc func calculateButtonPressed(_ sender: UIButton) {
        guard let bill = billTextField.text else {return}
        
        tipCalculator.bill = Double(bill) ?? 0
        
        let destinationVC = DetailViewController()
        destinationVC.tipCalculator = tipCalculator
        
        navigationController?.present(destinationVC, animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: UI set-up

    func setupUI() {
        
        let buttonStack = setupStackView(arrangedSubviews: buttonsArray, axis: .horizontal, distribution: .fillProportionally, alignment: .fill, spacing: 0)
        let numberOfGuestsStack = setupStackView(arrangedSubviews: [numberOfGuestsLabel, numberOfGuestsStepper], axis: .horizontal, distribution: .fillEqually, alignment: .center, spacing: 5)
        let mainStack = setupStackView(arrangedSubviews: [selectTipLabel, buttonStack, chooseSplitLabel, numberOfGuestsStack], axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 10)
        
        
        let bottomStack = setupStackView(arrangedSubviews: [mainStack, calculateButton], axis: .vertical, distribution: .equalSpacing, alignment: .center, spacing: 0)
        bottomStack.backgroundColor = ColorPalette.backgroundColorStrong
        let topStack = setupStackView(arrangedSubviews: [enterBillLabel, billTextField], axis: .vertical, distribution: .fill, alignment: .center, spacing: 10)
        
        let vStack = setupStackView(arrangedSubviews: [topStack, bottomStack], axis: .vertical, distribution: .fill, alignment: .center, spacing: 0)
        
        view.addSubview(vStack)
        view.backgroundColor = ColorPalette.backGroundColorLight
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            vStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topStack.heightAnchor.constraint(equalTo: vStack.heightAnchor, multiplier: 0.2),
            topStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            bottomStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            mainStack.widthAnchor.constraint(equalTo: bottomStack.widthAnchor, constant: -20),
            mainStack.topAnchor.constraint(equalTo: bottomStack.topAnchor, constant: 20),
            buttonStack.widthAnchor.constraint(equalTo: mainStack.widthAnchor, constant: 0),
            selectTipLabel.widthAnchor.constraint(equalTo: mainStack.widthAnchor, constant: -80),
            chooseSplitLabel.widthAnchor.constraint(equalTo: mainStack.widthAnchor, constant:  -80),
            billTextField.bottomAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 40),
            enterBillLabel.widthAnchor.constraint(equalTo: topStack.widthAnchor, constant: -100),
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            calculateButton.centerXAnchor.constraint(equalTo: vStack.centerXAnchor),
            calculateButton.heightAnchor.constraint(equalToConstant: 50),
            calculateButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
        ])
        
    }
    
    func getDiscountButton(for title: String, tag: Int) -> UIButton {
        let btn = UIButton()
        btn.tag = tag
        enum SenderColor {
            case clear
            case green
        }
        
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        btn.setTitleColor(ColorPalette.textColorStandard, for: .normal)
        btn.setTitleColor(ColorPalette.textColorSelected, for: .selected)
        
        btn.addTarget(self, action: #selector(discountButtonPressed(_:)), for: .touchUpInside)
        
        return btn
    }
    
    func setupStackView(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, spacing: CGFloat) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.axis = axis
        stack.distribution = distribution
        stack.alignment = alignment
        stack.spacing = spacing
        
        return stack
    }
}


//MARK: - Canvas

struct FlowProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let view = ViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) -> ViewController {
            return view
        }
        
        func updateUIViewController(_ uiViewController: FlowProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) {
            
        }
        
    }
    
}

