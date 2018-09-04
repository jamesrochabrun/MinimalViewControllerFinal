//
//  SiriRecorderPresenter.swift
//  MinimalVCFinal
//
//  Created by James Rochabrun on 9/3/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit
import IntentsUI


protocol SiriUIPresentable: INUIAddVoiceShortcutViewControllerDelegate {
    
    var siriController: INUIAddVoiceShortcutViewController? { get }
    var intent: INIntent { get }
    var interactionIdentifier: String? { get }
}


@objc protocol YRSiriRecordPresenterDelegate: class {
    func recordedAndDonated()
    func intentRecordingCancelled()
}


class SiriRecordPresenter: NSObject, SiriUIPresentable {
    
    // MARK:- properties
    internal lazy var siriController: INUIAddVoiceShortcutViewController? = {
        guard let shortCut = INShortcut(intent: self.intent) else { return nil }
        let siriRecordController = INUIAddVoiceShortcutViewController.init(shortcut: shortCut)
        siriRecordController.delegate = self
        return siriRecordController
        
    }()
    
    weak var delegate: YRSiriRecordPresenterDelegate?
    internal var intent: INIntent
    internal var interactionIdentifier: String?
    private var presenterViewController: UIViewController
    
    
    // MARK:- Life cycle
    
    init(intent: INIntent, viewController: UIViewController, interactionIdentifier: String?) {
        self.intent = intent
        self.presenterViewController = viewController
        self.interactionIdentifier = interactionIdentifier
    }
    
    // MARK:- Private
    private func donate(intent: INIntent) {
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.groupIdentifier = self.interactionIdentifier
        interaction.donate { error in
            if let _ = error {
                // do something with the error.
            }
        }
    }
    
    // MARK:- Public
    
    @objc func presentSiriRecordController() {        
        guard let siriController = self.siriController else { fatalError() }
        presenterViewController.present(siriController, animated: true, completion: nil)
    }
    
    // MARK:- INUIAddVoiceShortcutViewControllerDelegate
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        self.siriController?.dismiss(animated: true, completion: {
            self.donate(intent: self.intent)
            self.delegate?.recordedAndDonated()
        })
    }
    
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        self.siriController?.dismiss(animated: true, completion: {
            self.delegate?.intentRecordingCancelled()
        })
    }
}
