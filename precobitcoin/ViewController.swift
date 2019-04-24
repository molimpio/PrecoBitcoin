//
//  ViewController.swift
//  precobitcoin
//
//  Created by Moises on 23/04/19.
//  Copyright © 2019 Moises. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://blockchain.info/pt/ticker") {
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, response, error) in
                
                if error == nil {
                    print("sucesso na requisicao")
                } else {
                    print("erro na requisicao")
                }
            }
            tarefa.resume()
        }
        
    }


}

