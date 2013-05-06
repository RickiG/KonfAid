//
//  MainViewController.h
//  KonfAid
//
//  Created by Ricki Gregersen on 5/3/13.
//  Copyright (c) 2013 Ricki Gregersen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITabBarControllerDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
