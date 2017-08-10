//
//  ZIKTTextWidgetInteractor.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017年 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>
@import ZIKTViper.ZIKTViperInteractor;
#import "ZIKTTextWidgetInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKTTextWidgetInteractorDataSource;
@protocol ZIKTTextWidgetInteractorEventHandler;
@interface ZIKTTextWidgetInteractor : NSObject <ZIKTViperInteractor, ZIKTTextWidgetInteractorInput>
@property (nonatomic, weak) id<ZIKTTextWidgetInteractorDataSource> dataSource;
@property (nonatomic, weak) id<ZIKTTextWidgetInteractorEventHandler> eventHandler;
@end

NS_ASSUME_NONNULL_END
