//
//  ViewController.swift
//  MinimalVCFinal
//  Created by James Rochabrun on 4/26/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.

import IntentsUI
import UIKit

class MinimalVC: UITableViewController {
    
    // MARK:- Properties
    var movieDataSource: MovieDataSource? {
        didSet { tableView.reloadData() }
    }
    
    // Siri UI
    lazy var siriPresenter: SiriRecordPresenter = {
        let intent = MovieFeedIntent()
        intent.suggestedInvocationPhrase = "What's new on Theaters"
        let presenter = SiriRecordPresenter(intent: intent, viewController: self, interactionIdentifier: "Movie Feed")
        presenter.delegate = self
        return presenter
    }()
    
    let siriButtonContainer: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        performNetworkCall()
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        tableView.register(MovieCell.self)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        self.title = "Movies"
        // Siri Container
        setUpContainer()
        
        
        let button: INUIAddVoiceShortcutButton = INUIAddVoiceShortcutButton(style: .blackOutline)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        siriButtonContainer.addSubview(button)
        siriButtonContainer.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        siriButtonContainer.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        button.addTarget(self, action: #selector(displaySiriUI), for: .touchUpInside)
    }
    
    private func setUpContainer() {
        
        guard let window = UIApplication.shared.keyWindow else { fatalError() }
        window.addSubview(siriButtonContainer)
        //let bounds = window.bounds
        NSLayoutConstraint.activate([
            siriButtonContainer.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            siriButtonContainer.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            siriButtonContainer.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            siriButtonContainer.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func displaySiriUI() {
        self.siriButtonContainer.isHidden = true
        self.siriPresenter.presentSiriRecordController()
    }
    
    private func performNetworkCall() {
        MovieService.sharedInstance.getNowPlayingMovies { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .Success(let dataSource):
                strongSelf.movieDataSource = dataSource
                strongSelf.tableView.dataSource = strongSelf.movieDataSource
            case .Error(let error):
                print(error)
            }
        }
    }
}

extension MinimalVC: YRSiriRecordPresenterDelegate {
    
    func recordedAndDonated() {
        self.siriButtonContainer.isHidden = true
    }
    
    func intentRecordingCancelled() {
        self.siriButtonContainer.isHidden = false
    }
}
























