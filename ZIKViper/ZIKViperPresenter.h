//
//  ZIKViperPresenter.h
//  ZIKViper
//
//  Created by zuik on 2017/5/24.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIKViperViewEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKViperView;

@protocol ZIKViperPresenter <ZIKViperViewEventHandler>
///UIViewController or UIView, conform to view protocol
@property (nonatomic, readonly, weak) id<ZIKViperView> view;
@end

NS_ASSUME_NONNULL_END
