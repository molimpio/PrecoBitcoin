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
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, resquest, error) in
                
                if error == nil {
                    
                    if let dadosResponse = dados {
                        
                        do {
                            if let objJSON = try JSONSerialization.jsonObject(with: dadosResponse, options: []) as? [String: Any] {
                                if let brl = objJSON["BRL"] as? [String: Any]  {
                                    if let precoCompra = brl["buy"] as? Double {
                                        print(precoCompra)
                                    }
                                }
                            }
                            
                        } catch {
                            print("Erro ao formatar retorno")
                        }
                    }
                } else {
                    print("erro na requisicao")
                }
            }
            tarefa.resume()
        }
        
    }


}

