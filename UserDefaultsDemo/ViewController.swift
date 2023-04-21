//
//  ViewController.swift
//  UserDefaultsDemo
//
//  Created by Dmitrii Tikhomirov on 4/21/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let label = UILabel()
    private let textField = UITextField()
    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupView()
        makeConstraints()
    }
    
    func setupView() {
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(button)
        
        label.text = "Have no data"
        
        textField.backgroundColor = .blue.withAlphaComponent(0.2)
        
        button.backgroundColor = .blue.withAlphaComponent(0.5)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func makeConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            textField.widthAnchor.constraint(equalToConstant: 300),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @IBAction func buttonAction() {
        if textField.hasText {
            print("Data Saved")
            label.text = textField.text
        }
    }
}

