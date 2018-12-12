//
//  TableViewCell.m
//  PagingTest
//
//  Created by leon on 12/12/2018.
//  Copyright © 2018 LEON. All rights reserved.
//

#import "TableViewCell.h"


@interface TableViewCell ()

@property (nonatomic, weak) ContentView *content;

@end


@implementation TableViewCell


- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initView];
    }
    return self;
}


- (void)initView {
    ContentView *contentView = ContentView.new;
    [self.contentView addSubview:contentView];
    _content = contentView;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.bounds = _content.bounds;
    _content.center = CGPointMake(self.contentView.bounds.size.width / 2, self.contentView.bounds.size.height / 2);
}


- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
