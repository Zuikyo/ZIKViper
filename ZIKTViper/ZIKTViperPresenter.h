//
//  ZIKTViperPresenter.h
//  ZIKTViper
//
//  Created by zuik on 2017/5/24.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIKTViperViewEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKTViperView;

@protocol ZIKTViperPresenter <ZIKTViperViewEventHandler>
///UIViewController or UIView, conform to view protocol
@property (nonatomic, readonly, weak) id<ZIKTViperView> view;
@end

NS_ASSUME_NONNULL_END
