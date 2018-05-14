//
//  ViewController.swift
//  DEMO Project
//
//  Created by Johnny Wang on 2018/5/10.
//  Copyright © 2018年 Johnny Wang. All rights reserved.
//

import UIKit

enum itemType: String {
    case like = "like"
    case love = "love"
    case haha = "haha"
    case ouch = "ouch"
}

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    var animator: UIDynamicAnimator?
    var gravity = UIGravityBehavior()
    var collision = UICollisionBehavior()
    var behavior = UIDynamicItemBehavior()
    var collisionCount = 0
    
    @IBAction func onLikeItemClicked(_ sender: Any) {
        addBehaviour(item: .like)
    }
    
    @IBAction func onLoveItemClicked(_ sender: Any) {
        addBehaviour(item: .love)
    }
    
    @IBAction func onHahaItemClicked(_ sender: Any) {
        addBehaviour(item: .haha)
    }
    
    @IBAction func onOuchItemClicked(_ sender: Any) {
        addBehaviour(item: .ouch)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setBackgroundImage()
        setDynamicBehavior()
    }
   
    private func setBackgroundImage() {
        view.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "wallpaper"))
    }

    private func setDynamicBehavior() {
        animator = UIDynamicAnimator(referenceView: contentView)

        animator?.addBehavior(gravity)

        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionDelegate = self
        animator?.addBehavior(collision)
        
        behavior = UIDynamicItemBehavior()
        behavior.elasticity = 0.7       //反彈係數
        behavior.friction = 0.3         //摩擦力
        behavior.resistance = 0.1       //阻力
        behavior.allowsRotation = true  //旋轉
        animator?.addBehavior(behavior)
    }
    
    private func addBehaviour(item: itemType) {
        let size = CGSize(width: 60.0, height: 60.0)
        let startPoint = CGPoint(x: 65.0, y: 65.0)
        
        let imageView = UIImageView(image: UIImage(named: item.rawValue))
        imageView.frame = CGRect(origin: startPoint, size: size)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = size.width / 2.0
        contentView.addSubview(imageView)
        
        gravity.addItem(imageView)
        collision.addItem(imageView)
        behavior.addItem(imageView)
        
        let pushBehaviour = UIPushBehavior(items: [imageView], mode: .instantaneous)
        pushBehaviour.pushDirection = CGVector(dx: 2.5, dy: 1.5)
        animator?.addBehavior(pushBehaviour)
    }
    
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        collisionCount += 1
        countLabel.text = String(collisionCount)
    }
}

