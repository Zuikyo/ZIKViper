//
//  ZIKNoteListInteractor
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ZIKViper/ZIKViperInteractor.h>
#import "ZIKNoteListInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@class ZIKNoteModel;
@interface ZIKNoteListInteractor : NSObject <ZIKViperInteractor, ZIKNoteListInteractorInput>
@property (nonatomic, weak) id dataSource;
@property (nonatomic, weak) id eventHandler;
- (void)loadAllNotes;
@end

NS_ASSUME_NONNULL_END
