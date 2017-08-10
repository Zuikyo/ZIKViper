//
//  ZIKTTextViewDataSource.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/18.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZIKTTextView;
@protocol ZIKTTextViewDataSource <NSObject>
- (NSString *)prefixStringForTextView:(ZIKTTextView *)textView;
@end
