//


// Optional protocol and protocol extension explained Swift.
// 1. Optional protocols.
// 2. Extensions in protocols.
// **. All functions/methods in a protocol are required by default.

import Foundation

protocol Taxable
{
    func calculateTax()
    optional func printTaxInfo()
}

struct Invoice: Taxable
{
    func calculateTax() {
        debugPrint("Calculate invoice tax")
    }
    
    func printTaxInfo() {
        debugPrint("printing tax information")
    }
    
    
}

// 'optional' can only be applied to members of an @objc protocol

_________________________________________________________________________________________________________________________________________________________

// Optional protocol and protocol extension explained Swift.
// 1. Optional protocols.
// 2. Extensions in protocols.
// **. All functions/methods in a protocol are required by default.

import Foundation

@objc protocol Taxable
{
    func calculateTax()
    optional func printTaxInfo()
}

struct Invoice: Taxable
{
    func calculateTax() {
        debugPrint("Calculate invoice tax")
    }
    
    func printTaxInfo() {
        debugPrint("printing tax information")
    }
    
    
}

// error: MySwiftOrg.playground:11:5: error: 'optional' requirements are an Objective-C compatibility feature; add '@objc'
//    optional func printTaxInfo()
//    ^
//    @objc
//
// error: MySwiftOrg.playground:14:8: error: non-class type 'Invoice' cannot conform to class protocol 'Taxable'
//  struct Invoice: Taxable
//       ^
//

________________________________________________________________________________________________________________________________________________________

// Optional protocol and protocol extension explained Swift.
// 1. Optional protocols.
// 2. Extensions in protocols.
// **. All functions/methods in a protocol are required by default.

import Foundation

@objc protocol Taxable
{
    func calculateTax()
    @objc optional func printTaxInfo()
}

class Invoice: Taxable
{
    func calculateTax() {
        debugPrint("Calculate invoice tax")
    }
}

let objClass = Invoice()
objClass.calculateTax()

// "Calculate invoice tax"

__________________________________________________________________________________________________________________________________________________________

// Optional protocol and protocol extension explained Swift.
// 1. Optional protocols.
// 2. Extensions in protocols.
// **. All functions/methods in a protocol are required by default.

import Foundation

@objc protocol Taxable
{
    func calculateTax()
    @objc optional func printTaxInfo()
}

class Invoice: Taxable
{
    func calculateTax() {
        debugPrint("Calculate invoice tax")
    }
}

let objClass = Invoice()
objClass.printTaxInfo?()

// error: MySwiftOrg.playground:22:10: error: value of type 'Invoice' has no member 'printTaxInfo'
// objClass.printTaxInfo?()
//  ~~~~~~~~ ^~~~~~~~~~~~

________________________________________________________________________________________________________________________________________________________

// Optional protocol and protocol extension explained Swift.
// 1. Optional protocols.
// 2. Extensions in protocols.
// **. All functions/methods in a protocol are required by default.

// and restrictions on using value types in Swift now there is a way to overcome this restrictions by using protocol extensions in Swift.

import Foundation

 protocol Taxable
{
    func calculateTax()
}

extension Taxable
{
    func printTaxInfo()
    {
        debugPrint("Print tax info")
    }
}

class Invoice: Taxable
{
    func calculateTax() {
        debugPrint("Calculate invoice tax")
    }
}

let objClass = Invoice()
objClass.printTaxInfo()

// "Print tax info"

_______________________________________________________________________________________________________________________________________________________


// Optional protocol and protocol extension explained Swift.
// 1. Optional protocols.
// 2. Extensions in protocols.
// **. All functions/methods in a protocol are required by default.

// and restrictions on using value types in Swift now there is a way to overcome this restrictions by using protocol extensions in Swift.

// so now with protocol extension I can implement this protocol on class and structure Both.
import Foundation

 protocol Taxable
{
    func calculateTax()
}

extension Taxable
{
    func printTaxInfo()
    {
        debugPrint("Print tax info")
    }
}

struct Invoice: Taxable
{
    func calculateTax() {
        debugPrint("Calculate invoice tax")
    }
}

let objClass = Invoice()
objClass.printTaxInfo()

// "Print tax info"

___________________________________________________________________________________________________________________________________________________________

// Observer
// https://www.youtube.com/watch?v=44kEzzyf7Hk

// Observer pattern in swift

import Foundation
import UIKit

struct TrafficColor
{
    static let red = "red"
    static let green = "green"
    static let yellow = "yellow"
}

protocol ObserverProtocol
{
    func onTrafficLightColorChange(_color: String)
}

class VehicleObserver : ObserverProtocol
{
    func onTrafficLightColorChange(_color: String)
    {
        if(_color == TrafficColor.red)
        {
            debugPrint("stop my vehicle")
        }
        if(_color == TrafficColor.green)
        {
            debugPrint("start my vehicle")
        }
        if(_color == TrafficColor.yellow)
        {
            debugPrint("slow down the speed of my vehicle")
        }
    }
}
 
class VendorObserver : ObserverProtocol
{
    func onTrafficLightColorChange(_color: String)
       {
           if(_color == TrafficColor.red)
           {
               debugPrint("Vendor: Start selling products")
           }
           if(_color == TrafficColor.green)
           {
               debugPrint("Vendor: Move aside from the traffic")
           }
           
       }
}

class TrafficLightSubject
{
    private var _color = String()
    
    var trafficLightColor: String
    {
        get
        {
            return _color
        }
        set
        {
            _color = newValue
            notifyObserver()
        }
    }
    
    private var trafficVehicleObserver = [ObserverProtocol]()
    
    func addObserver(_observer: ObserverProtocol)
    {
        trafficVehicleObserver.append(_observer)
    }
    
    private func notifyObserver()
    {
        trafficVehicleObserver.forEach({$0.onTrafficLightColorChange(_color: _color)})
    }
    
    deinit {
        trafficVehicleObserver.removeAll()
    }
}

let trafficLightSubject = TrafficLightSubject()
let vehicleObserver = VehicleObserver()
let vendorObserver = VendorObserver()

trafficLightSubject.addObserver(_observer: vehicleObserver)
trafficLightSubject.addObserver(_observer: vendorObserver)

trafficLightSubject.trafficLightColor = TrafficColor.red

// "stop my vehicle"
// "Vendor: Start selling products"

___________________________________________________________________________________________________________________________________________________________

// Observer pattern in swift

import Foundation
import UIKit

struct TrafficColor
{
    static let red = "red"
    static let green = "green"
    static let yellow = "yellow"
}

protocol ObserverProtocol
{
    var Id: Int {get set}
    func onTrafficLightColorChange(_color: String)
}

class VehicleObserver : ObserverProtocol
{
    var Id: Int
    
    init(_Id: Int) {
        Id = _Id
    }
    
    func onTrafficLightColorChange(_color: String)
    {
        if(_color == TrafficColor.red)
        {
            debugPrint("stop my vehicle")
        }
        if(_color == TrafficColor.green)
        {
            debugPrint("start my vehicle")
        }
        if(_color == TrafficColor.yellow)
        {
            debugPrint("slow down the speed of my vehicle")
        }
    }
}
 
class VendorObserver : ObserverProtocol
{
    var Id: Int
    
    init(_Id: Int) {
        Id = _Id
    }
    func onTrafficLightColorChange(_color: String)
       {
           if(_color == TrafficColor.red)
           {
               debugPrint("Vendor: Start selling products")
           }
           if(_color == TrafficColor.green)
           {
               debugPrint("Vendor: Move aside from the traffic")
           }
           
       }
}

class TrafficLightSubject
{
    private var _color = String()
    
    var trafficLightColor: String
    {
        get
        {
            return _color
        }
        set
        {
            _color = newValue
            notifyObserver()
        }
    }
    
    private var trafficObserver = [ObserverProtocol]()
    
    func addObserver(_observer: ObserverProtocol)
    {
        guard trafficObserver.contains(where: {$0.Id == _observer.Id}) == false else {
            return
        }
        trafficObserver.append(_observer)
    }
    
    func removeObserver(_observer: ObserverProtocol)
    {
        trafficObserver = trafficObserver.filter({$0.Id != _observer.Id})
    }
    
    private func notifyObserver()
    {
        trafficObserver.forEach({$0.onTrafficLightColorChange(_color: _color)})
    }
    
    deinit {
        trafficObserver.removeAll()
    }
}

let trafficLightSubject = TrafficLightSubject()
let vehicleObserver = VehicleObserver(_Id: 1)
let vendorObserver = VendorObserver(_Id: 2)

trafficLightSubject.addObserver(_observer: vehicleObserver)
trafficLightSubject.addObserver(_observer: vendorObserver)

trafficLightSubject.trafficLightColor = TrafficColor.red

trafficLightSubject.removeObserver(_observer: vendorObserver)

trafficLightSubject.trafficLightColor = TrafficColor.green


// "stop my vehicle"
// "Vendor: Start selling products"
// "start my vehicle"


___________________________________________________________________________________________________________________________________________________________



//  CallbacksThreading
// callback functions (completion handlers)

___________________________________________________________________________________________________________________________________________________

// Without using callback functions (completion handlers) — PART - I

// someJSON.txt

[
{
"id": 1,
"name": "Leanne Graham",
"username": "Bret",
"email": "Sincere@april.biz",
"address": {
"street": "Kulas Light",
"suite": "Apt. 556",
"city": "Gwenborough",
"zipcode": "92998-3874",
"geo": {
"lat": "-37.3159",
"lng": "81.1496"
}
},
"phone": "1-770-736-8031 x56442",
"website": "hildegard.org",
"company": {
"name": "Romaguera-Crona",
"catchPhrase": "Multi-layered client-server neural-net",
"bs": "harness real-time e-markets"
}
},
{
"id": 2,
"name": "Ervin Howell",
"username": "Antonette",
"email": "Shanna@melissa.tv",
"address": {
"street": "Victor Plains",
"suite": "Suite 879",
"city": "Wisokyburgh",
"zipcode": "90566-7771",
"geo": {
"lat": "-43.9509",
"lng": "-34.4618"
}
},
"phone": "010-692-6593 x09125",
"website": "anastasia.net",
"company": {
"name": "Deckow-Crist",
"catchPhrase": "Proactive didactic contingency",
"bs": "synergize scalable supply-chains"
}
},
{
"id": 3,
"name": "Clementine Bauch",
"username": "Samantha",
"email": "Nathan@yesenia.net",
"address": {
"street": "Douglas Extension",
"suite": "Suite 847",
"city": "McKenziehaven",
"zipcode": "59590-4157",
"geo": {
"lat": "-68.6102",
"lng": "-47.0653"
}
},
"phone": "1-463-123-4447",
"website": "ramiro.info",
"company": {
"name": "Romaguera-Jacobson",
"catchPhrase": "Face to face bifurcated interface",
"bs": "e-enable strategic applications"
}
},
{
"id": 4,
"name": "Patricia Lebsack",
"username": "Karianne",
"email": "Julianne.OConner@kory.org",
"address": {
"street": "Hoeger Mall",
"suite": "Apt. 692",
"city": "South Elvis",
"zipcode": "53919-4257",
"geo": {
"lat": "29.4572",
"lng": "-164.2990"
}
},
"phone": "493-170-9623 x156",
"website": "kale.biz",
"company": {
"name": "Robel-Corkery",
"catchPhrase": "Multi-tiered zero tolerance productivity",
"bs": "transition cutting-edge web services"
}
},
{
"id": 5,
"name": "Chelsey Dietrich",
"username": "Kamren",
"email": "Lucio_Hettinger@annie.ca",
"address": {
"street": "Skiles Walks",
"suite": "Suite 351",
"city": "Roscoeview",
"zipcode": "33263",
"geo": {
"lat": "-31.8129",
"lng": "62.5342"
}
},
"phone": "(254)954-1289",
"website": "demarco.info",
"company": {
"name": "Keebler LLC",
"catchPhrase": "User-centric fault-tolerant solution",
"bs": "revolutionize end-to-end systems"
}
},
{
"id": 6,
"name": "Mrs. Dennis Schulist",
"username": "Leopoldo_Corkery",
"email": "Karley_Dach@jasper.info",
"address": {
"street": "Norberto Crossing",
"suite": "Apt. 950",
"city": "South Christy",
"zipcode": "23505-1337",
"geo": {
"lat": "-71.4197",
"lng": "71.7478"
}
},
"phone": "1-477-935-8478 x6430",
"website": "ola.org",
"company": {
"name": "Considine-Lockman",
"catchPhrase": "Synchronised bottom-line interface",
"bs": "e-enable innovative applications"
}
},
{
"id": 7,
"name": "Kurtis Weissnat",
"username": "Elwyn.Skiles",
"email": "Telly.Hoeger@billy.biz",
"address": {
"street": "Rex Trail",
"suite": "Suite 280",
"city": "Howemouth",
"zipcode": "58804-1099",
"geo": {
"lat": "24.8918",
"lng": "21.8984"
}
},
"phone": "210.067.6132",
"website": "elvis.io",
"company": {
"name": "Johns Group",
"catchPhrase": "Configurable multimedia task-force",
"bs": "generate enterprise e-tailers"
}
},
{
"id": 8,
"name": "Nicholas Runolfsdottir V",
"username": "Maxime_Nienow",
"email": "Sherwood@rosamond.me",
"address": {
"street": "Ellsworth Summit",
"suite": "Suite 729",
"city": "Aliyaview",
"zipcode": "45169",
"geo": {
"lat": "-14.3990",
"lng": "-120.7677"
}
},
"phone": "586.493.6943 x140",
"website": "jacynthe.com",
"company": {
"name": "Abernathy Group",
"catchPhrase": "Implemented secondary concept",
"bs": "e-enable extensible e-tailers"
}
},
{
"id": 9,
"name": "Glenna Reichert",
"username": "Delphine",
"email": "Chaim_McDermott@dana.io",
"address": {
"street": "Dayna Park",
"suite": "Suite 449",
"city": "Bartholomebury",
"zipcode": "76495-3109",
"geo": {
"lat": "24.6463",
"lng": "-168.8889"
}
},
"phone": "(775)976-6794 x41206",
"website": "conrad.com",
"company": {
"name": "Yost and Sons",
"catchPhrase": "Switchable contextually-based project",
"bs": "aggregate real-time technologies"
}
},
{
"id": 10,
"name": "Clementina DuBuque",
"username": "Moriah.Stanton",
"email": "Rey.Padberg@karina.biz",
"address": {
"street": "Kattie Turnpike",
"suite": "Suite 198",
"city": "Lebsackbury",
"zipcode": "31428-2261",
"geo": {
"lat": "-38.2386",
"lng": "57.2232"
}
},
"phone": "024-648-3804",
"website": "ambrose.net",
"company": {
"name": "Hoeger LLC",
"catchPhrase": "Centralized empowering task-force",
"bs": "target end-to-end models"
}
}
]


              _____________________________________________________________________________________________________________________________________


//  ViewController.swift
//  CallbacksThreading
//
//  Created by SHRAVAN TEEGALA on 04/01/21.
//  Copyright © 2021 SHRAVAN TEEGALA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userNames = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getUsers()
    }
    
    func getUsers() {
        guard let path = Bundle.main.path(forResource: "someJSON", ofType: "txt") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [[String: Any]] else { return }
            var names = [String]()
            for user in array {
                guard let name = user["name"] as? String else { continue }
                names.append(name)
            }
            print(names)
        } catch {
            print(error)
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = userNames[indexPath.row]
        return cell
    }
    
}

// output:

// [“Leanne Graham", "Ervin Howell", "Clementine Bauch", "Patricia Lebsack", "Chelsey Dietrich", "Mrs. Dennis Schulist", "Kurtis Weissnat", "Nicholas Runolfsdottir V", "Glenna Reichert", "Clementina DuBuque"]



____________________________________________________________________________________________________________________________________________________________

 // Using callback functions (completion handlers) — PART - II

//
//  ViewController.swift
//  CallbacksThreading
//
//  Created by SHRAVAN TEEGALA on 04/01/21.
//  Copyright © 2021 SHRAVAN TEEGALA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userNames = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        getUsers()
        getUsers {
            print("HELLO WORLD")
        }
        
    }
    
    func getUsers(completion: () -> Void) {
        guard let path = Bundle.main.path(forResource: "someJSON", ofType: "txt") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [[String: Any]] else { return }
            var names = [String]()
            for user in array {
                guard let name = user["name"] as? String else { continue }
                names.append(name)
            }
            print("Rama 1")
            print("Rama 2")
            completion()
           // print(names)
            print("After End ")
        } catch {
            print(error)
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = userNames[indexPath.row]
        return cell
    }
    
}


// Rama 1
// Rama 2
// HELLO WORLD
// After End

_________________________________________________________________________________________________________________________________________________________

 // Using callback functions (completion handlers) — PART - III

// https://www.youtube.com/watch?v=YqhvVyiEpI0&feature=youtu.be
//  ViewController.swift
//  CallbacksThreading
//
//  Created by SHRAVAN TEEGALA on 04/01/21.
//  Copyright © 2021 SHRAVAN TEEGALA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userNames = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        getUsers()
        getUsers {
            print("HELLO WORLD")
        }
        
    }
    
    func getUsers(completion: () -> Void) {
        guard let path = Bundle.main.path(forResource: "someJSON", ofType: "txt") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [[String: Any]] else { return }
            var names = [String]()
            for user in array {
                guard let name = user["name"] as? String else { continue }
                names.append(name)
            }
            completion()
           // print(names)
            
        } catch {
            print(error)
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = userNames[indexPath.row]
        return cell
    }
    
}


// HELLO WORLD


____________________________________________________________________________________________________________________________________________________________

// Using callback functions (completion handlers) — PART - IV

//
//  ViewController.swift
//  CallbacksThreading
//
//  Created by SHRAVAN TEEGALA on 04/01/21.
//  Copyright © 2021 SHRAVAN TEEGALA. All rights reserved.
//
// https://www.youtube.com/watch?v=YqhvVyiEpI0&feature=youtu.be

import UIKit

class ViewController: UIViewController {

    var userNames = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        getUsers()
//        getUsers {
//            print("HELLO WORLD")
//        }
        getUsers { (success, response, error) in
            if success {
                guard let names = response as? [String] else { return }
                print(names)
            } else if let error = error {
                print(error)
            }
        }
        
    }
    
    func getUsers(completion: (Bool, Any?, Error?) -> Void) {
        guard let path = Bundle.main.path(forResource: "someJSON", ofType: "txt") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [[String: Any]] else { return }
            var names = [String]()
            for user in array {
                guard let name = user["name"] as? String else { continue }
                names.append(name)
            }
           completion(true, names, nil)
           // print(names)
            
        } catch {
            print(error)
            completion(false, nil, error)
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = userNames[indexPath.row]
        return cell
    }
    
}

// ["Leanne Graham", "Ervin Howell", "Clementine Bauch", "Patricia Lebsack", "Chelsey Dietrich", "Mrs. Dennis Schulist", "Kurtis Weissnat", "Nicholas Runolfsdottir V", "Glenna Reichert", "Clementina DuBuque"]


___________________________________________________________________________________________________________________________________________________________

// // Using callback functions (completion handlers) — PART - V

//
//  ViewController.swift
//  CallbacksThreading
//
//  Created by SHRAVAN TEEGALA on 04/01/21.
//  Copyright © 2021 SHRAVAN TEEGALA. All rights reserved.
//
// https://www.youtube.com/watch?v=YqhvVyiEpI0&feature=youtu.be

import UIKit

class ViewController: UIViewController {

    var userNames = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        getUsers()
//        getUsers {
//            print("HELLO WORLD")
//        }
        getUsers { (success, response, error) in
            if success {
                guard let names = response as? [String] else { return }
                print(names)
            } else if let error = error {
                print(error)
            }
        }
        
    }
    
    func getUsers(completion: (Bool, Any?, Error?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            
        guard let path = Bundle.main.path(forResource: "someJSON", ofType: "txt") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [[String: Any]] else { return }
            var names = [String]()
            for user in array {
                guard let name = user["name"] as? String else { continue }
                names.append(name)
            }
           completion(true, names, nil)
           // print(names)
            
        } catch {
            print(error)
            completion(false, nil, error)
        }
    }
  }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = userNames[indexPath.row]
        return cell
    }
    
}

//error: Escaping closure captures non-escaping parameter 'completion'

__________________________________________________________________________________________________________________________________________________________
// // Using callback functions (completion handlers) — PART - VI

//
//  ViewController.swift
//  CallbacksThreading
//
//  Created by SHRAVAN TEEGALA on 04/01/21.
//  Copyright © 2021 SHRAVAN TEEGALA. All rights reserved.
//
// https://www.youtube.com/watch?v=YqhvVyiEpI0&feature=youtu.be

import UIKit

class ViewController: UIViewController {

    var userNames = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        getUsers()
//        getUsers {
//            print("HELLO WORLD")
//        }
        getUsers { (success, response, error) in
            if success {
                guard let names = response as? [String] else { return }
                print(names)
            } else if let error = error {
                print(error)
            }
        }
        
    }
    
    func getUsers(completion: @escaping (Bool, Any?, Error?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            
        guard let path = Bundle.main.path(forResource: "someJSON", ofType: "txt") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [[String: Any]] else { return }
            var names = [String]()
            for user in array {
                guard let name = user["name"] as? String else { continue }
                names.append(name)
            }
           completion(true, names, nil)
           // print(names)
            
        } catch {
            print(error)
            completion(false, nil, error)
        }
    }
  }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = userNames[indexPath.row]
        return cell
    }
    
}

// ["Leanne Graham", "Ervin Howell", "Clementine Bauch", "Patricia Lebsack", "Chelsey Dietrich", "Mrs. Dennis Schulist", "Kurtis Weissnat", "Nicholas Runolfsdottir V", "Glenna Reichert", "Clementina DuBuque"]


_______________________________________________________________________________________________________________________________________________________

// Using callback functions (completion handlers) — PART - VII

//
//  ViewController.swift
//  CallbacksThreading
//
//  Created by SHRAVAN TEEGALA on 04/01/21.
//  Copyright © 2021 SHRAVAN TEEGALA. All rights reserved.
//
// https://www.youtube.com/watch?v=YqhvVyiEpI0&feature=youtu.be

import UIKit

class ViewController: UIViewController {

    var userNames = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        getUsers()
//        getUsers {
//            print("HELLO WORLD")
//        }
        getUsers { (success, response, error) in
            if success {
                print("GET USERS BLOCK CALLED")
                guard let names = response as? [String] else { return }
                self.userNames = names
                self.tableView.reloadData()
                print("RELOAD CALLED")
            } else if let error = error {
                print(error)
            }
        }
        
    }
    
    func getUsers(completion: @escaping (Bool, Any?, Error?) -> Void) {
        print("GET USERS FUNCTION")
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
           print("DISPATCH FINISHED")
        guard let path = Bundle.main.path(forResource: "someJSON", ofType: "txt") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [[String: Any]] else { return }
            var names = [String]()
            for user in array {
                guard let name = user["name"] as? String else { continue }
                names.append(name)
            }
           completion(true, names, nil)
           // print(names)
            
        } catch {
            print(error)
            completion(false, nil, error)
        }
    }
  }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = userNames[indexPath.row]
        return cell
    }
    
}

/*

GET USERS FUNCTION
DISPATCH FINISHED
GET USERS BLOCK CALLED
=================================================================
Main Thread Checker: UI API called on a background thread: -[UITableView reloadData]
PID: 3302, TID: 146347, Thread name: (none), Queue name: com.apple.root.default-qos, QoS: 0
Backtrace:
4   CallbacksThreading                  0x000000010beec755 $s18CallbacksThreading14ViewControllerC11viewDidLoadyyFySb_ypSgs5Error_pSgtcfU_ + 965
5   CallbacksThreading                  0x000000010beed768 $s18CallbacksThreading14ViewControllerC8getUsers10completionyySb_ypSgs5Error_pSgtc_tFyycfU_ + 2120
6   CallbacksThreading                  0x000000010beede1d $sIeg_IeyB_TR + 45
7   libdispatch.dylib                   0x000000010c21ed48 _dispatch_client_callout + 8
8   libdispatch.dylib                   0x000000010c2216ba _dispatch_continuation_pop + 552
9   libdispatch.dylib                   0x000000010c234a0f _dispatch_source_invoke + 2205
10  libdispatch.dylib                   0x000000010c221016 _dispatch_queue_override_invoke + 549
11  libdispatch.dylib                   0x000000010c23028c _dispatch_root_queue_drain + 351
12  libdispatch.dylib                   0x000000010c230b96 _dispatch_worker_thread2 + 132
13  libsystem_pthread.dylib             0x00007fff524629f7 _pthread_wqthread + 220
14  libsystem_pthread.dylib             0x00007fff52461b77 start_wqthread + 15
2021-01-04 23:23:02.054362+0530 CallbacksThreading[3302:146347] [reports] Main Thread Checker: UI API called on a background thread: -[UITableView reloadData]
PID: 3302, TID: 146347, Thread name: (none), Queue name: com.apple.root.default-qos, QoS: 0
Backtrace:
4   CallbacksThreading                  0x000000010beec755 $s18CallbacksThreading14ViewControllerC11viewDidLoadyyFySb_ypSgs5Error_pSgtcfU_ + 965
5   CallbacksThreading                  0x000000010beed768 $s18CallbacksThreading14ViewControllerC8getUsers10completionyySb_ypSgs5Error_pSgtc_tFyycfU_ + 2120
6   CallbacksThreading                  0x000000010beede1d $sIeg_IeyB_TR + 45
7   libdispatch.dylib                   0x000000010c21ed48 _dispatch_client_callout + 8
8   libdispatch.dylib                   0x000000010c2216ba _dispatch_continuation_pop + 552
9   libdispatch.dylib                   0x000000010c234a0f _dispatch_source_invoke + 2205
10  libdispatch.dylib                   0x000000010c221016 _dispatch_queue_override_invoke + 549
11  libdispatch.dylib                   0x000000010c23028c _dispatch_root_queue_drain + 351
12  libdispatch.dylib                   0x000000010c230b96 _dispatch_worker_thread2 + 132
13  libsystem_pthread.dylib             0x00007fff524629f7 _pthread_wqthread + 220
14  libsystem_pthread.dylib             0x00007fff52461b77 start_wqthread + 15
RELOAD CALLED

*/


____________________________________________________________________________________________________________________________________________________________

// Final Code smooth execution.

//
//  ViewController.swift
//  CallbacksThreading
//
//  Created by SHRAVAN TEEGALA on 04/01/21.
//  Copyright © 2021 SHRAVAN TEEGALA. All rights reserved.
//
// https://www.youtube.com/watch?v=YqhvVyiEpI0&feature=youtu.be

import UIKit

class ViewController: UIViewController {

    var userNames = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        getUsers()
//        getUsers {
//            print("HELLO WORLD")
//        }
        getUsers { (success, response, error) in
            if success {
                print("GET USERS BLOCK CALLED")
                guard let names = response as? [String] else { return }
                self.userNames = names
                self.tableView.reloadData()
                print("RELOAD CALLED")
            } else if let error = error {
                print(error)
            }
        }
        
    }
    
    func getUsers(completion: @escaping (Bool, Any?, Error?) -> Void) {
        print("GET USERS FUNCTION")
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
           print("DISPATCH FINISHED")
        guard let path = Bundle.main.path(forResource: "someJSON", ofType: "txt") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [[String: Any]] else { return }
            var names = [String]()
            for user in array {
                guard let name = user["name"] as? String else { continue }
                names.append(name)
            }
            DispatchQueue.main.async {
                completion(true, names, nil)
            }
           // print(names)
            
        } catch {
            print(error)
            DispatchQueue.main.async {
                completion(false, nil, error)
            }
        }
    }
  }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = userNames[indexPath.row]
        return cell
    }
    
}


// GET USERS FUNCTION
// DISPATCH FINISHED
// GET USERS BLOCK CALLED
// RELOAD CALLED
//


______________________________________________________________________________________________________________________________________________________

// Result Type
// Using Result Type

import UIKit

struct Course: Decodable {
    let id: Int
    let name: String
    let imageUrl: String
    let number_of_lessons: Int
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCoursesJSON { (res) in
            switch res {
            case .success(let courses):
                courses.forEach({ (course) in
                    print(course.name)
                })
            case .failure(let err):
                print("Failed to fetch courses:",err)
            }
        }
        
//        fetchCoursesJSON { (courses, err) in
//            // ambiguous situation here
//
//            if let err = err {
//                print("Failed to fetch courses", err)
//                return
//            }
//
//            courses?.forEach({ (course) in
//                print(course.name)
//            })
//        }
        
    }

    fileprivate func fetchCoursesJSON(completion: @escaping (Result<[Course], Error>) -> ()) {
        
        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            // successful
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data!)
                completion(.success(courses))
               // completion(courses, nil)
            } catch let jsonError {
                completion(.failure(jsonError))
               // completion(nil, jsonError)
            }
            
            
        }.resume()
    }

}


// AppStore JSON APIs
// Tinder Firestore Swipe and Match
// Instagram Firebase
// Podcasts Course
// Intermediate Training Core Data
// Kindle Basic Training

_______________________________________________________________________________________________________________________________

Most Useful (MVC & Networking..)

https://github.com/thebrandontyler/GitHubFollowers

https://www.youtube.com/watch?v=xiS5gJOIQxI

https://github.com/thebrandontyler

______________________________________________________________________________________________________________________________

// Size Classes in Swift 5 | Compact | Regular | in Auto layout | iOS | iPhone| iPad

https://youtu.be/iYPiwwdp8rI


_______________________________________________________________________________________________________________________________

// Trailing Closure.
// pass Closure as Parameter to function in Swift5 iOS


import Foundation
import UIKit

// Trailing Closure.

/*
 
func sendRequest(name: String, age: Int, myClosure: () -> () ){
    
    print(name)
    print(age)
    
    myClosure()
}

sendRequest(name: "Goutham", age: 6) {
    print("empty closure")
}

 */


/*

func sendRequest(name: String, age: Int, myClosure: (_ n1 : Int, _ n2 : Int) -> () ){
    
    print(name)
    print(age)
    myClosure(5, 7)
}

sendRequest(name: "Usha Sri", age: 26) { (a, b) in
    print(a * b)
}

*/

func sendRequest(name: String, age: Int, myClosure: (_ n1 : Int, _ n2 : Int) -> (Int) ){
    
    print(name)
    print(age)
    let res = myClosure(5, 7)
    print(res)
}

sendRequest(name: "Usha Sri", age: 26) { (a, b) in
    print(a * b)
    
    return a+b
}
_______________________________________________________________________________________________________________________________

iTunes RSS Generator

https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/25/explicit.json

https://github.com/azamsharp/AzamSharp-Weekly/blob/master/mapping-nested-json-flat-model.playground/Contents.swift

https://home.openweathermap.org/users/sign_up

_______________________________________________________________________________________________________________________________

// Decode a Single Dictionary
 
 
import UIKit
import Foundation

 let singleDictJSON = """
    {
        "foodName": "Banana",
        "calories": 100
    }
 """.data(using: .utf8)!
 
 class Food: Codable {
    let foodName: String
    let calories: Int
    
    init(foodName: String, calories: Int) {
        self.foodName = foodName
        self.calories = calories
    }
 }
 
 let foodDecodar = JSONDecoder()
 
 do {
    let foodResult = try foodDecodar.decode(Food.self, from: singleDictJSON)
    print(foodResult.foodName)
    print(foodResult.calories)
 } catch {
    print("Failed to decode the food: \(error.localizedDescription)")
 }

// Banana
// 100

/*
  ## Encode Food Objects (Generate JSON from the model class)
  */
let apple = Food(foodName: "Apple", calories: 80)
let jsonEncoder = JSONEncoder()
jsonEncoder.outputFormatting = .prettyPrinted
 do {
    let jsonData = try jsonEncoder.encode(apple)
    if let jsonString = String(data: jsonData, encoding: .utf8) {
        print(jsonString)
    }
 } catch {
    print("Failed to encode the food: \(error.localizedDescription)")
 }

// {
//   "calories" : 80,
//   "foodName" : "Apple"
// }
//


______________________________________________________________________________________________________________________________________

// Decode Array of Dictionaries with Possible Nesting
 
 // https://youtu.be/Oj-2s0ALACE
 
import UIKit
import Foundation

 let dogOwnerJSONData = """
 [
   {
      "name": "John",
      "age": 15,
      "dogs": [
         {
             "dog_name": "Precious",
             "breed": "Pug",
             "age": 3
         },
         {
             "dog_name": "Furby",
             "breed": "German Shepherd",
             "age": 5
         }
 
      ]
    },
    {
        "name": "Liz",
        "age": 28
    }
 ]
 """.data(using: .utf8)!
 struct Dog: Codable {
    let name: String
    let breed: String
    let age: Int
    
    private enum CodingKeys: String, CodingKey {
        case name = "dog_name"
        case breed
        case age
    }
 }
 
 struct Owner: Codable {
    let name: String
    let age: Int
    var dogs: [Dog]?
 }

 let dogOwnerDecodor = JSONDecoder()
 do {
    let dogOwners = try dogOwnerDecodor.decode([Owner].self, from: dogOwnerJSONData)
    
    for owner in dogOwners {
        print("The owner name is : \(owner.name)")
        
        if let dogs = owner.dogs, dogs.count > 0 {
            for dog in dogs {
                print("Dog: \(dog.name) Age: \(dog.age) Breed: \(dog.breed)")
            }
        } else {
            print("\(owner.name) doesn't have any dogs.")
        }
    }
 } catch {
    print("Failed to decode the dogs JSON: \(error.localizedDescription)")
 }

 /*
   Encode Array of Dictionaries with Possible Nesting
  */
let dogOwnerEncoder = JSONEncoder()
dogOwnerEncoder.outputFormatting = .prettyPrinted

let dogOwner = Owner(name: "Mark", age: 45, dogs: [Dog(name: "Mikey", breed: "Boxer", age: 2)])
 do {
    let dogOwnerJSONData = try dogOwnerEncoder.encode(dogOwner)
    
    if let jsonString = String(data: dogOwnerJSONData, encoding: .utf8) {
        print(jsonString)
    }
 } catch {
    print("Failed to encode the dog owner: \(error.localizedDescription)")
 }

// The owner name is : John
// Dog: Precious Age: 3 Breed: Pug
// Dog: Furby Age: 5 Breed: German Shepherd
// The owner name is : Liz
// Liz doesn't have any dogs.
// {
//   "name" : "Mark",
//   "age" : 45,
//   "dogs" : [
//     {
//       "breed" : "Boxer",
//       "dog_name" : "Mikey",
//       "age" : 2
//     }
//   ]
// }


______________________________________________________________________________________________________________________________________________

https://developer.apple.com/documentation/foundation/archives_and_serialization/using_json_with_custom_types

_____________________________________________________________________________________________________________________________________

// Decode Array of Dictionaries with Possible Nesting
 
import UIKit
import Foundation

 let studentsJSONData = """
 {
  "students": [
     {
      "id": "asdfgh",
      "name": "Gary",
      "DOB": 2000
     },
     {
      "id": "jklzx",
      "name": "Peter",
      "DOB": 2001
     },
     {
      "id": "qazwsx",
      "name": "Susan",
      "DOB": 2002
     }
     ]
 }
 """.data(using: .utf8)!

 struct Student: Codable {
     var id: String
     var name: String
     var DOB: Int
 }

 struct Classroom: Codable {
     var students: [Student]
 }

 let classroom = try! JSONDecoder().decode(Classroom.self, from: Data(studentsJSONData))
 for student in classroom.students {
     print(student.id)
     print(student.name)
     print(student.DOB)
     print()
 }

 
// asdfgh
// Gary
// 2000
//
// jklzx
// Peter
// 2001
//
// qazwsx
// Susan
// 2002


_____________________________________________________________________________________________________________________________________

https://matteomanferdini.com/codable/

https://matteomanferdini.com/network-requests-rest-apis-ios-swift/

https://github.com/matteom/TopQuestion


https://api.stackexchange.com/questions?site=stackoverflow&order=desc&sort=votes&tagged=ios


https://api.stackexchange.com/questions?site=stackoverflow&order=desc&sort=votes&tagged=ios


__________________________________________________________________________________________________________________________________________________


// Decode Array of Dictionaries with Possible Nesting
//
 
import UIKit
import Foundation

 let userJSONData = """
 {
   "items": [
     {
       "tags": [
         "ios",
         "cocoa-touch",
         "uikit",
         "uilabel"
       ],
       "owner": {
         "reputation": 11418,
         "profile_image": "https://www.gravatar.com/avatar/f847f4085ff4144dfeffef53ed020b1d?s=128&d=identicon&r=PG",
         "display_name": "Stefan",
       },
       "score": 1762,
       "creation_date": 1246179243,
       "title": "Vertically align text to top within a UILabel"
     }
   ]
 }
 """.data(using: .utf8)!

 struct User {
    let name: String?
    let profileImageURL: URL?
    let reputation: Int?
 }

 extension User: Decodable {
    enum CodingKeys: String, CodingKey {
        case reputation
        case name = "diaplay_name"
        case profileImageURL = "profile_image"
    }
 }
 
 struct Question {
    let score: Int
    let title: String
    let date: Date
    let tags: [String]
    let owner: User?
 }

 extension Question: Decodable {
    enum CodingKeys: String, CodingKey {
        case score
        case title
        case tags
        case owner
        case date = "creation_date"
    }
 }
 
 struct Wrapper {
    let items: [Question]
 }

 
___________________________________________________________________________________________________________________________________________

http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=25/json

http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=25/json

// Complex Results.
https://youtu.be/EvwSB80GGDA

Calendar API

// https://www.youtube.com/watch?v=tdxKIPpPDAI


API Key:
3ddfe75f5b6ffcc63c5bccade5da276b21ecf83c

https://calendarific.com/api/v2/holidays?&api_key=3ddfe75f5b6ffcc63c5bccade5da276b21ecf83c&country=US&year=2019
https://www.youtube.com/watch?v=tdxKIPpPDAI


_______________________________________________________________________________________________________________________________

//  sample json parse

https://www.youtube.com/watch?v=gVFEkTehWVU



1. Dear [ teacher’s name ] – Thanks for an amazing year. Call off the party as I have decided to stay in your class forever.
https://www.youtube.com/watch?v=_TrPJQWD8qs

https://www.youtube.com/watch?v=34U5CPpfORs&list=PLBn01m5Vbs4DKrm1gwIr_a-0B7yvlTZP6&index=2


______________________________________________________________________________________________________________________________

// The Basics of JSON Decoding - Swift.
// 1.
// https://youtu.be/34U5CPpfORs
 
import UIKit
import Foundation

 let person1JSON = """
 {
    "name": "James",
    "age": 45,
    "gender": "Male",
    "sign": "Sagitarius",
    "partner": "Emily",
    "isEmployed": true
 }
 """
 let person2JSON = """
 {
    "name": "Marry",
    "age": 45,
    "gender": "Female",
    "sign": "Taurus",
    "isEmployed": true
 }
 """
 struct Person: Decodable {
    let name: String
    let age: Int
    let gender: String
    let sign: String
    let partner: String
    let isEmployed: Bool
 }

 let decoder = JSONDecoder()
 let person1JSONData = person1JSON.data(using: .utf8)!
 let person1 = try! decoder.decode(Person.self, from: person1JSONData)
 print(person1.name)
 print(person1.partner)
 
 //James
 //Emily

____________________________________________________________________________________________________________________________________________

// The Basics of JSON Decoding - Swift.
// 2.
// https://youtu.be/34U5CPpfORs
 
import UIKit
import Foundation

 let person1JSON = """
 {
    "name": "James",
    "age": 45,
    "gender": "Male",
    "sign": "Sagitarius",
    "partner": "Emily",
    "isEmployed": true
 }
 """
 let person2JSON = """
 {
    "name": "Marry",
    "age": 45,
    "gender": "Female",
    "sign": "Taurus",
    "isEmployed": true
 }
 """
 struct Person: Decodable {
    let name: String
    let age: Int
    let gender: String
    let sign: String
    let partner: String?
    let isEmployed: Bool
 }

 let decoder = JSONDecoder()
 let person1JSONData = person1JSON.data(using: .utf8)!
 let person1 = try! decoder.decode(Person.self, from: person1JSONData)
 print(person1.name)
 print(person1.partner)
 
 let person2JSONData = person2JSON.data(using: .utf8)!
 let person2 = try! decoder.decode(Person.self, from: person2JSONData)
 print(person2.name)
 print(person2.partner)

// James
// Optional("Emily")
// Marry
// nil
//

__________________________________________________________________________________________________________________________________________________


// Arrays  - The Basics of JSON Decoding - Swift.
// 3.
// https://youtu.be/34U5CPpfORs
 
import UIKit
import Foundation

 // Arrays
 
 
 let personsJSON = """
 [
    {
       "name": "James",
       "age": 45,
       "gender": "Male",
       "sign": "Sagitarius",
       "partner": "Emily",
       "isEmployed": true
    },
    {
        "name": "Marry",
        "age": 45,
        "gender": "Female",
        "sign": "Taurus",
        "isEmployed": true
     }
 ]
 """
 struct Person: Decodable {
    let name: String
    let age: Int
    let gender: String
    let sign: String
    let partner: String?
    let isEmployed: Bool
 }

 let decoder = JSONDecoder()
 let personsJSONData = personsJSON.data(using: .utf8)!
 let personsArray = try! decoder.decode([Person].self, from: personsJSONData)
 for person in personsArray {
    print("\(person.name)'s partner is \(person.partner ?? "none")")
 }

//James's partner is Emily
//Marry's partner is none

_________________________________________________________________________________________________________________________________________________


// Arrays  - The Basics of JSON Decoding - Swift.
// 3.
// https://youtu.be/34U5CPpfORs
 
import UIKit
import Foundation

 // Arrays
 
 
 let personsJSON = """
 [
    {
       "name": "James",
       "age": 45,
       "gender": "Male",
       "sign": "Sagitarius",
       "partner": "Emily",
       "isEmployed": true
    },
    {
        "name": "Marry",
        "age": 45,
        "gender": "Female",
        "sign": "Taurus",
        "isEmployed": true
     }
 ]
 """
 struct Person: Decodable {
    let name: String
    let age: Int
   // let gender: String
   // let sign: String
    let partner: String?
    let isEmployed: Bool
 }

 let decoder = JSONDecoder()
 let personsJSONData = personsJSON.data(using: .utf8)!
 let personsArray = try! decoder.decode([Person].self, from: personsJSONData)
 for person in personsArray {
    print("\(person.name)'s partner is \(person.partner ?? "none")")
 }

//James's partner is Emily
//Marry's partner is none


___________________________________________________________________________________________________________________________________________________

// More Complex Objects  - The Basics of JSON Decoding - Swift.
// 3.
// https://youtu.be/34U5CPpfORs
 
import UIKit
import Foundation

 // More Complex Objects
 
 
struct Person: Decodable {
   let name: String
   let age: Int
   let gender: String
   let sign: String
   let partner: String?
   let isEmployed: Bool
}

 let familyJSON = """
 {
     "familyName": "Smith",
     "members": [
     {
        "name": "James",
        "age": 45,
        "gender": "Male",
        "sign": "Sagitarius",
        "partner": "Emily",
        "isEmployed": true
     },
     {
        "name": "Marry",
        "age": 45,
        "gender": "Female",
        "sign": "Taurus",
        "isEmployed": true
     }
   ]

 }
 """
struct Family: Decodable {
    let familyName: String
    let members: [Person]
}

let decoder = JSONDecoder()

let familyJSONData = familyJSON.data(using: .utf8)!
let myFamily = try! decoder.decode(Family.self, from: familyJSONData)
print(myFamily.familyName)
for member in myFamily.members {
    print(member.name)
}


//Smith
//James
//Marry

__________________________________________________________________________________________________________________________________________________________

// A Better model  - The Basics of JSON Decoding - Swift.
// 4.
// https://youtu.be/34U5CPpfORs
 
import UIKit
import Foundation

 // A Better model
 
let familyJSON = """
 {
     "familyName": "Smith",
     "members": [
     {
        "name": "James",
        "age": 45,
        "gender": "Male",
        "sign": "Sagitarius",
        "partner": "Emily",
        "isEmployed": true
     },
     {
        "name": "Marry",
        "age": 45,
        "gender": "Female",
        "sign": "Taurus",
        "isEmployed": true
     }
   ]

 }
 """
struct Family2: Decodable {
    enum Gender: String, Decodable {
        case Male, Female, Other
    }
    struct Person: Decodable {
       let name: String
       let age: Int
       let gender: Gender
       let sign: String
       let partner: String?
       let isEmployed: Bool
    }
    let familyName: String
    let members: [Person]
}

let decoder = JSONDecoder()

let familyJSONData = familyJSON.data(using: .utf8)!
let myFamily2 = try! decoder.decode(Family2.self, from: familyJSONData)
print(myFamily2.familyName)
for member in myFamily2.members {
    print(member.name)
}


//Smith
//James
//Marry

________________________________________________________________________________________________________________________________________________________

// JSON Formatter.

https://jsonformatter.curiousconcept.com/

_________________________________________________________________________________________________________________________________________________

// JSON From local file  - The Basics of JSON Decoding - Swift.
// 5.
// https://jsonformatter.curiousconcept.com/#
// https://youtu.be/34U5CPpfORs
 
// FlatColors.json
/*

{"palette_name": "Flat Colours","palette_info": "For Design","palette_colors": [{"sort_order": 0,"description": "Flat Powder Blue (Light)","red": 170,"green": 186,"blue": 241,"alpha": 1.0},{"sort_order": 1,"description": "Flat Powder Blue (Dark)","red": 136,"green": 152,"blue": 207,"alpha": 1.0},{"sort_order": 2,"description": "Flat Sky Blue (Light)","red": 49,"green": 129,"blue": 217,"alpha": 1.0},{"sort_order": 3,"description": "Flat Sky Blue (Dark)","red": 39,"green": 105,"blue": 176,"alpha": 1.0},{"sort_order": 4,"description": "Flat Blue (Light)","red": 63,"green": 77,"blue": 148,"alpha": 1.0},{"sort_order": 5,"description": "Flat Blue Dark","red": 44,"green": 55,"blue": 113,"alpha": 1.0},{"sort_order": 6,"description": "Flat Purple (Light)","red": 94,"green": 65,"blue": 192,"alpha": 1.0},{"sort_order": 7,"description": "Flat Purple (Dark)","red": 70,"green": 47,"blue": 151,"alpha": 1.0},{"sort_order": 8,"description": "Flat Magenta Light","red": 132,"green": 61,"blue": 174,"alpha": 1.0},{"sort_order": 9,"description": "Flat Magenta (Dark)","red": 118,"green": 39,"blue": 164,"alpha": 1.0},{"sort_order": 10,"description": "Flat Pink (Light)","red": 233,"green": 96,"blue": 187,"alpha": 1.0},{"sort_order": 11,"description": "Flat Pink (Dark)","red": 195,"green": 65,"blue": 144,"alpha": 1.0},{"sort_order": 12,"description": "Flat Watermelon (Light)","red": 227,"green": 90,"blue": 101,"alpha": 1.0},{"sort_order": 13,"description": "Flat Watermelon (Dark)","red": 200,"green": 62,"blue": 69,"alpha": 1.0},{"sort_order": 14,"description": "Flat Red (Light)","red": 216,"green": 55,"blue": 40,"alpha": 1.0},{"sort_order": 15,"description": "Flat Red (Dark)","red": 172,"green": 40,"blue": 27,"alpha": 1.0},{"sort_order": 16,"description": "Flat Orange (Light)","red": 217,"green": 107,"blue": 0,"alpha": 1.0},{"sort_order": 17,"description": "Flat Orange (Dark)","red": 194,"green": 65,"blue": 0,"alpha": 1.0},{"sort_order": 18,"description": "Flat Yellow (Light)","red": 251,"green": 198,"blue": 0,"alpha": 1.0},{"sort_order": 19,"description": "Flat Yellow (Dark)","red": 249,"green": 154,"blue": 0,"alpha": 1.0},{"sort_order": 20,"description": "Flat Lime (Light)","red": 151,"green": 191,"blue": 0,"alpha": 1.0},{"sort_order": 21,"description": "Flat Lime (Dark)","red": 126,"green": 165,"blue": 0,"alpha": 1.0},{"sort_order": 22,"description": "Flat Green (Light)","red": 58,"green": 198,"blue": 80,"alpha": 1.0},{"sort_order": 23,"description": "Flat Green (Dark)","red": 48,"green": 162,"blue": 66,"alpha": 1.0},{"sort_order": 24,"description": "Flat Mint (Light)","red": 46,"green": 177,"blue": 135,"alpha": 1.0},{"sort_order": 25,"description": "Flat Mint (Dark)","red": 38,"green": 145,"blue": 111,"alpha": 1.0},{"sort_order": 26,"description": "Flat Teal (Light)","red": 48,"green": 91,"blue": 111,"alpha": 1.0},{"sort_order": 27,"description": "Flat Teal (Dark)","red": 43,"green": 78,"blue": 96,"alpha": 1.0},{"sort_order": 28,"description": "Flat Navy Blue (Light)","red": 40,"green": 55,"blue": 77,"alpha": 1.0},{"sort_order": 29,"description": "Flat Navy Blue (Dark)","red": 34,"green": 46,"blue": 64,"alpha": 1.0},{"sort_order": 30,"description": "Flat Black (Light)","red": 32,"green": 32,"blue": 32,"alpha": 1.0},{"sort_order": 31,"description": "Flat Black (Dark)","red": 28,"green": 28,"blue": 28,"alpha": 1.0},{"sort_order": 32,"description": "Flat Brown (Light)","red": 74,"green": 53,"blue": 37,"alpha": 1.0},{"sort_order": 33,"description": "Flat Brown (Dark)","red": 61,"green": 45,"blue": 31,"alpha": 1.0},{"sort_order": 34,"description": "Flat Coffee (Light)","red": 143,"green": 115,"blue": 91,"alpha": 1.0},{"sort_order": 35,"description": "Flat Coffee (Dark)","red": 121,"green": 95,"blue": 73,"alpha": 1.0},{"sort_order": 36,"description": "Flat Sand (Light)","red": 234,"green": 216,"blue": 159,"alpha": 1.0},{"sort_order": 37,"description": "Flat Sand (Dark)","red": 202,"green": 183,"blue": 124,"alpha": 1.0},{"sort_order": 38,"description": "Flat White (Light)","red": 231,"green": 236,"blue": 237,"alpha": 1.0},{"sort_order": 39,"description": "Flat White (Dark)","red": 175,"green": 181,"blue": 187,"alpha": 1.0},{"sort_order": 40,"description": "Flat Gray (Light)","red": 132,"green": 148,"blue": 149,"alpha": 1.0},{"sort_order": 41,"description": "Flat Gray (Dark)","red": 108,"green": 121,"blue": 122,"alpha": 1.0},{"sort_order": 42,"description": "Flat Maroon (Light)","red": 98,"green": 34,"blue": 29,"alpha": 1.0},{"sort_order": 43,"description": "Flat Maroon (Dark)","red": 80,"green": 27,"blue": 23,"alpha": 1.0},{"sort_order": 44,"description": "Flat Forest Green (Light)","red": 42,"green": 78,"blue": 46,"alpha": 1.0},{"sort_order": 45,"description": "Flat Forest Green (Dark)","red": 36,"green": 64,"blue": 38,"alpha": 1.0},{"sort_order": 46,"description": "Flat Plum (Light)","red": 73,"green": 35,"blue": 78,"alpha": 1.0},{"sort_order": 47,"description": "Flat Plum (Dark)","red": 60,"green": 29,"blue": 64,"alpha": 1.0}]}

 */


import UIKit
import Foundation

struct ColorPalette: Decodable {
    struct PaletteColor: Decodable {
        let sort_order: Int
        let description: String
        let red: Int
        let green: Int
        let blue: Int
        let alpha: Double
    }
    let palette_name: String
    let palette_info: String
    let palette_colors: [PaletteColor]
}

guard let sourcesURL = Bundle.main.url(forResource: "FlatColors", withExtension: "json") else {
    fatalError("Could not find FlatColours.json")
}
guard let colorData = try? Data(contentsOf: sourcesURL) else {
    fatalError("Could not convert data")
}

let decoder = JSONDecoder()
guard let flatColors = try? decoder.decode(ColorPalette.self, from: colorData) else {
    fatalError("There was a problem decoding the data...")
}
print(flatColors.palette_name)
for color in flatColors.palette_colors {
    print(color.description)
}


//Flat Colours
//Flat Powder Blue (Light)
//Flat Powder Blue (Dark)
//Flat Sky Blue (Light)
//Flat Sky Blue (Dark)
//Flat Blue (Light)

_______________________________________________________________________________________________________________________________________________________

// Most useful Links

https://www.youtube.com/watch?v=_TrPJQWD8qs


NSDateFormatter:
 https://nsdateformatter.com

UseYourLoaf Blog Post:

https://gist.github.com/kharrison/fec1d7fc83ffe65bf01970d71e5dc944
https://useyourloaf.com/blog/swift-codable-with-custom-dates/

// iTunes RSS Feed Generator

https://useyourloaf.com/blog/swift-codable-with-custom-dates/


JSON Formatter and Validator:
https://jsonformatter.curiousconcept.com

_______________________________________________________________________________________________________________________________________________________

// JSON - Decoding Dates  - Swift.
// 6. DateFormatter strategy
// https://jsonformatter.curiousconcept.com/#
// https://youtu.be/34U5CPpfORs
 
import UIKit
import Foundation

let personJson = """
{
   "id" : 7,
   "name" : "Aiden Lynch",
   "birthday" : "27-03-1993",
}
"""
struct Person: Decodable {
    let id: Int
    let name: String
    let birthday: Date
}
let formatter = DateFormatter()
formatter.dateFormat = "dd-MM-yyyy"

let personJSONData = personJson.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .formatted(formatter)
let thisPerson = try! decoder.decode(Person.self, from: personJSONData)
print(thisPerson.birthday)


// 1993-03-26 18:30:00 +0000


___________________________________________________________________________________________________________________________________________________

// JSON - Decoding Other DateDecodingStrategies - Dates  - Swift.
// 7. DateFormatter strategy
// https://jsonformatter.curiousconcept.com/#
// https://youtu.be/34U5CPpfORs

// JSON Formatter and Validator:
// https://jsonformatter.curiousconcept.com
 
// Events.json
  /*
[
   {
      "name":"Vancouver Event",
      "date":1582966800,
      "website":"https://www.vancouverconventioncentre.com"
   },
   {
      "name":"Los Angelas",
      "date":1588158000,
      "website":"https://www.staplescenter.com"
   }
]

*/

import UIKit
import Foundation

struct Event: Decodable {
    let name: String
    let date: Date
    let website: URL
}

guard let sourcesURL = Bundle.main.url(forResource: "Events", withExtension: "json") else{
    fatalError("Could not find Events.json")
}

guard let eventJSONData = try? Data(contentsOf: sourcesURL) else {
    fatalError("Could not convert to data")
}

let decoder2 = JSONDecoder()
decoder2.dateDecodingStrategy = .secondsSince1970

guard let events = try? decoder2.decode([Event].self, from: eventJSONData) else {
    fatalError("There must ba a problem decoding the data.....")
}

for event in events {
    print(event.name)
    print(event.date)
    print(event.website)
}


// Vancouver Event
// 2020-02-29 09:00:00 +0000
// https://www.vancouverconventioncentre.com
// Los Angelas
// 2020-04-29 11:00:00 +0000
// https://www.staplescenter.com

_______________________________________________________________________________________________________________________________________________________

// JSON CodingKeys  - Swift.
// 8. JSON CodingKeys
// https://jsonformatter.curiousconcept.com/#
// https://youtu.be/34U5CPpfORs

// JSON Formatter and Validator:
// https://jsonformatter.curiousconcept.com
 
// FlatColors.json
/*
 
 {
    "palette_name":"Flat Colours",
    "palette_info":"For Design",
    "palette_colors":[
       {
          "sort_order":0,
          "description":"Flat Powder Blue (Light)",
          "red":170,
          "green":186,
          "blue":241,
          "alpha":1.0
       },
       {
          "sort_order":1,
          "description":"Flat Powder Blue (Dark)",
          "red":136,
          "green":152,
          "blue":207,
          "alpha":1.0
       },
       {
          "sort_order":2,
          "description":"Flat Sky Blue (Light)",
          "red":49,
          "green":129,
          "blue":217,
          "alpha":1.0
       },
       {
          "sort_order":3,
          "description":"Flat Sky Blue (Dark)",
          "red":39,
          "green":105,
          "blue":176,
          "alpha":1.0
       },
       {
          "sort_order":4,
          "description":"Flat Blue (Light)",
          "red":63,
          "green":77,
          "blue":148,
          "alpha":1.0
       },
       {
          "sort_order":5,
          "description":"Flat Blue Dark",
          "red":44,
          "green":55,
          "blue":113,
          "alpha":1.0
       },
       {
          "sort_order":6,
          "description":"Flat Purple (Light)",
          "red":94,
          "green":65,
          "blue":192,
          "alpha":1.0
       },
       {
          "sort_order":7,
          "description":"Flat Purple (Dark)",
          "red":70,
          "green":47,
          "blue":151,
          "alpha":1.0
       },
       {
          "sort_order":8,
          "description":"Flat Magenta Light",
          "red":132,
          "green":61,
          "blue":174,
          "alpha":1.0
       },
       {
          "sort_order":9,
          "description":"Flat Magenta (Dark)",
          "red":118,
          "green":39,
          "blue":164,
          "alpha":1.0
       },
       {
          "sort_order":10,
          "description":"Flat Pink (Light)",
          "red":233,
          "green":96,
          "blue":187,
          "alpha":1.0
       },
       {
          "sort_order":11,
          "description":"Flat Pink (Dark)",
          "red":195,
          "green":65,
          "blue":144,
          "alpha":1.0
       },
       {
          "sort_order":12,
          "description":"Flat Watermelon (Light)",
          "red":227,
          "green":90,
          "blue":101,
          "alpha":1.0
       },
       {
          "sort_order":13,
          "description":"Flat Watermelon (Dark)",
          "red":200,
          "green":62,
          "blue":69,
          "alpha":1.0
       },
       {
          "sort_order":14,
          "description":"Flat Red (Light)",
          "red":216,
          "green":55,
          "blue":40,
          "alpha":1.0
       },
       {
          "sort_order":15,
          "description":"Flat Red (Dark)",
          "red":172,
          "green":40,
          "blue":27,
          "alpha":1.0
       },
       {
          "sort_order":16,
          "description":"Flat Orange (Light)",
          "red":217,
          "green":107,
          "blue":0,
          "alpha":1.0
       },
       {
          "sort_order":17,
          "description":"Flat Orange (Dark)",
          "red":194,
          "green":65,
          "blue":0,
          "alpha":1.0
       },
       {
          "sort_order":18,
          "description":"Flat Yellow (Light)",
          "red":251,
          "green":198,
          "blue":0,
          "alpha":1.0
       },
       {
          "sort_order":19,
          "description":"Flat Yellow (Dark)",
          "red":249,
          "green":154,
          "blue":0,
          "alpha":1.0
       },
       {
          "sort_order":20,
          "description":"Flat Lime (Light)",
          "red":151,
          "green":191,
          "blue":0,
          "alpha":1.0
       },
       {
          "sort_order":21,
          "description":"Flat Lime (Dark)",
          "red":126,
          "green":165,
          "blue":0,
          "alpha":1.0
       },
       {
          "sort_order":22,
          "description":"Flat Green (Light)",
          "red":58,
          "green":198,
          "blue":80,
          "alpha":1.0
       },
       {
          "sort_order":23,
          "description":"Flat Green (Dark)",
          "red":48,
          "green":162,
          "blue":66,
          "alpha":1.0
       },
       {
          "sort_order":24,
          "description":"Flat Mint (Light)",
          "red":46,
          "green":177,
          "blue":135,
          "alpha":1.0
       },
       {
          "sort_order":25,
          "description":"Flat Mint (Dark)",
          "red":38,
          "green":145,
          "blue":111,
          "alpha":1.0
       },
       {
          "sort_order":26,
          "description":"Flat Teal (Light)",
          "red":48,
          "green":91,
          "blue":111,
          "alpha":1.0
       },
       {
          "sort_order":27,
          "description":"Flat Teal (Dark)",
          "red":43,
          "green":78,
          "blue":96,
          "alpha":1.0
       },
       {
          "sort_order":28,
          "description":"Flat Navy Blue (Light)",
          "red":40,
          "green":55,
          "blue":77,
          "alpha":1.0
       },
       {
          "sort_order":29,
          "description":"Flat Navy Blue (Dark)",
          "red":34,
          "green":46,
          "blue":64,
          "alpha":1.0
       },
       {
          "sort_order":30,
          "description":"Flat Black (Light)",
          "red":32,
          "green":32,
          "blue":32,
          "alpha":1.0
       },
       {
          "sort_order":31,
          "description":"Flat Black (Dark)",
          "red":28,
          "green":28,
          "blue":28,
          "alpha":1.0
       },
       {
          "sort_order":32,
          "description":"Flat Brown (Light)",
          "red":74,
          "green":53,
          "blue":37,
          "alpha":1.0
       },
       {
          "sort_order":33,
          "description":"Flat Brown (Dark)",
          "red":61,
          "green":45,
          "blue":31,
          "alpha":1.0
       },
       {
          "sort_order":34,
          "description":"Flat Coffee (Light)",
          "red":143,
          "green":115,
          "blue":91,
          "alpha":1.0
       },
       {
          "sort_order":35,
          "description":"Flat Coffee (Dark)",
          "red":121,
          "green":95,
          "blue":73,
          "alpha":1.0
       },
       {
          "sort_order":36,
          "description":"Flat Sand (Light)",
          "red":234,
          "green":216,
          "blue":159,
          "alpha":1.0
       },
       {
          "sort_order":37,
          "description":"Flat Sand (Dark)",
          "red":202,
          "green":183,
          "blue":124,
          "alpha":1.0
       },
       {
          "sort_order":38,
          "description":"Flat White (Light)",
          "red":231,
          "green":236,
          "blue":237,
          "alpha":1.0
       },
       {
          "sort_order":39,
          "description":"Flat White (Dark)",
          "red":175,
          "green":181,
          "blue":187,
          "alpha":1.0
       },
       {
          "sort_order":40,
          "description":"Flat Gray (Light)",
          "red":132,
          "green":148,
          "blue":149,
          "alpha":1.0
       },
       {
          "sort_order":41,
          "description":"Flat Gray (Dark)",
          "red":108,
          "green":121,
          "blue":122,
          "alpha":1.0
       },
       {
          "sort_order":42,
          "description":"Flat Maroon (Light)",
          "red":98,
          "green":34,
          "blue":29,
          "alpha":1.0
       },
       {
          "sort_order":43,
          "description":"Flat Maroon (Dark)",
          "red":80,
          "green":27,
          "blue":23,
          "alpha":1.0
       },
       {
          "sort_order":44,
          "description":"Flat Forest Green (Light)",
          "red":42,
          "green":78,
          "blue":46,
          "alpha":1.0
       },
       {
          "sort_order":45,
          "description":"Flat Forest Green (Dark)",
          "red":36,
          "green":64,
          "blue":38,
          "alpha":1.0
       },
       {
          "sort_order":46,
          "description":"Flat Plum (Light)",
          "red":73,
          "green":35,
          "blue":78,
          "alpha":1.0
       },
       {
          "sort_order":47,
          "description":"Flat Plum (Dark)",
          "red":60,
          "green":29,
          "blue":64,
          "alpha":1.0
       }
    ]
 }

*/

import UIKit
import Foundation

struct ColorPalette: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "palette_name"
        case info = "palette_info"
        case colors = "palette_colors"
    }
    struct PaletteColor: Decodable {
        enum CodingKeys: String, CodingKey {
            case order = "sort_order"
            case description = "description"
            case red = "red"
            case green = "green"
            case blue = "blue"
            case alpha = "alpha"
        }
        let order: Int
        let description: String
        let red: Int
        let green: Int
        let blue: Int
        let alpha: Double
    }
    let name: String
    let info: String
    let colors: [PaletteColor]
}

guard let sourcesURL = Bundle.main.url(forResource: "FlatColors", withExtension: "json") else {
    fatalError("Could not find FlatColours.json")
}
guard let colorData = try? Data(contentsOf: sourcesURL) else {
    fatalError("Could not convert data")
}

let decoder = JSONDecoder()
guard let flatColors = try? decoder.decode(ColorPalette.self, from: colorData) else {
    fatalError("There was a problem decoding the data...")
}
print(flatColors.name)
for color in flatColors.colors {
    print(color.description)
}


//Flat Colours
//Flat Powder Blue (Light)
//Flat Powder Blue (Dark)
//Flat Sky Blue (Light)
//Flat Sky Blue (Dark)
//Flat Blue (Light)
//Flat Blue Dark
//Flat Purple (Light)
//

_______________________________________________________________________________________________________________________________________________________

// JSON Custom CodingKeys  - Swift.
// 9.
// https://jsonformatter.curiousconcept.com/#

// JSON Formatter and Validator:
// https://jsonformatter.curiousconcept.com
 
import UIKit
import Foundation
let booksJSON = """
[
  {
    "feed": {
      "publisher": "Penguin",
      "country": "Ca"
    },
    "entry": [
      {
         "author": "Margaret Atwood",
         "nationality": "Canadian"
      },
      {
         "author": "Dan Brown",
         "nationality": "American"
      }
   ]
  },
  {
      "feed": {
         "publisher": "Penguin",
         "country": "CA"
      },
       "entry": {
          "author": "Pierre Burton",
          "nationality": "Canadian"
      }

  }

]
"""
struct Book: Decodable {
    enum CodingKeys: String, CodingKey {
        case feed, entry
    }
    struct Feed: Decodable {
        let publisher: String
        let country: String
    }
    struct Entry: Decodable {
        let author: String
        let nationality: String
    }
    let feed: Feed
    var entry: [Entry]
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        feed = try container.decode(Feed.self, forKey: .feed)
        do {
            entry = try container.decode([Entry].self, forKey: .entry)
        } catch {
            let newValue = try container.decode(Entry.self, forKey: .entry)
            entry = [newValue]
        }
    }
}

let decoder = JSONDecoder()
let bookJSONData = booksJSON.data(using: .utf8)!
let books = try! decoder.decode([Book].self, from: bookJSONData)

for book in books {
    print(book.feed.publisher)
    for entry in book.entry {
        print(entry.author)
    }
}

//Penguin
//Margaret Atwood
//Dan Brown
//Penguin
//Pierre Burton

__________________________________________________________________________________________________________________________________________________


// Adding Decodable conformance for Property Wrappers  - Swift.
// Property wrappers such as @Published, do not conform to codable
// 10.
// https://jsonformatter.curiousconcept.com/#

// JSON Formatter and Validator:
// https://jsonformatter.curiousconcept.com
 
import UIKit
import Foundation

class user: ObservableObject,Decodable {
    enum CodingKeys: String, CodingKey {
        case name, age
    }
    @Published var name = "Aidan Lynch"
    var age = 27
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
    }
}


_____________________________________________________________________________________________________________________________________________________


NSOperationQueue

https://www.appcoda.com/ios-concurrency/

https://github.com/appcoda/NSOperation-Demo


_______________________________________________________________________________________________________________________________

RunLoop

https://theswiftdev.com/ultimate-grand-central-dispatch-tutorial-in-swift/


_______________________________________________________________________________________________________________________________

MVVM

https://github.com/shantaramk/MVVM

https://www.createchsol.com/WeatherAppCourse


One Call API

https://openweathermap.org/api/one-call-api
https://openweathermap.org/api/one-call-api


Weather App

https://www.createchsol.com/WeatherAppCourse/

https://jsonformatter.curiousconcept.com/#


c5292819900458074045bf3ab079fdeb

49.263625
-123.138589

https://api.openweathermap.org/data/2.5/onecall?lat=49.263625&lon=-123.138589&exclude=current,minutely,hourly,alert&appid=c5292819900458074045bf3ab079fdeb


// Working URL is:

apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=49.263625&lon=-123.138589&exclude=current,minutely,hourly,alert&appid=c5292819900458074045bf3ab079fdeb",dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast,APIService.APIError>) in
    


//

Please find attached file. There is no deadline for these tasks. But it would be good if you return this as soon as possible.  We do consider following things when we test your code.  
* Code must be in Swift Language (IOS) or Flutter.
* User Interface should be good and must use auto layout.
* Should follow MVC and OOPs concepts where required.
* Offline storage should be handled.
* Folder structure should be good.


https://github.com/gtokman/Slide-In-Transition


https://www.skylinecms.co.uk/alpha/RemoteEngineerAPI&Gray&123456789&08/02/2021



<GetAppointmentDetails>
<SLUsername>Settings Username</SLUsername> <SLPassword>Settings Password</SLPassword> <CurrentDate>Settings Date</CurrentDate>
</GetAppointmentDetails>


https://developer.apple.com/forums/thread/665020

https://leaks.wanari.com/2016/08/24/xml-parsing-swift/

// Correct XML

https://developer.apple.com/forums/thread/665020

Wrong line missing the space

<?xml version=\"1.0\"encoding=\"UTF-8\"?>


Corrected line with a space before encoding.

<?xml version=\"1.0\" encoding=\"UTF-8\"?>



_______________________________________________________________________________________________________________________________

auto layout anchors


https://theswiftdev.com/mastering-ios-auto-layout-anchors-programmatically-from-swift/

https://theswiftdev.com/ios-auto-layout-tutorial-programmatically/

https://www.raywenderlich.com/811496-auto-layout-tutorial-in-ios-getting-started

______________________________________________________________________________________________________________________________

PAutoLayout

https://github.com/jrasmusson/autolayout-course


E-Book
https://www.softcover.io/read/7671f69a/ios-tutorial-book/8-autolayout

https://www.softcover.io/read/7671f69a/ios-tutorial-book/8-autolayout


// Size Classes in Swift 5 | Compact | Regular | in Auto layout | iOS | iPhone| iPad

https://youtu.be/iYPiwwdp8rI


import UIKit
import Foundation

 // Reverse the number

var n = 45

var reverse: Int = 0

while(n != 0) {
    
    reverse = reverse * 10
    
    reverse = reverse + n % 10
    
    n = n/10
}

print(reverse)


// Reversed array

let names: [String] = ["Apple", "Microsoft", "Sony"]

var reversenames: [String] = []

let count = names.count

for index in 0..<count {
   
    reversenames.insert(names[count-index-1], at: index)
    
}

print(reversenames)

let word = "aabbaa"

var palindrome = true
let chars = Array(word)

for i in 0 ..< (chars.count / 2) {
    if chars[i] != chars[chars.count - 1 - i] {
        palindrome = false
        break
    }
}
print(palindrome)

// reverse of the string

let str = "how are you"

var reversedString = ""

// looping through each character

for char in str {
    reversedString = "\(char)" + reversedString
    
}

print(reversedString)

// Check prime number in Swift

var flag: Bool = false

let number: Int = 13

for i in 2...number/2 {
    
    if (number%i == 0) {
        flag = true
        break
    }
}
    
    if flag == false {
        print("\(number) is prime!")
    } else {
        print("\(number) is not prime!")
    }


//  range of 100 prime members

  var primes = [Int]()

for n in 2...100 {
    if primes.allSatisfy({ n % $0 != 0 }) {
        primes.append(n)
    }
}

print(primes)


//  Fibonacci series
// F[n] = F[n-1] + F[n-2]
// 0, 1, 1, 2, 3, 5, 8, 13, 21,34.
// Find the fibonacci number for n iterations

func fibonacci(n: Int) {
    
    var num1 = 0
    var num2 = 1
    
    
    for _ in 0..<n {
        
        let num = num1 + num2
        num1 = num2
        num2 = num
    }
    
    print("result = \(num2)")
    
}

fibonacci(n: 7)


// returns an array containing the first n Fibonacci numbers
func fibonacci4(n: Int) -> [Int] {
    
    assert(n > 1)

    var array = [0, 1]

    while array.count < n {
        array.append(array[array.count - 1] + array[array.count - 2])
        
    }
    let total = array.reduce(0, +)
    print(total)
    return array
}

var arry = fibonacci4(n: 7) // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
print(arry)

_______________________________________________________________________________________________________________________________



