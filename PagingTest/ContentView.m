//
//  ContentView.m
//  PagingTest
//
//  Created by leon on 12/12/2018.
//  Copyright © 2018 LEON. All rights reserved.
//

#import "ContentView.h"


@interface ContentView ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;

@end


@implementation ContentView


- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initViews];
    }
    return self;
}


- (void)initViews {
    UILabel *(^makeLabel)(void) = ^ {
        UILabel *label = UILabel.new;
        label.textAlignment = NSTextAlignmentLeft;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = UIColor.lightGrayColor;
        label.backgroundColor = UIColor.clearColor;
        return label;
    };
    UILabel *titleLabel = makeLabel();
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;

    UILabel *timeLabel = makeLabel();
    [self addSubview:timeLabel];
    _timeLabel = timeLabel;

    UILabel *nameLabel = makeLabel();
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;

    UITextView *textView = UITextView.new;
    textView.textContainer.lineFragmentPadding = 0;
    textView.textContainerInset = UIEdgeInsetsZero;
    textView.scrollEnabled = NO;
    textView.editable = NO;
    textView.selectable = NO;
    textView.backgroundColor = UIColor.clearColor;
    [self addSubview:textView];
    _textView = textView;

    for (UIView *subview in self.subviews) {
        subview.translatesAutoresizingMaskIntoConstraints = YES;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat horizontalMargin = 15;
    CGFloat verticalMargin = 15;
    CGSize textSize;
    textSize = [_titleLabel sizeThatFits:CGSizeMake(_preferredSize.width - 2 * horizontalMargin, MAXFLOAT)];
    _titleLabel.frame = CGRectMake(horizontalMargin, verticalMargin, textSize.width, textSize.height);
    if (_textView.attributedText) {
        textSize = [_textView.attributedText boundingRectWithSize:CGSizeMake(_preferredSize.width - 2 * horizontalMargin, MAXFLOAT)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                 context:nil].size;
        _textView.frame = CGRectMake(horizontalMargin, CGRectGetMaxY(_titleLabel.frame) + 15, textSize.width, textSize.height);
    } else {
        textSize = [_textView sizeThatFits:CGSizeMake(_preferredSize.width - 2 * horizontalMargin, MAXFLOAT)];
        _textView.frame = CGRectMake(horizontalMargin, CGRectGetMaxY(_titleLabel.frame) + 15, textSize.width, textSize.height);
    }

    textSize = [_nameLabel sizeThatFits:CGSizeMake(_preferredSize.width - 2 * horizontalMargin, MAXFLOAT)];
    _nameLabel.frame = CGRectMake(horizontalMargin, CGRectGetMaxY(_textView.frame) + 15, textSize.width, textSize.height);

    textSize = [_timeLabel sizeThatFits:CGSizeMake(_preferredSize.width - 2 * horizontalMargin, MAXFLOAT)];
    _timeLabel.frame = CGRectMake(_preferredSize.width - horizontalMargin - textSize.width, _nameLabel.frame.origin.y, textSize.width, textSize.height);

    self.bounds = CGRectMake(0, 0, _preferredSize.width, MAX(CGRectGetMaxY(_timeLabel.frame) + verticalMargin, _preferredSize.height));
}


@end
