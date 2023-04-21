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
    private let saveButton = UIButton()
    private let deleteButton = UIButton()
    
    private let storage: StorageManagerProtocol = StorageManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupView()
        makeConstraints()
    }
    
    func setupView() {
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(saveButton)
        view.addSubview(deleteButton)
        
        label.text = storage.string(forKey: .textFieldText) ?? "Have no data"
        
        textField.backgroundColor = .blue.withAlphaComponent(0.2)
        
        saveButton.backgroundColor = .systemGreen
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        deleteButton.backgroundColor = .systemRed
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(del), for: .touchUpInside)
    }
    
    func makeConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            textField.widthAnchor.constraint(equalToConstant: 300),
            
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            
            deleteButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            deleteButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @IBAction func save() {
        if textField.hasText {
            print("Data Saved")
            
            storage.set(textField.text, forKey: .textFieldText)
            label.text = textField.text
        }
    }
    
    @IBAction func del() {
        storage.remove(forKey: .textFieldText)
        label.text = "Have no data"
    }
}
