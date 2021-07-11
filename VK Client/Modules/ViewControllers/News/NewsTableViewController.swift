//
//  NewsTableViewController.swift
//  VK Client
//
//  Created by Сергей Беляков on 09.07.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {

    private var news = NewsResponse(items: nil, groups: nil, profiles: nil, nextFrom: nil)
    var apiService = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeSection()
    }
    
    func makeSection() {
        let sourceNib = UINib(nibName: "SourceTableViewCell", bundle: nil)
        self.tableView.register(sourceNib, forCellReuseIdentifier: "SourceTableViewCell")
        let textNib = UINib(nibName: "TextTableViewCell", bundle: nil)
        self.tableView.register(textNib, forCellReuseIdentifier: "TextTableViewCell")
        let utilityNib = UINib(nibName: "UtilityTableViewCell", bundle: nil)
        self.tableView.register(utilityNib, forCellReuseIdentifier: "UtilityTableViewCell")
        let imageNib = UINib(nibName: "ImageTableViewCell", bundle: nil)
        self.tableView.register(imageNib, forCellReuseIdentifier: "ImageTableViewCell")
        let separatorNib = UINib(nibName: "SeparatorTableViewCell", bundle: nil)
        self.tableView.register(separatorNib, forCellReuseIdentifier: "SeparatorTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        apiService.getNews { [weak self] news in
            guard let self = self else { return }
            self.news = news
        }
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let profiles = news.profiles,
              let groups = news.groups,
              let items = news.items else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SourceTableViewCell", for: indexPath) as! SourceTableViewCell
            var name, string: String?
            guard let source = items[indexPath.section].sourceID else { return UITableViewCell() }
            
            if source < 0 {
                groups.forEach {
                    if $0.id == abs(source) {
                        name = $0.name
                        string = $0.photo100
                    }
                }
            } else {
                profiles.forEach {
                    if $0.id == source {
                        name = $0.firstName + " " + $0.lastName
                        string = $0.photo100
                    }
                }
            }
            guard let avatarString = URL(string: string!) else { return UITableViewCell() }
            let image = asyncPhoto(cellImage: cell.avatarImageView, url: avatarString)
            let date = unixTimeConvertion(unixTimeInt: items[indexPath.section].date ?? 0)
            cell.configure(image: image, date: date, name: name)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as! TextTableViewCell
            let newsText = items[indexPath.section].text
            cell.configure(newsText: newsText)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            guard let imageString = findURL(item: items[indexPath.section].attachments) else { return UITableViewCell() }
            let newsImage = asyncPhoto(cellImage: cell.imageView ?? UIImageView(), url: imageString)
            cell.configure(image: newsImage)
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UtilityTableViewCell", for: indexPath) as! UtilityTableViewCell
            let likes = String(items[indexPath.section].likes?.count ?? 0)
            let comments = String(items[indexPath.section].comments?.count ?? 0)
            let reposts = String(items[indexPath.section].reposts?.count ?? 0)
            let views = String(items[indexPath.section].views?.count ?? 0)
            cell.configure(likes: likes, comments: comments, reposts: reposts, views: views)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeparatorTableViewCell", for: indexPath) as! SeparatorTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewsTableViewController {
    
    
    func unixTimeConvertion(unixTimeInt: Int) -> String {
      let unixTime = Double(unixTimeInt)
      let time = NSDate(timeIntervalSince1970: unixTime)
      let dateFormatter = DateFormatter()
      dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.system.identifier) as Locale?
      dateFormatter.dateFormat = "hh:mm a"
      let dateAsString = dateFormatter.string(from: time as Date)
      dateFormatter.dateFormat = "h:mm a"
      let date = dateFormatter.date(from: dateAsString)
      dateFormatter.dateFormat = "HH:mm"
      let date24 = dateFormatter.string(from: date!)
      return date24
    }
    
    func findURL(item: [Attachment]?) -> URL? {
      var url = String()
      guard let item = item else {return URL(string: url)}
      for item in item {
        item.photo?.sizes?.forEach {
          if $0.type == "r" {
            url = $0.url
          }
        }
      }
      return URL(string: url)
    }
    
}
