//
//  TableViewCell.h
//  PagingTest
//
//  Created by leon on 12/12/2018.
//  Copyright © 2018 LEON. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"


@interface TableViewCell : UITableViewCell

@property (nonatomic, weak, readonly) ContentView *content;

@end

