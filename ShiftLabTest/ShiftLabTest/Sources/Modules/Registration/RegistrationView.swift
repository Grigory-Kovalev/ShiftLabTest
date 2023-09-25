//
//  RegistrationView.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 22.09.2023.
//

import UIKit

protocol RegistrationViewProtocol: AnyObject {
    func registerButtonWasTapped()
    
}

final class RegistrationView: UIView {
    //MARK: - Metrics
    enum Metrics {
        static let titlesStackViewTopConstraint: CGFloat = 16
        static let stackViewSpacing: CGFloat = 16
        static let birthdayStackSpacing: CGFloat = 10
        static let textFieldsStackViewSpacing: CGFloat = 16
        static let registerButtonCornerRadius: CGFloat = 10
        static let registerButtontitleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        static let textFieldsStackViewleadingAnchor: CGFloat = 16
        static let textFieldsStackViewTrailingAnchor: CGFloat = -16
        
        static let confirmButtonTopAnchor: CGFloat = 32
        static let confirmButtonWidth: CGFloat = 25
        static let confirmButtonHeight: CGFloat = 25
        
        static let policyLabelLeadingAnchor: CGFloat = 16
        
        static let bottomViewHeight: CGFloat = 40
        
        static let registerButtonLeadingSpace: CGFloat = 16
        static let registerButtonBottomSpace: CGFloat = -16
        static let registerButtonTrailingSpace: CGFloat = -16
        static let registerButtonHeight: CGFloat = 50
        
        static let textFieldWidth: CGFloat = 343
        static let textFieldHeight: CGFloat = 58
        static let textFieldLeadingAnchor: CGFloat = 16
        static let textFieldTrailingAnchor: CGFloat = -60
        static let textFieldSecureButtonLeadingAnchor: CGFloat = 16
        static let textFieldSecureButtonWidth: CGFloat = 25
        static let textFieldSecureButtonHeight: CGFloat = 25
        static let textFieldCornerRadius: CGFloat = 10
        static let textFieldBorderWidth: CGFloat = 2
        
        static let animationDuration = 0.3
    }
    
    // MARK: - Properties
    
    weak var viewController: RegistrationViewController?
    
    // MARK: - Subviews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Resource.RegisterScreen.Texts.titleText
        label.font = Resource.RegisterScreen.Fonts.titleFont
        label.textColor = Resource.RegisterScreen.Colors.customGreen
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Resource.RegisterScreen.Texts.subTitleText
        label.font = Resource.RegisterScreen.Fonts.subTitleFont
        label.textColor = Resource.RegisterScreen.Colors.customGray
        return label
    }()
    
    private lazy var titlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Metrics.stackViewSpacing
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        return stackView
    }()
    
    private lazy var birthdayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Resource.RegisterScreen.Colors.customGray
        label.text = Resource.RegisterScreen.Texts.birthdayLabel
        return label
    }()
    
    lazy var birthdayDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.tintColor = .systemBlue
        let currentDate = Date()
        picker.maximumDate = currentDate
        return picker
    }()
    
    private lazy var birthdayStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Metrics.birthdayStackSpacing
        stackView.alignment = .center
        stackView.addArrangedSubview(birthdayLabel)
        stackView.addArrangedSubview(birthdayDatePicker)
        return stackView
    }()
    
    lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Metrics.textFieldsStackViewSpacing
        stackView.addArrangedSubview(createTextField(tag: Resource.RegisterScreen.TextFieldConfig.Tag.firstName,placeholder: Resource.RegisterScreen.TextFieldConfig.placeholder.firstName, image: UIImage(systemName: Resource.RegisterScreen.TextFieldConfig.Image.firstName)!, imageSize: Resource.RegisterScreen.TextFieldConfig.ImageSize.firstName))
        stackView.addArrangedSubview(createTextField(tag: Resource.RegisterScreen.TextFieldConfig.Tag.lastName, placeholder: Resource.RegisterScreen.TextFieldConfig.placeholder.lastName, image: UIImage(systemName: Resource.RegisterScreen.TextFieldConfig.Image.lastName)!, imageSize: Resource.RegisterScreen.TextFieldConfig.ImageSize.lastName))
        stackView.addArrangedSubview(birthdayStack)
        stackView.addArrangedSubview(createTextField(tag: Resource.RegisterScreen.TextFieldConfig.Tag.password, placeholder: Resource.RegisterScreen.TextFieldConfig.placeholder.password, image: UIImage(systemName: Resource.RegisterScreen.TextFieldConfig.Image.password)!, imageSize: Resource.RegisterScreen.TextFieldConfig.ImageSize.password, isSecure: true, selector: #selector(firstSecureButtonTapped)))
        stackView.addArrangedSubview(createTextField(tag: Resource.RegisterScreen.TextFieldConfig.Tag.confirmPassword, placeholder: Resource.RegisterScreen.TextFieldConfig.placeholder.confirmPassword, image: UIImage(systemName: Resource.RegisterScreen.TextFieldConfig.Image.confirmPassword)!, imageSize: Resource.RegisterScreen.TextFieldConfig.ImageSize.confirmPassword, isSecure: true, selector: #selector(secondSecureButtonTapped)))
        return stackView
    }()
    
    private lazy var confirmButton: UIButton = {
        let confirmButton = UIButton()
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.setImage(UIImage(systemName: Resource.RegisterScreen.Image.confirmButton), for: .normal)
        confirmButton.imageView?.contentMode = .scaleAspectFill
        confirmButton.contentHorizontalAlignment = .fill
        confirmButton.contentVerticalAlignment = .fill
        confirmButton.tintColor = Resource.RegisterScreen.Colors.customGreen
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return confirmButton
    }()
    
    private lazy var policyLabel: UILabel = {
        let policyLabel = UILabel()
        policyLabel.translatesAutoresizingMaskIntoConstraints = false
        policyLabel.font = Resource.RegisterScreen.Fonts.policyLabel
        policyLabel.numberOfLines = 2
        let attributedString = NSMutableAttributedString(string: Resource.RegisterScreen.Texts.policyLabel)
        attributedString.addAttribute(.foregroundColor, value: Resource.RegisterScreen.Colors.customGray, range: NSRange(location: 0, length: attributedString.length))
        
        let termsRange = (attributedString.string as NSString).range(of: "Terms of Use")
        attributedString.addAttribute(.foregroundColor, value: Resource.RegisterScreen.Colors.customGreen, range: termsRange)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: termsRange)
        
        let privacyRange = (attributedString.string as NSString).range(of: "Privacy Policy")
        attributedString.addAttribute(.foregroundColor, value: Resource.RegisterScreen.Colors.customGreen, range: privacyRange)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: privacyRange)
        
        policyLabel.attributedText = attributedString
        policyLabel.translatesAutoresizingMaskIntoConstraints = false
        return policyLabel
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Resource.RegisterScreen.Colors.customGray
        button.isEnabled = false
        button.setTitle(Resource.RegisterScreen.Texts.registerButton, for: .normal)
        button.layer.cornerRadius = Metrics.registerButtonCornerRadius
        button.titleEdgeInsets = Metrics.registerButtontitleEdgeInsets
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = Resource.RegisterScreen.Colors.customGreen.withAlphaComponent(0.15)
        
        let label = UILabel()
        label.font = Resource.RegisterScreen.Fonts.bottomView
        
        let attributedString = NSMutableAttributedString(string: Resource.RegisterScreen.Texts.bottomView)
        attributedString.addAttribute(.foregroundColor, value: Resource.RegisterScreen.Colors.customGray, range: NSRange(location: 0, length: attributedString.length))
        
        let termsRange = (attributedString.string as NSString).range(of: "Log in")
        attributedString.addAttribute(.foregroundColor, value: Resource.RegisterScreen.Colors.customGreen, range: termsRange)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: termsRange)
        
        label.attributedText = attributedString
        
        label.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor)
        ])
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    lazy var cancelButton: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: Resource.RegisterScreen.Texts.cancelButton, style: .plain, target: self, action: #selector(cancelButtonTapped))
        toolbar.items = [flexibleSpace, cancelButton]
        
        return toolbar
    }()
    
    private lazy var topSafeAreaBackground: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupUI()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configure
private extension RegistrationView {
    func configure() {
        self.backgroundColor = Resource.RegisterScreen.Colors.background
    }
}

// MARK: - Layout
private extension RegistrationView {
    func setupUI() {
        self.addSubview(topSafeAreaBackground)
        NSLayoutConstraint.activate([
            topSafeAreaBackground.topAnchor.constraint(equalTo: topAnchor),
            topSafeAreaBackground.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            topSafeAreaBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSafeAreaBackground.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        self.addSubview(titlesStackView)
        NSLayoutConstraint.activate([
            titlesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titlesStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.titlesStackViewTopConstraint)
        ])
        
        self.addSubview(textFieldsStackView)
        NSLayoutConstraint.activate([
            textFieldsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.textFieldsStackViewleadingAnchor),
            textFieldsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.textFieldsStackViewTrailingAnchor),
            textFieldsStackView.topAnchor.constraint(equalTo: titlesStackView.bottomAnchor, constant: Metrics.textFieldsStackViewSpacing)
        ])
        
        self.addSubview(confirmButton)
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: textFieldsStackView.leadingAnchor),
            confirmButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: Metrics.confirmButtonTopAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: Metrics.confirmButtonWidth),
            confirmButton.heightAnchor.constraint(equalToConstant: Metrics.confirmButtonHeight)
        ])
        
        self.addSubview(policyLabel)
        NSLayoutConstraint.activate([
            policyLabel.centerYAnchor.constraint(equalTo: confirmButton.centerYAnchor),
            policyLabel.leadingAnchor.constraint(equalTo: confirmButton.trailingAnchor, constant: Metrics.policyLabelLeadingAnchor),
            policyLabel.trailingAnchor.constraint(equalTo: textFieldsStackView.trailingAnchor)
        ])
        
        self.addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: Metrics.bottomViewHeight)
        ])
        
        self.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: Metrics.registerButtonBottomSpace),
            registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.registerButtonLeadingSpace),
            registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.registerButtonTrailingSpace),
            registerButton.heightAnchor.constraint(equalToConstant: Metrics.registerButtonHeight)
        ])
        
    }
}

//MARK: - Private Methods
private extension RegistrationView {
    func createTextField(tag: Int, placeholder: String, image: UIImage, imageSize: (width: CGFloat, height: CGFloat), isSecure: Bool = false, selector: Selector? = nil) -> UIView {
        let resultView = UIView()
        
        resultView.translatesAutoresizingMaskIntoConstraints = false
        
        resultView.backgroundColor = Resource.RegisterScreen.Colors.textFieldBackground
        resultView.layer.cornerRadius = Metrics.textFieldCornerRadius
        resultView.layer.borderColor = Resource.RegisterScreen.Colors.textFieldStroke
        resultView.layer.borderWidth = Metrics.textFieldBorderWidth
        
        let imageView = UIImageView(image: image)
        imageView.tintColor = Resource.RegisterScreen.Colors.textFieldImage
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        resultView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: Metrics.textFieldLeadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: resultView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: imageSize.height)
        ])
        
        let textField = UITextField()
        textField.inputAccessoryView = cancelButton
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        textField.tag = tag
        
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.foregroundColor: Resource.RegisterScreen.Colors.textFieldPlaceholder,
        ])
        textField.attributedPlaceholder = attributedPlaceholder
        
        let attributedText = NSAttributedString(string: "", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ])
        textField.attributedText = attributedText
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        resultView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Metrics.textFieldSecureButtonLeadingAnchor),
            textField.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: Metrics.textFieldTrailingAnchor),
            textField.centerYAnchor.constraint(equalTo: resultView.centerYAnchor)
        ])
        
        if isSecure, let selector {
            let secureButton = UIButton()
            secureButton.setImage(UIImage(systemName: Resource.RegisterScreen.Image.secureTextField), for: .normal)
            secureButton.addTarget(self, action: selector, for: .touchUpInside)
            secureButton.tintColor = Resource.RegisterScreen.Colors.customGreen
            
            secureButton.translatesAutoresizingMaskIntoConstraints = false
            resultView.addSubview(secureButton)
            NSLayoutConstraint.activate([
                secureButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: Metrics.textFieldSecureButtonLeadingAnchor),
                secureButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
                secureButton.widthAnchor.constraint(equalToConstant: Metrics.textFieldSecureButtonWidth),
                secureButton.heightAnchor.constraint(equalToConstant: Metrics.textFieldSecureButtonHeight)
            ])
        }
        
        NSLayoutConstraint.activate([
            resultView.widthAnchor.constraint(equalToConstant: Metrics.textFieldWidth),
            resultView.heightAnchor.constraint(equalToConstant: Metrics.textFieldHeight)
        ])
        
        return resultView
    }
    
    
    @objc func firstSecureButtonTapped(_ sender: UIButton) {
        self.viewController?.firstSecureButtonTapped(sender)
    }
    
    @objc func secondSecureButtonTapped(_ sender: UIButton) {
        self.viewController?.secondSecureButtonTapped(sender)
    }
    
    @objc func confirmButtonTapped(_ sender: UIButton) {
        self.viewController?.confirmButtonTapped(sender)
    }
    
    @objc func cancelButtonTapped() {
        self.viewController?.cancelButtonTapped()
    }
    
    @objc private func registerButtonTapped() {
        self.viewController?.registerButtonTapped()
    }
}


