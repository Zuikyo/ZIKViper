//
//  ZIKNoteListViewPresenter
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ZIKViper/ZIKViperPresenter.h>
#import "ZIKNoteListViewEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZIKNoteListViewPresenter : NSObject <ZIKViperPresenter,ZIKNoteListViewEventHandler>
@property (nonatomic, strong) id wireframe;
@end

NS_ASSUME_NONNULL_END
