//
//  ZIKTLoginViewController.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ZIKTViper.ZIKTViperView;
#import "ZIKTLoginViewDelegate.h"
#import "ZIKTLoginViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZIKTLoginViewController : UIViewController <ZIKTViperView, ZIKTLoginViewProtocol>
@property (nonatomic, weak) id<ZIKTLoginViewDelegate> delegate;
@property (nonatomic, copy, nullable) NSString *message;
@end

NS_ASSUME_NONNULL_END
