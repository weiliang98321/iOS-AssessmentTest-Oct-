//
//  MatchCandidateViewController.swift
//  NextAcademy - iOS Assessment Test(Tan Wei Liang)
//
//  Created by Tan Wei Liang on 03/10/2017.
//  Copyright © 2017 Tan Wei Liang. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SDWebImage

class MatchCandidateViewController: UIViewController {
   
    
    var selectedContact : Contact?
    var users : [Contact] = []
    var ref: DatabaseReference!
    var userId : String = ""
    
    
    @IBOutlet weak var profileTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        profileTableView.dataSource = self
        self.profileTableView.reloadData()
        
        fetchUser()
        
       
    }
    
    

    
    func fetchUser() {
        
        ref = Database.database().reference()
       
        ref.child("Users").observe(.childAdded, with: { (snapshot) in
            
            guard let info = snapshot.value as? [String : Any] else {return}
            
            if let name = info["name"] as? String,
                let age = info["age"] as? String,
                let email = info["email"] as? String,
                let gender = info["gender"] as? String,
                let description = info["description"] as? String,
                let imageURL = info["profileImageURL"] as? String {
                
                let newContact = Contact(anID: snapshot.key, aName: name, anAge: age, aGender: gender, anEmail: email, aDescription: description, anImageURL: imageURL)
                
                self.selectedContact = newContact
              //  self.profileImageView.sd_setImage(with: URL(string: imageURL))
                
                print(newContact)
                
                //append to contact array
                self.users.append(newContact)
                
                
                let  index = self.users.count - 1
                let indexPath = IndexPath(row: index, section: 0)
                self.profileTableView.insertRows(at: [indexPath], with: .right)

                
                            }
        })
        ref.child("Users").observe(.value, with: { (snapshot) in
            guard let info = snapshot.value as? [String : Any]
                else { return }
            
            print (info)
        })
        
        ref.child("Users").observe(.childRemoved, with: { (snapshot) in
            guard let info = snapshot.value as? [String : Any ] else { return }
            print(info)
            
            let deletedID = snapshot.key
            
            
            //filters through post returns index(deletedIndex) where Boolean condition is fulfilled
            if let deletedIndex = self.users.index(where: { (student) -> Bool in
                return student.id == deletedID
            }) {
                //remove post when deletedIndex is found
                self.users.remove(at: deletedIndex)
                let indexPath = IndexPath(row: deletedIndex, section: 0)
                
                self.profileTableView.deleteRows(at: [indexPath], with: .fade)
            }
        })
    
        ref.child("Users").observe(.childChanged, with: { (snapshot) in
            guard let info = snapshot.value as? [String:Any] else {return}
            guard let name = info["name"] as? String,
                let age = info["age"] as? String,
                let email = info["email"] as? String,
                let gender = info["gender"] as? String,
                let description = info["description"] as? String,
                let imageURL = info["profileImageURL"] as? String else {return }
    
            if let matchedIndex = self.users.index(where: { (user) -> Bool in
                return user.id == snapshot.key
            }) {
                let changedUser = self.users[matchedIndex]
                changedUser.name = name
                changedUser.age = age
                changedUser.imageURL = imageURL
                changedUser.gender = gender
                
                
                //var image = profileTableView.sd_setImage(with: URL(string: imageURL))
                
                
                
                let indexPath = IndexPath(row: matchedIndex, section: 0)
                self.profileTableView.reloadRows(at: [indexPath], with: .none)
            }
        })

    
    
    
    }
    
    

}

extension MatchCandidateViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as?
            MatchCandidateTableViewCell
            else { return UITableViewCell() }
        
        cell.ageLabel.text = users[indexPath.row].age
        cell.nameLabel.text = users[indexPath.row].name

       cell.genderLabel.text = users[indexPath.row].gender
        
        return cell
    }
    
    func loadImage(urlString: String) {
        //1.url
        //2.session
        //3.task
        //4.start
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                  
                    //cell.profileImageView.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }
}


