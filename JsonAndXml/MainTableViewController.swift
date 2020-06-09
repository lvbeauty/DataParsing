//
//  TableViewController.swift
//  JsonAndXml
//
//  Created by Tong Yi on 5/13/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController//, Codable
{

    let bundle = Bundle.main
    let fileManager = FileManager.default
    var jsonD: [Entertainment] = []
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        createJsonFile()
        setupUI()
        jsonParser()
        decode()
        encode()
    }
    
    func setupUI()
    {
        self.tableView.tableFooterView = UIView()
        self.title = "JSON"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemPink.withAlphaComponent(0.4)
    }

    // MARK: - Table view data source & delegate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonD.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = jsonD[indexPath.row].title
        cell.detailTextLabel?.text = jsonD[indexPath.row].detail
        cell.backgroundColor = UIColor.systemRed.withAlphaComponent(0.3)
        return cell
    }
}

//MARK: - JSON File parsing

extension MainTableViewController
{
    func createJsonFile()
    {
        do
        {
            let jsonURLInDocum = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("JSONData").appendingPathExtension("json")
            let jsonData = try JSONSerialization.data(withJSONObject: dataSouce, options: .prettyPrinted)
            try jsonData.write(to: jsonURLInDocum)
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    func jsonParser()
    {
        guard let jsonFilePath = bundle.path(forResource: "JSONData", ofType: "json"),
            let jsonData = fileManager.contents(atPath: jsonFilePath) else {return}
        do
        {
            let jsonInstance = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [[String: String]]
            
            for item in jsonInstance
            {
                let jsonDataUnit = Entertainment(title: item["title"] ?? "title", detail: item["detail"] ?? "detail")
                jsonD.append(jsonDataUnit)
            }
//            print(jsonD)
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
}

//MARK: - Codable = Decodable & Encodable

extension MainTableViewController
{
    func decode()
    {
        guard let jsonFilePath = bundle.path(forResource: "JSONData", ofType: "json"),
               let jsonData = fileManager.contents(atPath: jsonFilePath) else {return}
        do
        {   // another parsing method
           let entertainments = try jsonDecoder.decode([Entertainment].self, from: jsonData)
            print(entertainments)
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    func encode()
    {
        do
        {
            let jsonData = try jsonEncoder.encode(jsonD)
            print(jsonData)
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
}

//MARK: - Custom codable

extension MainTableViewController
{
    func decodeCustom()
    {
        guard let jsonFilePath = bundle.path(forResource: "JSONData", ofType: "json"),
               let jsonData = fileManager.contents(atPath: jsonFilePath) else {return}
        do
        {   // another parsing method
            let entertainments = Entertainment(title: "title", detail: "detail")
           
            print(entertainments)
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    
    func encodeCustom()
    {
        do
        {
            let jsonData = try jsonEncoder.encode(jsonD)
            print(jsonData)
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
}



