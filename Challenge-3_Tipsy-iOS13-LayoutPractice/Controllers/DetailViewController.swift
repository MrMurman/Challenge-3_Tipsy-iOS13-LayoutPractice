//
//  DetailViewController.swift
//  Challenge-3_Tipsy-iOS13-LayoutPractice
//
//  Created by Андрей Бородкин on 12.04.2022.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {

    //MARK: - Variables
    
    
    
    //MARK: UI
    
    var totalPerPersonLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "Total per person"
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    var totalTipLabel: UILabel = {
        var lbl = UILabel()
        lbl.text = "23.3"
        lbl.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        lbl.textColor = ColorPalette.textColorStandard
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    var tipCommentLabel: UILabel = {
        var lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "Split between 2 people, with\n 10% tip."
        lbl.font = UIFont.systemFont(ofSize: 25)
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        
        return lbl
    }()
    
 
    
    lazy var recalculateButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("Recalculate", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        btn.backgroundColor = ColorPalette.buttonColor
        btn.addTarget(self, action: #selector(recalculateButtonPressed(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    
  
    
    //MARK: Other vars
    
    
//    var tipSelected: Int = 1
    var tipCalculator: TipCalculator!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
        let tip = tipCalculator.calculate()
        let split = Int(tipCalculator.split)
        let percentage = Int(tipCalculator.tipSelected*10)
        
        totalTipLabel.text = String(format: "%.1f", tip)
        tipCommentLabel.text = "Split between \(split), with \(percentage)% tip"
        
    }
    

    // MARK: - Methods
    
    
    
    
    // MARK: General
    
    @objc func recalculateButtonPressed(_ sender: UIButton) {
                
        self.dismiss(animated: true)

    }
    
    
    // MARK: UI set-up

    func setupUI() {
        
        let mainStack = setupStackView(arrangedSubviews: [tipCommentLabel], axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 10)
        
        let bottomStack = setupStackView(arrangedSubviews: [mainStack, recalculateButton], axis: .vertical, distribution: .equalSpacing, alignment: .center, spacing: 0)
        bottomStack.backgroundColor = ColorPalette.backgroundColorStrong
        let topStack = setupStackView(arrangedSubviews: [totalPerPersonLabel, totalTipLabel], axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: -50)
        
        let vStack = setupStackView(arrangedSubviews: [topStack, bottomStack], axis: .vertical, distribution: .fill, alignment: .center, spacing: 0)
        
        view.addSubview(vStack)
        view.backgroundColor = ColorPalette.backGroundColorLight
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            vStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topStack.heightAnchor.constraint(equalTo: vStack.heightAnchor, multiplier: 0.3),
            topStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            
            bottomStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            
            mainStack.widthAnchor.constraint(equalTo: bottomStack.widthAnchor, constant: -20),
            mainStack.topAnchor.constraint(equalTo: bottomStack.topAnchor, constant: 20),
          
            totalTipLabel.bottomAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 40),
            tipCommentLabel.topAnchor.constraint(equalTo: bottomStack.topAnchor, constant: 40),
            
            recalculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            recalculateButton.centerXAnchor.constraint(equalTo: vStack.centerXAnchor),
            recalculateButton.heightAnchor.constraint(equalToConstant: 50),
            recalculateButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
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
        
        btn.addTarget(self, action: #selector(recalculateButtonPressed(_:)), for: .touchUpInside)
        
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

struct DetailFlowProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let view = DetailViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<DetailFlowProvider.ContainterView>) -> DetailViewController {
            return view
        }
        
        func updateUIViewController(_ uiViewController: DetailFlowProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<DetailFlowProvider.ContainterView>) {
            
        }
        
    }
    
}
