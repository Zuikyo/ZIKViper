//
//  ZIKLoginViewController.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZIKViper/ZIKViperView.h>
#import "ZIKLoginViewDelegate.h"
#import "ZIKLoginViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZIKLoginViewController : UIViewController <ZIKViperView, ZIKLoginViewProtocol>
@property (nonatomic, weak) id<ZIKLoginViewDelegate> delegate;
@property (nonatomic, copy, nullable) NSString *message;
@end

NS_ASSUME_NONNULL_END
