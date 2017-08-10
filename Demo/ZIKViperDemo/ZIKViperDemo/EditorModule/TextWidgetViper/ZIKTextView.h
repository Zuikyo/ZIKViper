//
//  ZIKTextView.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZIKViper/ZIKViperView.h>
#import "ZIKTextWidgetViewProtocol.h"

@protocol ZIKTextViewDataSource;
@interface ZIKTextView : UITextView <ZIKViperView,ZIKTextWidgetViewProtocol>
@property (nonatomic, weak) id<ZIKTextViewDataSource> dataSource;
@property (nonatomic, strong) UIColor *colorForCopyright;

@end
