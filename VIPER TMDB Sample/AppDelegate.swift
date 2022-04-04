//
//  AppDelegate.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 28/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        do {
            try Network.reachability = Reachability(hostname: "uol.com.br")
        }
        catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Erro de rede:\nFalha ao criar o objeto de acessibilidade com o hostname:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Erro de rede:\nFalha ao inicializar o objeto de acessibilidade com endereço:", address)
            case .failedToSetCallout?:
                print("Erro de rede:'\nFalha ao definir a callout")
            case .failedToSetDispatchQueue?:
                print("Erro de rede:\nFalha ao definir DispatchQueue")
            case .none:
                print(error)
            }
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

