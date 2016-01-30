//
//  MessageViewController.swift
//  MessageKit
//
//  Created by ChenHao on 1/28/16.
//  Copyright © 2016 HarriesChen. All rights reserved.
//

import UIKit

public class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageTableView: MessageTableView!
    public var messageDataSource: MessageKitDataSource?
    public var messageDelegate: MessageKitDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    
        NSBundle(forClass: MessageViewController.self).loadNibNamed("MessageViewController", owner: self, options: nil)
        // Do any additional setup after loading the view.
        messageTableView.dataSource = self
        messageTableView.delegate = self
        
        messageDelegate = self
    }

    override public func didReceiveMemoryWarning() {
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
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = messageTableView.dequeueReusableCellWithIdentifier(MessageTextCellIncoming.cellIdentifer()) as! MessageTextCellIncoming
        
        let model = messageDataSource?.messageKitCcontroller(self, modelAtRow: indexPath.row)
        switch model {
        case is TextMessage:
            return configTextCellAtIndexPath(indexPath)
        default:
            break
        }
        
        return cell
    }
    
    public func configTextCellAtIndexPath(indexPath: NSIndexPath) -> MessageTextCell {
        let model = messageDataSource!.messageKitCcontroller(self, modelAtRow: indexPath.row)
        let textModel = model as! TextMessage
        if model.type == .Incoming {
            let cell = messageTableView.dequeueReusableCellWithIdentifier(MessageTextCellIncoming.cellIdentifer()) as! MessageTextCellIncoming
            cell.contentLabel.text = textModel.messageText
            cell.configWithBubbleColor(messageDelegate!.bubbleIncomingWithMessageKitCcontroller(self))
            return cell
        } else {
            let cell = messageTableView.dequeueReusableCellWithIdentifier(MessageTextCellOutcoming.cellIdentifer()) as! MessageTextCellOutcoming
            cell.contentLabel.text = textModel.messageText
            cell.configWithBubbleColor(messageDelegate!.bubbleOutcomingWithMessageKitCcontroller(self))
            return cell
        }
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageDataSource!.numberOfROwinMessageKitCcontroller(self)
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 36;
    }
}
