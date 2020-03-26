//
//  PlaceholderTextView.swift
//  oruka_user_register
//
//  Created by 千葉大志 on 2019/07/06.
//  Copyright © 2019 Chibastudio. All rights reserved.
//

import UIKit

@IBDesignable
final class PlaceholderTextView: UITextView {
    
    var fadeTime: Double = 0
    
    override var textContainerInset: UIEdgeInsets {
        didSet {
            placeholderTextView.textContainerInset = textContainerInset
        }
    }
    
    var hasTextContainer: Bool {
        return !text.isEmpty
    }
    
    var placeholderTextColor: UIColor? {
        get {
            return placeholderTextView.textColor
        }
        set(value) {
            placeholderTextView.textColor = value
        }
    }
    
    var placeholder: String? {
        didSet {
            placeholderTextView.text = placeholder
            setupPlaceHolderTextView()
        }
    }
    
    override var text: String! {
        didSet {
            if hasTextContainer {
                setPlaceholderVisible(forText: placeholder ?? "")
            } else {
                setPlaceholderVisible(forText: "")
            }
        }
    }
    
    let placeholderTextView = UITextView()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func commonInit() {
        clipsToBounds = true
        placeholderTextView.isSelectable = false
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(notification:)),
                                               name: UITextView.textDidChangeNotification, object: self)
    }
    
    func setupPlaceHolderTextView() {
        placeholderTextView.isOpaque = false
        placeholderTextView.backgroundColor = UIColor.clear
        placeholderTextView.textColor = UIColor(white: 0.7, alpha: 0.7)
        placeholderTextView.textAlignment = textAlignment
        placeholderTextView.isEditable = false
        placeholderTextView.isScrollEnabled = false
        placeholderTextView.isUserInteractionEnabled = false
        placeholderTextView.font = font
        placeholderTextView.isAccessibilityElement = false
        placeholderTextView.contentOffset = contentOffset
        placeholderTextView.contentInset = contentInset
        placeholderTextView.textContainerInset = textContainerInset
        
        if hasTextContainer {
            placeholderTextView.textContainer.exclusionPaths = textContainer.exclusionPaths
            placeholderTextView.isSelectable = false
        }
        
        self.setPlaceholderVisible(forText: text)
    }
}


// MARK: - Life cycle
extension PlaceholderTextView {
    
    fileprivate func resizePlaceholderFrame() {
        var frame = placeholderTextView.bounds
        frame.size = self.bounds.size
        placeholderTextView.frame = frame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        resizePlaceholderFrame()
    }
    
    fileprivate func setPlaceholderVisible(forText text: String) {
        if text.count < 1 {
            if fadeTime > 0.0 {
                if !placeholderTextView.isDescendant(of: self) {
                    placeholderTextView.alpha = 0
                    addSubview(placeholderTextView)
                    sendSubviewToBack(placeholderTextView)
                }
                UIView.animate(withDuration: fadeTime, animations: {
                    self.placeholderTextView.alpha = 1.0
                })
            } else {
                addSubview(placeholderTextView)
                sendSubviewToBack(placeholderTextView)
                placeholderTextView.alpha = 1.0
            }
        } else {
            if fadeTime > 0.0 {
                UIView.animate(withDuration: fadeTime, animations: {
                    self.placeholderTextView.alpha = 1.0
                })
            } else {
                placeholderTextView.removeFromSuperview()
            }
        }
    }
}

// MARK: - Notification methods
extension PlaceholderTextView {
    
    @objc func textDidChange(notification: NSNotification) {
        if hasTextContainer {
            setPlaceholderVisible(forText: placeholder ?? "")
        } else {
            setPlaceholderVisible(forText: "")
        }
    }
}

// MARK: UIScrollViewDelegate
extension PlaceholderTextView: UIScrollViewDelegate {
    
    override func scrollRangeToVisible(_ range: NSRange) {
        super.scrollRangeToVisible(range)
        
        if layoutManager.extraLineFragmentTextContainer == nil { return }
        guard let textRange = selectedTextRange else { return }
        
        if selectedRange.location == range.location {
            let caretRect = self.caretRect(for: textRange.start)
            scrollRectToVisible(caretRect, animated: true)
        }
    }
}
