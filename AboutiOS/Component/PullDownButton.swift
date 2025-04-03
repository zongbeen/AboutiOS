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
        //configModel과 keyPath를 저장
        self.configModel = configModel
        self.keyPath = keyPath
        
        //버튼을 탭하면 바로 메뉴 표시
        self.showsMenuAsPrimaryAction = true
        self.tintColor = .systemGray
        
        //텍스트를 오른쪽 정렬
        self.contentHorizontalAlignment = .trailing
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        
        //초기 버튼 타이틀 설정
        updateTitle(with: configModel[keyPath: keyPath])
        
        //UIMenu를 생성하여 드롭다운 메뉴 구성
        self.menu = UIMenu(children: options.map { option in
            UIAction(title: "\(option)") { [weak self] _ in
                guard let self = self else { return }
                self.configModel[keyPath: self.keyPath] = option
                self.updateTitle(with: option)
            }
        })
        
        //버튼 크기 조정 - 글자 수에 따른 크기 변경
        self.sizeToFit()
        self.frame.size = CGSize(width: max(self.frame.width, 80), height: max(self.frame.height, 30))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateTitle(with value: T) {
        let image = UIImage(systemName: "chevron.up.chevron.down")!
        //텍스트 + 아이콘
        let attributedString = NSMutableAttributedString(string: "\(value) ")
        let attachment = NSTextAttachment()
        attachment.image = image.withRenderingMode(.alwaysTemplate)
        attributedString.append(NSAttributedString(attachment: attachment))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGray, range: NSRange(location: 0, length: attributedString.length))
        self.setAttributedTitle(attributedString, for: .normal)
        self.sizeToFit()
    }
}
