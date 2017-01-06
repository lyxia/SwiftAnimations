//
//  ViewController.swift
//  LYXWaveAnimation
//
//  Created by lyxia on 2017/1/6.
//  Copyright © 2017年 lyxia. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var waveView: WaveView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 245))
        headView.backgroundColor = UIColor(colorLiteralRed: 164.0/255.0, green: 174.0/255.0, blue: 246.0/255.0, alpha: 1)
        waveView = WaveView(frame: CGRect(x: 0, y: headView.bounds.height - 4.5, width: headView.bounds.width, height: 5))
        headView.addSubview(waveView)
        self.tableView.tableHeaderView = headView
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //波动
        waveView.wave()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell!.textLabel?.text = "\(arc4random() % 100)"
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

