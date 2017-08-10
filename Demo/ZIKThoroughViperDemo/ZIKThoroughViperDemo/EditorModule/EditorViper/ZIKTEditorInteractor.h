//
//  ZIKTEditorInteractor.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017年 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>
@import ZIKTViper.ZIKTViperInteractor;
#import "ZIKTEditorInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKTEditorInteractorDataSource;
@protocol ZIKTEditorInteractorEventHandler;
@interface ZIKTEditorInteractor : NSObject <ZIKTViperInteractor, ZIKTEditorInteractorInput>
@property (nonatomic, weak) id<ZIKTEditorInteractorDataSource> dataSource;
@property (nonatomic, weak) id<ZIKTEditorInteractorEventHandler> eventHandler;

- (instancetype)initWithEditingNote:(nullable ZIKTNoteModel *)note;

@end

NS_ASSUME_NONNULL_END
