//
//  ZIKTViperWireframe.h
//  ZIKTViper
//
//  Created by zuik on 2017/8/2.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZIKTViperView;
@protocol ZIKTViperWireframe <NSObject>
@property (nonatomic, readonly, weak) id<ZIKTViperView> view;
@end
