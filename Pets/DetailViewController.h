//
//  DetailViewController.h
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

