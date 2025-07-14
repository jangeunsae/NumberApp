//
//  AddContactViewController.swift
//  NumberListApp02
//
//  Created by 장은새 on 7/10/25.
//

import UIKit
import SnapKit
import Kingfisher
import CoreData

final class AddContactViewController: UIViewController {
    
    var createImage: String = ""

    var persistenContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    @objc let applyButton: UIButton = {
        let applyButton = UIButton()
        applyButton.setTitleColor( .systemBlue, for: .normal)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        return applyButton
    }()
    let randomImageView: UIImageView = {
        let randomImageView = UIImageView()
        randomImageView.contentMode = .scaleAspectFit
        randomImageView.clipsToBounds = true
        randomImageView.layer.cornerRadius = 75
        randomImageView.layer.borderWidth = 2
        randomImageView.layer.borderColor = UIColor.systemGray.cgColor
        randomImageView.translatesAutoresizingMaskIntoConstraints = false
        return randomImageView
    }()
    
    let createButton: UIButton = {
        let createButton = UIButton()
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle( "랜덤이미지 생성", for: .normal)
        createButton.setTitleColor( .systemGray, for: .normal)
        createButton.addTarget(self, action: #selector(randomImageTapped), for: .touchDown)
        return createButton
    }()
    
    let nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.borderStyle = .roundedRect
        nameTextField.keyboardType = .default
        nameTextField.placeholder = "여기에 이름을 입력하세요"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    }()
    
    let numberTextField: UITextField = {
        let numberTextField = UITextField()
        numberTextField.borderStyle = .roundedRect
        numberTextField.keyboardType = .default
        numberTextField.placeholder = "여기에 전화번호를 입력하세요"
        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        return numberTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(applyButton)
        view.addSubview(randomImageView)
        view.addSubview(createButton)
        view.addSubview(nameTextField)
        view.addSubview(numberTextField)
        nameTextField.becomeFirstResponder()
        numberTextField.becomeFirstResponder()
        navigationConfigureUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(createData))
        navigationItem.title = "연락처 목록"
    }
    
    @objc func createData() {
        guard let context = self.persistenContainer?.viewContext else { return }
        let newPhoneBook = PhoneBook(context: context)
        newPhoneBook.name = nameTextField.text
        newPhoneBook.phoneNumber = numberTextField.text
        newPhoneBook.imageUrl = createImage
        try? context.save()
    }
    
    enum RquestError: Error {
        case urlError
        case dataError
    }
    @objc private func randomImageTapped() {
        
        let randomID = Int.random(in: 1...1000)
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"
        requestAPI(urlString: urlString) { sprites in
            DispatchQueue.main.async {
                self.createImage = sprites.front_default
                self.randomImageView.kf.setImage(with: URL(string: sprites.front_default)!)
            }
        }
    }
    
    func requestAPI(urlString: String, completion: @escaping(Sprites) -> Void ) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in guard let data else { return }
            let decoder = JSONDecoder()
            do {
                let poketmon = try decoder.decode(PocketmonImageResult.self, from: data)
                completion(poketmon.sprites)
            } catch {
                print("JSON Data Error")
            }
        }.resume()
    }
    
    
    private func navigationConfigureUI() {
        NSLayoutConstraint.activate([
            randomImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomImageView.widthAnchor.constraint(equalToConstant: 150),
            randomImageView.heightAnchor.constraint(equalToConstant: 150),
            randomImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
        
        NSLayoutConstraint.activate([
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.widthAnchor.constraint(equalToConstant: 150),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            createButton.topAnchor.constraint(equalTo: randomImageView.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 10),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 350),
            
        ])
        
        NSLayoutConstraint.activate([
            numberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            numberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
        
    }
}

#Preview {
    AddContactViewController()
}
