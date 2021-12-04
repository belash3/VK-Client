//
//  NewsTableViewController.swift
//  VK Client
//
//  Created by Сергей Беляков on 09.07.2021.
//

import UIKit
import SDWebImage

class NewsTableViewController: UITableViewController {

    private var news = NewsResponse(items: nil, profiles: nil, groups: nil, nextFrom: nil)
    var newss: [NewsItem] = []
    var apiService = API()
    
    let newsRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Updating news feed...")
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        return refreshControl
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.refreshControl = newsRefreshControl
        apiService.getNews { [weak self] news in
            guard let self = self else { return }
            self.news = news
            self.tableView.reloadData()
        }
        makeSection()
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .systemGray6
    }
    
    @objc func refreshNews() {
        
        newsRefreshControl.endRefreshing()
        apiService.getNews { [weak self] news in
            guard let self = self else { return }
            self.news = news
            self.tableView.reloadData()
        }
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
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.items?.count ?? 1
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let profiles = news.profiles,
              let groups = news.groups,
              let items = news.items else { return UITableViewCell() }
        if indexPath.row == 0 {
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
                        name = $0.name
                        string = $0.photo100
                    }
                }
            }
            guard let avatarString = URL(string: string!) else { return UITableViewCell() }
            let date = unixTimeConvertion(unixTimeInt: items[indexPath.section].date ?? 0)
            cell.configure(image: nil, date: date, name: name)
            cell.avatarImageView.sd_setImage(with: avatarString)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as! TextTableViewCell
            let newsText = items[indexPath.section].text ?? "Error"
            cell.configure(newsText: newsText)
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            guard let imageString = findURL(item: items[indexPath.section].attachments)
                else {
                    let cell = UITableViewCell()
                    cell.backgroundColor = .systemGray6
                    return cell }
            cell.newsImage.sd_setImage(with: imageString)
            cell.backgroundColor = .systemGray6
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UtilityTableViewCell", for: indexPath) as! UtilityTableViewCell
            let likes = String(items[indexPath.section].likes?.count ?? 0)
            let comments = String(items[indexPath.section].comments?.count ?? 0)
            let reposts = String(items[indexPath.section].reposts?.count ?? 0)
            let views = String(items[indexPath.section].views?.count ?? 0)
            cell.configure(likes: likes, comments: comments, reposts: reposts, views: views)
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeparatorTableViewCell", for: indexPath) as! SeparatorTableViewCell
            return cell
        } else {
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

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
