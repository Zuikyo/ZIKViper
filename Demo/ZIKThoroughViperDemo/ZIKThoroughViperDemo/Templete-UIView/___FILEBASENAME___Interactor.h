//
//  ___FILEBASENAMEASIDENTIFIER___Interactor.h
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//
#import <Foundation/Foundation.h>
#import "ZIKViperInteractor.h"
#import "___FILEBASENAME___InteractorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ___FILEBASENAME___InteractorDataSource;
@protocol ___FILEBASENAME___InteractorEventHandler;
@interface ___FILEBASENAMEASIDENTIFIER___Interactor : NSObject <ZIKViperInteractor, ___FILEBASENAME___InteractorProtocol>
@property (nonatomic, weak) id<___FILEBASENAME___InteractorDataSource> dataSource;
@property (nonatomic, weak) id<___FILEBASENAME___InteractorEventHandler> eventHandler;
@end

NS_ASSUME_NONNULL_END
