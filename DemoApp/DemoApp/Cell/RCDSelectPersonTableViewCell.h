//
//  RCDSelectPersonTableViewCell.h
//  DemoApp
//
//  Created by 许卓权 on 15/10/6.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCDSelectPersonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ivSelected;
@property (weak, nonatomic) IBOutlet UIImageView *ivAva;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end