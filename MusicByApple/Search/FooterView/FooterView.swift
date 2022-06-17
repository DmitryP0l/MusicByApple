//
//  FooterView.swift
//  MusicByApple
//
//  Created by lion on 17.06.22.
//

import UIKit

final class FooterView: UIView {
    
    private var myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.6919150949, green: 0.7063220143, blue: 0.7199969292, alpha: 1)
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        addSubview(myLabel)
        addSubview(loader)
        
        myLabel.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 4).isActive = true
        myLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        loader.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func showLoader() {
        loader.startAnimating()
        myLabel.text = "Loading..."
    }
    
    func hideLoader() {
        loader.stopAnimating()
        myLabel.text = ""
    }
}
