//
//  ZIKTextWidgetInteractor.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ZIKViper/ZIKViperInteractor.h>
#import "ZIKTextWidgetInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKTextWidgetInteractorDataSource;
@protocol ZIKTextWidgetInteractorEventHandler;
@interface ZIKTextWidgetInteractor : NSObject <ZIKViperInteractor, ZIKTextWidgetInteractorInput>
@property (nonatomic, weak) id<ZIKTextWidgetInteractorDataSource> dataSource;
@property (nonatomic, weak) id<ZIKTextWidgetInteractorEventHandler> eventHandler;
@end

NS_ASSUME_NONNULL_END
