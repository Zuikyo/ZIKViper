//
//  ZIKTNoteListViewPresenter
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017年 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>
@import ZIKTViper.ZIKTViperPresenter;
#import "ZIKTNoteListViewEventHandler.h"
#import "ZIKTNoteListViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZIKTNoteListViewPresenter : NSObject <ZIKTViperPresenter,ZIKTNoteListViewEventHandler,ZIKTNoteListViewDataSource>

@end

NS_ASSUME_NONNULL_END
