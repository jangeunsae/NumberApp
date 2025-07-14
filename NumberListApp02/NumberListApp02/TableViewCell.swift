//
//  TableViewCell.swift
//  NumberListApp02
//
//  Created by 장은새 on 7/10/25.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let id = "TableViewCell"
    
    let profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.cornerRadius = 25
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        return profileImageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(numberLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 80),
            nameLabel.trailingAnchor.constraint(equalTo: numberLabel.leadingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            numberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
       
    }
    
    func configure(name: String, number: String, image: String) {
        DispatchQueue.main.async {
            self.nameLabel.text = name
            self.numberLabel.text = number
            print(image)
            if image != "" {
                self.profileImageView.kf.setImage(with: URL(string: image)!)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

#Preview {
    ViewController()
}
