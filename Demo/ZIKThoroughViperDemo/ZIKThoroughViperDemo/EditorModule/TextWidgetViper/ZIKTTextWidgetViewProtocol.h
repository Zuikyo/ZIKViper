//
//  ZIKTTextWidgetViewProtocol.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017年 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ZIKTTextViewDataSource.h"

@protocol ZIKTTextWidgetViewProtocol <NSObject>
@property (nonatomic, weak) id<ZIKTTextViewDataSource> dataSource;
@property (nonatomic, strong) UIColor *colorForCopyright;
- (void)setPrefixText:(NSString *)prefix;
@end
