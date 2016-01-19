//
//  FilterViewController.swift
//  camera app
//
//  Created by MacBook Pro on 1/18/16.
//  Copyright © 2016 Peter Flanagan. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCellWithIdentifier("filterReuseID", forIndexPath: indexPath) as? FilterTableViewCell else {
                return UITableViewCell()
            }
        
            let filter = self.filters[indexPath.item]
            cell.filterImageView.image = UIImage(contentsOfFile: filter.path)
            cell.filterNameLabel.text = filter.filterName
        
            return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection
                section: Int) -> Int {
                return self.filters.count
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var filteredImage: UIImage?
    
    private var sourcePrefix : String?
    private var filters : [(filterName: String, path: String)] =
    [(filterName: String, path: String)]()
    private let filterManager : ImageFilterManager = ImageFilterManager()
    var sourceImage : UIImage? {
        
        didSet {
        
            self.sourcePrefix = NSUUID().UUIDString
            filterManager.createFiltersForImage(self.sourceImage!, filePrefix: self.sourcePrefix!) { (filters) -> Void in
        
                self.filters = filters
        
                self.tableView.reloadData()
        
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:
        AnyObject?) {
        if segue.identifier == "FilterSelectedSegue" {
        if let indexPath = self.tableView.indexPathForSelectedRow {
        
        let filter = self.filters[indexPath.item]
        
        self.filteredImage = UIImage(contentsOfFile: filter.path)
        }
    }
}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
