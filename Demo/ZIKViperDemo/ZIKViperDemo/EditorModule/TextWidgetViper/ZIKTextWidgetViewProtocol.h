//
//  ZIKTextWidgetViewProtocol.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ZIKTextViewDataSource.h"

@protocol ZIKTextWidgetViewProtocol <NSObject>
@property (nonatomic, weak) id<ZIKTextViewDataSource> dataSource;
@property (nonatomic, strong) UIColor *colorForCopyright;
- (void)setPrefixText:(NSString *)prefix;
@end
