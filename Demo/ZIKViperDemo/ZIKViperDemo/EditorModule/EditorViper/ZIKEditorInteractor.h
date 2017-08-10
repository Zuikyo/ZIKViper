//
//  ZIKEditorInteractor.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ZIKViper/ZIKViperInteractor.h>
#import "ZIKEditorInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKEditorInteractorDataSource;
@protocol ZIKEditorInteractorEventHandler;
@interface ZIKEditorInteractor : NSObject <ZIKViperInteractor, ZIKEditorInteractorInput>
@property (nonatomic, weak) id<ZIKEditorInteractorDataSource> dataSource;
@property (nonatomic, weak) id<ZIKEditorInteractorEventHandler> eventHandler;

- (instancetype)initWithEditingNote:(nullable ZIKNoteModel *)note;

@end

NS_ASSUME_NONNULL_END
