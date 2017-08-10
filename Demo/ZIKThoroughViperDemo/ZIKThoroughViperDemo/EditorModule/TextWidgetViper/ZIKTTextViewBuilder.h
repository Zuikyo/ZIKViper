//
//  ZIKTTextViewBuilder.h
//  ZIKthoroughViperDemo
//
//  Created by zuik on 2017/8/3.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZIKTTextViewDataSource,ZIKTViperViewPrivate,ZIKTViperRouter;
@interface ZIKTTextViewBuilder : NSObject

+ (UIView *)viewWithPrefixText:(NSString *)prefix colorForCopyright:(UIColor *)color dataSource:(id<ZIKTTextViewDataSource>)dataSource router:(id<ZIKTViperRouter>)router;
+ (void)buildView:(id<ZIKTViperViewPrivate>)view router:(id<ZIKTViperRouter>)router;

@end
