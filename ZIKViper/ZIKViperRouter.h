//
//  ZIKViperRouter.h
//  ZIKViper
//
//  Created by zuik on 2017/5/31.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZIKViperView;
@protocol ZIKViperPresenter;
@protocol ZIKViperInteractor;

@protocol ZIKViperRouter <NSObject>
- (void)assembleViper;
- (void)assembleViperForView:(id<ZIKViperView>)view
                   presenter:(id<ZIKViperPresenter>)presenter
                  interactor:(id<ZIKViperInteractor>)interactor;
@optional
@property (nonatomic, readonly, weak) id<ZIKViperPresenter> presenter;
@end
