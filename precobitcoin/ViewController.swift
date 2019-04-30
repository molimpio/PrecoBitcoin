//
//  ViewController.swift
//  precobitcoin
//
//  Created by Moises on 23/04/19.
//  Copyright © 2019 Moises. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var precoBitcoin: UILabel!
    @IBOutlet weak var btnAtualizar: UIButton!
    @IBAction func atualizarPreco(_ sender: Any) {
        self.getPrecoBitcoin()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.getPrecoBitcoin()
    }
    
    func formatPreco(preco: NSNumber) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let precoFormat = nf.string(from: preco) {
            return precoFormat
        }
        
        return "0,00"
    }
    
    func getPrecoBitcoin() {
        self.btnAtualizar.setTitle("Atualizando...", for:  .normal)
        
        if let url = URL(string: "https://blockchain.info/pt/ticker") {
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, resquest, error) in
                
                if error == nil {
                    
                    if let dadosResponse = dados {
                        
                        do {
                            if let objJSON = try JSONSerialization.jsonObject(with: dadosResponse, options: []) as? [String: Any] {
                                if let brl = objJSON["BRL"] as? [String: Any]  {
                                    if let precoCompra = brl["buy"] as? Double {
                                        let precoFormat = self.formatPreco(preco: NSNumber(value: precoCompra))
                                        
                                        DispatchQueue.main.async(execute: {
                                            self.precoBitcoin.text = "R$ " + precoFormat
                                            self.btnAtualizar.setTitle("Atualizar", for:  .normal)
                                        })
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

