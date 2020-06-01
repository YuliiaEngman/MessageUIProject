//
//  ViewController.swift
//  Emai&MessageProject
//
//  Created by Yuliia Engman on 6/1/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func contactAction(_ sender: UIButton) {
                   let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                   let emailAction = UIAlertAction(title: "Send an e-mail", style: .default) { (alertAction) in
                       self.showMailComposer()
                   }
                   let messageAction = UIAlertAction(title: "Send a message", style: .default) { (alertAction) in
                       self.showMessageComposer()
                   }
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        emailAction.setValue(UIColor.blue, forKey: "titleTextColor")
               messageAction.setValue(UIColor.blue, forKey: "titleTextColor")
               cancelAction.setValue(UIColor.black, forKey: "titleTextColor")
                   actionSheet.addAction(emailAction)
                   actionSheet.addAction(messageAction)
               actionSheet.addAction(cancelAction)
                   present(actionSheet, animated: true)
    }
    
    private func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            //show alert
            DispatchQueue.main.async {
                self.showAlert(title: "Device Error", message: "Your device cannot send e-mails")
            }
            return }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["yuliiaengman@pursuit.org"])
        composer.setSubject("Interested in renting your space")
        composer.setMessageBody("I would like to purchase the item listed", isHTML: false)
        present(composer, animated: true)
    }
    
    private func showMessageComposer() {
        
        if !MFMessageComposeViewController.canSendText() {
            DispatchQueue.main.async {
                self.showAlert(title: "Device Error", message: "Your device cannot send e-mails")
            }
        }
        
        let messageComposer = MFMessageComposeViewController()
        messageComposer.body = "Hi! I'm interested in the space that you're renting."
        messageComposer.recipients = ["3475523235"]
        messageComposer.messageComposeDelegate = self
        
        present(messageComposer, animated: true)
    }
    
}

extension ViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch result {
        case .cancelled:
            print("cancelled message")
            dismiss(animated: true)
        case .failed:
            print("message failed to send")
            dismiss(animated: true)
        case .sent:
            print("message sent")
            dismiss(animated: true)
        default:
            print("default")
        }
    }
    
    
}

extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            controller.dismiss(animated: true)
        }

        switch result {
        case .cancelled:
            print("cancelled email")
        case .failed:
            print("failed to send email")
        case .saved:
            print("saved email")
        case .sent:
            print("email sent!")
        default:
            print("default ")
            controller.dismiss(animated: true)
        }
        
        controller.dismiss(animated: true)
    }
}

extension ViewController {
    public func showAlert(title: String?, message: String?) {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
      alertController.addAction(okAction)
      present(alertController, animated: true)
    }
}

