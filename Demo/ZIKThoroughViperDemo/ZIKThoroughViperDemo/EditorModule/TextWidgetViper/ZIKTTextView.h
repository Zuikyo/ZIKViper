//
//  ZIKTTextView.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ZIKTViper.ZIKTViperView;
#import "ZIKTTextWidgetViewProtocol.h"

@protocol ZIKTTextViewDataSource;
@interface ZIKTTextView : UITextView <ZIKTViperView,ZIKTTextWidgetViewProtocol>
@property (nonatomic, weak) id<ZIKTTextViewDataSource> dataSource;
@property (nonatomic, strong) UIColor *colorForCopyright;

- (void)setPrefixText:(NSString *)prefix;
@end
