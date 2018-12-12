//
//  DataModel.h
//  PagingTest
//
//  Created by leon on 12/12/2018.
//  Copyright © 2018 LEON. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModel : NSObject

@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *content;
@property (nonatomic, copy  ) NSString *author;
@property (nonatomic, strong) NSDate *date;

@end

