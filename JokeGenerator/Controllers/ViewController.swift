import UIKit

// MARK - DOTO: Сделать через стек

class ViewController: UIViewController {
    
    //MARK: UI
    
    private let jokeIdView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .white)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(resource: .black).cgColor
        return view
    }()

    private let jokeIdLabel: UILabel = {
        let label = UILabel()
        label.text = R.Localisable.jokeIdLabel.value
        label.textColor = UIColor(resource: .black)
        return label
    }()
    
    private let jokeIdNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .black)
        return label
    }()
    
    private let typeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .white)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(resource: .black).cgColor
        return view
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = R.Localisable.typeLabel.value
        label.textColor = UIColor(resource: .black)
        return label
    }()
    
    private let generalLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .black)
        return label
    }()
    
    private let generatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .pink)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(resource: .black).cgColor
        return view
    }()
    
    private let setupLabel: UILabel = {
        let label = UILabel()
        label.text = R.Localisable.setupLabel.value
        label.textColor = UIColor(resource: .black)
        return label
    }()
    
    private let topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .black)
        return view
    }()
    
    private let jokeTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(resource: .black)
        return label
    }()
    
    private let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .black)
        return view
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton(configuration: .gray())
        button.setImage(UIImage(resource: .arrow), for: .normal)
        button.backgroundColor = UIColor(resource: .white)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor(resource: .black).cgColor
        return button
    }()
    
    private let punchlineButton: UIButton = {
        var configuration = UIButton.Configuration.gray()
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
               outgoing.font = UIFont(name: "Roboto-Bold", size: 16)
               return outgoing
        }
        let button = UIButton(configuration: configuration)
        button.backgroundColor = UIColor(resource: .green)
        button.setTitle(R.Localisable.punchlineButton.value, for: .normal)
        button.tintColor = UIColor(resource: .black)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor(resource: .black).cgColor
        return button
    }()
    
    // MARK: Private Properties
    
    private let jokeLoader: JokesLoader = JokesLoader(networkService: NetworkService())
    private var textPunchline: String  = ""
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNetwork()

        setupViews()
        setupLayouts()
        setupAppearance()
        setupFontRoboto()
        setupButtonsActions()
    }
    
    // MARK: Public Methods
    
    private func loadNetwork() {
        self.jokeLoader.loadJokes { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.jokeIdNumberLabel.text = String(describing: data.id)
                    self.generalLabel.text = data.type
                    self.jokeTextLabel.text = data.setup
                    self.textPunchline = data.punchline
                case .failure:
                    print("Network Error")
                }
            }
        }
    }
    
    private func showAlert() {
        let message = self.textPunchline
        let alert = UIAlertController(title: "Punchline", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        
        self.present(alert, animated: true)
    }
    
    private func setupViews() {
        
        view.addView(jokeIdView)
        view.addView(typeView)
        view.addView(generatorView)
        view.addView(updateButton)
        view.addView(punchlineButton)
        
        jokeIdView.addView(jokeIdLabel)
        jokeIdView.addView(jokeIdNumberLabel)
        
        typeView.addView(typeLabel)
        typeView.addView(generalLabel)
        
        generatorView.addView(setupLabel)
        generatorView.addView(topLineView)
        generatorView.addView(jokeTextLabel)
        generatorView.addView(bottomLineView)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            jokeIdView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            jokeIdView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            jokeIdView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            jokeIdView.heightAnchor.constraint(equalToConstant: 64),
            
            jokeIdLabel.leadingAnchor.constraint(equalTo: jokeIdView.leadingAnchor, constant: 24),
            jokeIdLabel.centerYAnchor.constraint(equalTo: jokeIdView.centerYAnchor),
            
            jokeIdNumberLabel.trailingAnchor.constraint(equalTo: jokeIdView.trailingAnchor, constant: -24),
            jokeIdNumberLabel.centerYAnchor.constraint(equalTo: jokeIdView.centerYAnchor),
            
            typeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            typeView.topAnchor.constraint(equalTo: jokeIdView.bottomAnchor, constant: 24),
            typeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            typeView.heightAnchor.constraint(equalToConstant: 64),
            
            typeLabel.leadingAnchor.constraint(equalTo: typeView.leadingAnchor, constant: 24),
            typeLabel.centerYAnchor.constraint(equalTo: typeView.centerYAnchor),
            
            generalLabel.trailingAnchor.constraint(equalTo: typeView.trailingAnchor, constant: -24),
            generalLabel.centerYAnchor.constraint(equalTo: typeView.centerYAnchor),
            
            typeLabel.leadingAnchor.constraint(equalTo: typeView.leadingAnchor, constant: 24),
            typeLabel.centerYAnchor.constraint(equalTo: typeView.centerYAnchor),
            
            jokeIdNumberLabel.trailingAnchor.constraint(equalTo: jokeIdView.trailingAnchor, constant: -24),
            jokeIdNumberLabel.centerYAnchor.constraint(equalTo: jokeIdView.centerYAnchor),
            
            generatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            generatorView.topAnchor.constraint(equalTo: typeView.bottomAnchor, constant: 24),
            generatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            generatorView.heightAnchor.constraint(equalToConstant: 244),
            
            setupLabel.leadingAnchor.constraint(equalTo: generatorView.leadingAnchor, constant: 24),
            setupLabel.topAnchor.constraint(equalTo: generatorView.topAnchor, constant: 24),
            setupLabel.trailingAnchor.constraint(equalTo: generatorView.trailingAnchor, constant: -24),
            
            topLineView.leadingAnchor.constraint(equalTo: generatorView.leadingAnchor, constant: 24),
            topLineView.topAnchor.constraint(equalTo: setupLabel.bottomAnchor, constant: 18),
            topLineView.trailingAnchor.constraint(equalTo: generatorView.trailingAnchor, constant: -24),
            topLineView.heightAnchor.constraint(equalToConstant: 2),
            
            jokeTextLabel.leadingAnchor.constraint(equalTo: generatorView.leadingAnchor, constant: 24),
            jokeTextLabel.topAnchor.constraint(equalTo: topLineView.bottomAnchor, constant: 0),
            jokeTextLabel.trailingAnchor.constraint(equalTo: generatorView.trailingAnchor, constant: -24),
            jokeTextLabel.bottomAnchor.constraint(equalTo: bottomLineView.topAnchor, constant: -0),
            jokeTextLabel.heightAnchor.constraint(equalToConstant: 155),
            
            bottomLineView.leadingAnchor.constraint(equalTo: generatorView.leadingAnchor, constant: 24),
            bottomLineView.bottomAnchor.constraint(equalTo: generatorView.bottomAnchor, constant: -24),
            bottomLineView.trailingAnchor.constraint(equalTo: generatorView.trailingAnchor, constant: -24),
            bottomLineView.heightAnchor.constraint(equalToConstant: 2),
            
            updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64),
            updateButton.widthAnchor.constraint(equalToConstant: 64),
            updateButton.heightAnchor.constraint(equalToConstant: 64),
            
            punchlineButton.leadingAnchor.constraint(equalTo: updateButton.trailingAnchor, constant: 16),
            punchlineButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64),
            punchlineButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            punchlineButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
    
    func setupAppearance() {
        view.backgroundColor = UIColor(resource: .background)
    }
    
    func setupFontRoboto() {
        [
            jokeIdLabel,
            jokeIdNumberLabel,
            typeLabel,
            generalLabel,
            setupLabel,
        ].forEach {
            $0.font = UIFont(name: "Roboto-Medium", size: 16)
        }
        jokeTextLabel.font = UIFont(name: "Roboto-Bold", size: 24)
    }
    
    private func setupButtonsActions() {
        punchlineButton.addAction(UIAction { _ in
            self.showAlert()
        }, for: .touchUpInside)
        
        updateButton.addAction(UIAction { _ in
            self.loadNetwork()
        }, for: .touchUpInside)
    }
}

#Preview(traits: .portrait) {
    ViewController()
}
