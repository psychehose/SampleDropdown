//
//  ViewController.swift
//  SampleDropdown
//
//  Created by 김호세 on 2022/02/19.
//

import UIKit


final class ViewController: UIViewController {

    lazy var dropdownButton: UIButton = {
        let button = UIButton()
        button.setTitle("Drop!!", for: .normal)
        button.setTitleColor(.systemIndigo, for: .normal)
        button.addTarget(self, action: #selector(dropTapped(_: )), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    let dropdownListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.alwaysBounceVertical = false
        return tableView
    }()
    var colors: [UIColor] = [.red, .systemIndigo, .blue, .black, .gray]
    
    private var height = NSLayoutConstraint()
    private var isDroping: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello DropDown")
        dropdownListTableView.delegate = self
        dropdownListTableView.dataSource = self
        makeUI()
    }
    @objc
    private func dropTapped(_ sender: UIButton) {
        print("contentSize\(dropdownListTableView.contentSize.height)")

        if isDroping {
            dismissDropdown()
        }
        else if !isDroping {
            showDropdown()
        }

    }
}
extension ViewController {
    private func makeUI() {
        view.addSubview(dropdownButton)
        view.addSubview(dropdownListTableView)

        height = dropdownListTableView.heightAnchor.constraint(equalToConstant: 0)

        NSLayoutConstraint.activate([
            dropdownButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            dropdownButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            dropdownListTableView.topAnchor.constraint(equalTo: dropdownButton.bottomAnchor, constant: 30),
            dropdownListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dropdownListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            height
        ])
        
    }
}
extension ViewController {
    private func showDropdown() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseIn
        ) {
            self.height.constant = self.dropdownListTableView.contentSize.height
            self.view.layoutIfNeeded()
            
        } completion: { _ in
            self.isDroping = true
        }
    }
    private func dismissDropdown() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseOut
        ) {
            self.height.constant = 0
            self.view.layoutIfNeeded()
            
        } completion: { _ in
            self.isDroping = false
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row % colors.count]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DidTap Cell!!!  indexPath: \(indexPath)")
    }
}
