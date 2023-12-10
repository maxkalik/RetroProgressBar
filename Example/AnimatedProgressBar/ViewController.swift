//
//  ViewController.swift
//  AnimatedProgressBar
//
//  Created by Maksim Kalik on 12/8/23.
//

import UIKit
import RetroProgressBar

class ViewController: UIViewController {

    let animatedProgressView = AnimatedProgressViewWrapper()

    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        
        view.addSubview(animatedProgressView)

        animatedProgressView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            animatedProgressView.heightAnchor.constraint(equalToConstant: 10),
            animatedProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animatedProgressView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            animatedProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            animatedProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AnimatedProgressViewWrapper: UIView {
    
    let animatedProgressView = {
        let view = RetroProgressBar()
        view.progressColor = .systemBlue
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        view.cornerRadius = 5
        view.borderWidth = 2
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(animatedProgressView)

        animatedProgressView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            animatedProgressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animatedProgressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animatedProgressView.topAnchor.constraint(equalTo: topAnchor),
            animatedProgressView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        DispatchQueue.main.async {
            self.animatedProgressView.setValueWithAnimation(0.2)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.animatedProgressView.setValueWithAnimation(0.4)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.animatedProgressView.setValueWithAnimation(0.6)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            self.animatedProgressView.setValueWithAnimation(1.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
