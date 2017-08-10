//
//  ZIKTViperWireframePrivate.h
//  ZIKTViper
//
//  Created by zuik on 2017/8/3.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIKTViperWireframe.h"
#import "ZIKTViperRouter.h"

@protocol ZIKTViperWireframePrivate <ZIKTViperWireframe>
- (void)setView:(id<ZIKTViperView>)view;
- (id<ZIKTViperRouter>)router;
- (void)setRouter:(id<ZIKTViperRouter>)router;
@end
