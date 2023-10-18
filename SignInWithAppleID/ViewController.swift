//
//  ViewController.swift
//  SignInWithAppleID
//
//  Created by Neosoft on 18/10/23.
//
import AuthenticationServices
import UIKit

class ViewController: UIViewController {

    private let signInButton = ASAuthorizationAppleIDButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        signInButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50 )
        signInButton.center = view.center
    }

    @objc func loginBtnTapped(){
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName , .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

}

extension ViewController : ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential{
        case let credential as ASAuthorizationAppleIDCredential:
            let firsname = credential.fullName?.givenName
            let lastname = credential.fullName?.familyName
            let email = credential.email
            print("sign is done succesfully")
            break
        default:
            break
        }
    }
}

extension ViewController : ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
