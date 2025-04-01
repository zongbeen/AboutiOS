//
//  PullDownButton.swift
//  AboutiOS
//
//  Created by 한종빈 on 4/1/25.
//

import UIKit

class PullDownButton<T>: UIButton {
    private var keyPath: WritableKeyPath<PullDownOption, T>!
    private var configModel: PullDownOption!
    
    init(configModel: PullDownOption, keyPath: WritableKeyPath<PullDownOption, T>, options: [T]) {
        super.init(frame: .zero)
        self.configModel = configModel
        self.keyPath = keyPath
        self.showsMenuAsPrimaryAction = true
        self.tintColor = .systemGray
        self.contentHorizontalAlignment = .trailing
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        
        updateTitle(with: configModel[keyPath: keyPath])
        
        self.menu = UIMenu(children: options.map { option in
            UIAction(title: "\(option)") { [weak self] _ in
                guard let self = self else { return }
                self.configModel[keyPath: self.keyPath] = option
                self.updateTitle(with: option)
            }
        })
        
        self.sizeToFit()
        self.frame.size = CGSize(width: max(self.frame.width, 80), height: max(self.frame.height, 30))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateTitle(with value: T) {
        let image = UIImage(systemName: "chevron.up.chevron.down")!
        let attributedString = NSMutableAttributedString(string: "\(value) ")
        let attachment = NSTextAttachment()
        attachment.image = image.withRenderingMode(.alwaysTemplate)
        attributedString.append(NSAttributedString(attachment: attachment))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGray, range: NSRange(location: 0, length: attributedString.length))
        self.setAttributedTitle(attributedString, for: .normal)
        self.sizeToFit()
    }
}
