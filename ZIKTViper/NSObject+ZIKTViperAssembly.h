//
//  NSObject+ZIKTViperAssembly.h
//  ZIKTViper
//
//  Created by zuik on 2017/8/10.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZIKTViperViewPrivate,ZIKTViperPresenterPrivate,ZIKTViperInteractorPrivate,ZIKTViperWireframePrivate,ZIKTViperRouter;
@interface NSObject (ZIKTViperAssembly)

+ (void)assembleViperForView:(id<ZIKTViperViewPrivate>)view
                   presenter:(id<ZIKTViperPresenterPrivate>)presenter
                  interactor:(id<ZIKTViperInteractorPrivate>)interactor
                   wireframe:(id<ZIKTViperWireframePrivate>)wireframe
                      router:(id<ZIKTViperRouter>)router;

@end
