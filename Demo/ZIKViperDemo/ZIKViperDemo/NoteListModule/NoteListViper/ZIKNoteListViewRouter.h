//
//  ZIKNoteListViewRouter
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

@import ZIKRouter;
#import <ZIKViper/ZIKViperRouter.h>

NS_ASSUME_NONNULL_BEGIN

DeclareRoutableViewProtocol(ZIKNoteListViewProtocol, ZIKNoteListViewRouter)

@interface ZIKNoteListViewRouter : ZIKViewRouter <ZIKViewRouterProtocol,ZIKViperRouter>

@end

NS_ASSUME_NONNULL_END
