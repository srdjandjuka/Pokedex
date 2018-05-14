//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Srdjan Djukanovic on 5/6/18.
//  Copyright © 2018 Srdjan Djukanovic. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon : Pokemon!
    
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var pokedexIDLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var firstEvolution: UIImageView!
    @IBOutlet weak var secondEvolution: UIImageView!
    @IBOutlet weak var evolutionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemon?.downloadPokemonDetails {
            self.updateUI()
        }
        
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func updateUI() {
        let img = UIImage(named : "\(pokemon.pokedexId)")
        mainImage.image = img
        firstEvolution.image = img
        nameLabel.text = pokemon.name.capitalized
        typeLbl.text = pokemon.type
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        pokedexIDLbl.text = "\(pokemon.pokedexId)"
        evolutionLbl.text = "Next Evolution: \(pokemon.nextEvolutionName)"
        secondEvolution.image = UIImage(named : pokemon.nextEvolutionId)
    }
}
