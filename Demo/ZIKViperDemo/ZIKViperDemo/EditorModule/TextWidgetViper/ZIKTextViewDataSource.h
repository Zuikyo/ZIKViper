//
//  ZIKTextViewDataSource.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/18.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZIKTextView;
@protocol ZIKTextViewDataSource <NSObject>
- (NSString *)prefixStringForTextView:(ZIKTextView *)textView;
- (BOOL)previewing;
@end
