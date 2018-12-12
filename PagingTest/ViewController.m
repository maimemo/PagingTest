//
//  ViewController.m
//  PagingTest
//
//  Created by leon on 12/12/2018.
//  Copyright © 2018 LEON. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "DataModel.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak  ) IBOutlet UITableView *tableView;
@property (nonatomic, weak  ) IBOutlet UILabel *label;
@property (nonatomic, strong) NSArray <DataModel *> *models;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) ContentView *prototype;

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _prototype = ContentView.new;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(TableViewCell.class) bundle:nil]
     forCellReuseIdentifier:NSStringFromClass(TableViewCell.class)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsSelection = NO;
    _tableView.separatorColor = UIColor.darkGrayColor;
    _tableView.hidden = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.models =
        [self.class.randomModels sortedArrayUsingComparator:^NSComparisonResult(DataModel *obj1, DataModel *obj2) {
            return [obj1.date compare:obj2.date];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.hidden = NO;
            self.label.hidden = YES;
            [self.tableView reloadData];
        });
    });
}


#pragma mark -


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    _prototype.preferredSize = tableView.bounds.size;
    [self configureContentView:_prototype withModel:_models[indexPath.row]];
    [_prototype setNeedsLayout];
    [_prototype layoutIfNeeded];
    return _prototype.bounds.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TableViewCell.class) forIndexPath:indexPath];
    cell.content.preferredSize = tableView.bounds.size;
    [self configureContentView:cell.content withModel:_models[indexPath.row]];
    return cell;
}


- (void)configureContentView:(ContentView *)contentView withModel:(DataModel *)model {
    contentView.titleLabel.text = model.title;
    contentView.textView.attributedText = [[NSAttributedString alloc] initWithString:model.content
                                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],
                                                                                       NSForegroundColorAttributeName : UIColor.darkGrayColor}];
    contentView.nameLabel.text = model.author;
    if (!_formatter) {
        _formatter = NSDateFormatter.new;
        _formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    contentView.timeLabel.text = [_formatter stringFromDate:model.date];
    [contentView setNeedsLayout];
    [contentView layoutIfNeeded];
}


#pragma mark -


+ (NSArray <DataModel *> *)randomModels {
    NSMutableArray <DataModel *> *models = NSMutableArray.array;
    for (int i = 0; i < 300; i++) {
        [models addObject:self.randomModel];
    }
    return models;
}


+ (DataModel *)randomModel {
    DataModel *model = DataModel.new;
    model.title   = [self randomStringWithLength:arc4random_uniform(50) + 80];
    model.content = [self randomStringWithLength:arc4random_uniform(2000) + 1000];
    model.author  = [self randomStringWithLength:arc4random_uniform(10) + 8];
    model.date    = [NSDate.date dateByAddingTimeInterval:(NSTimeInterval)arc4random_uniform(60 * 60 * 24 * 30) * (arc4random_uniform(2) % 2 == 0 ? 1 : -1)];
    return model;
}


+ (NSString *)randomStringWithLength:(int)length {
    NSMutableString *string = NSMutableString.string;
    BOOL cap = NO;
    for (int i = 0; i < length; i++) {
        if (arc4random_uniform(8) > 6) {
            [string appendFormat:@" "];
            cap = YES;
        } else {
            char ran = arc4random_uniform(26) + (cap || i == 0 || arc4random_uniform(2) % 2 == 0 ? 65 : 97);
            [string appendFormat:@"%c", ran];
            cap = NO;
        }
    }
    return string;
}


@end

