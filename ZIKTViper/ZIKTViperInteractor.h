//
//  ZIKTViperInteractor.h
//  ZIKTViper
//
//  Created by zuik on 2017/5/24.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKTViperInteractor <NSObject>
@property (nonatomic, readonly, weak) id dataSource;
@property (nonatomic, readonly, weak) id eventHandler;
@end

NS_ASSUME_NONNULL_END
