//
//  ViewController.swift
//  TableViews
//
//  Created by Brais Moure.
//  Copyright © 2020 MoureDev. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var myCountries:[Pais]?
    
    //private let myCountries = ["España", "Mexico", "Perú", "Colombia", "Argentina", "EEUU", "Francia", "Italia"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        recuperarDatos()

        
    }

    @IBAction func add(_ sender: Any) {
        print("Añadir Datos")
        
        let alert =  UIAlertController(title: "ADD PAÍS", message: "NUEVO PAÍS", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let botonAlerta = UIAlertAction(title: "ADD", style: .default){
            (action) in
            
            let textField = alert.textFields![0]
            
            let nuevoPais = Pais(context: self.context)
            nuevoPais.nombre = textField.text
            
            try! self.context.save()
            
            self.recuperarDatos()
        }
        alert.addAction(botonAlerta)
        self.present(alert, animated: true, completion: nil)
    }
    
    func recuperarDatos(){
        do{
            self.myCountries = try context.fetch(Pais.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }catch{
            print("Error al recuperar datos")
        }
    }
    
}




// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCountries!.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accionEliminar = UIContextualAction(style: .destructive, title: "Eliminar") { (action, view, completionHandler) in
            
            let paisEliminar = self.myCountries![indexPath.row]
            
            self.context.delete(paisEliminar)
            try! self.context.save();
            
            self.recuperarDatos()
        }
        return UISwipeActionsConfiguration(actions: [accionEliminar])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
            if cell == nil {
               
                cell = UITableViewCell(style: .default, reuseIdentifier: "mycell")
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 20)
                
            }
        cell!.textLabel?.text = myCountries![indexPath.row].nombre
            return cell!
       
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let paisEditar = self.myCountries![indexPath.row]
        
        let alert = UIAlertController(title: "EDIT", message: "Editar País", preferredStyle: .alert)
        alert.addTextField()
        
        let textField = alert.textFields![0]
        
        textField.text = paisEditar.nombre
        
        let botonAlerta = UIAlertAction(title: "EDIT", style: .default){ (action) in
            
            let textField = alert.textFields![0]
            
            paisEditar.nombre = textField.text
            
        try!    self.context.save()
            self.recuperarDatos()
            
        }
        
        alert.addAction(botonAlerta)
        self.present(alert, animated: true, completion: nil)
    }
    
}

