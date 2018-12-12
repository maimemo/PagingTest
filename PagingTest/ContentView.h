//
//  ContentView.h
//  PagingTest
//
//  Created by leon on 12/12/2018.
//  Copyright © 2018 LEON. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContentView : UIView

@property (nonatomic, assign) CGSize preferredSize;
@property (nonatomic, weak, readonly) UILabel *titleLabel;
@property (nonatomic, weak, readonly) UILabel *nameLabel;
@property (nonatomic, weak, readonly) UILabel *timeLabel;
@property (nonatomic, weak, readonly) UITextView *textView;

@end


