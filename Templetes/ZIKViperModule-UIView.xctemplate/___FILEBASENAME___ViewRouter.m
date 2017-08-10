//
//  ___FILEBASENAMEASIDENTIFIER___ViewRouter.m
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___ViewRouter.h"
#import <ZIKRouter/ZIKRouter+Private.h>
#import <ZIKRouter/ZIKViewRouter+Private.h>
#import <ZIKViper/ZIKViper.h>
#import "___FILEBASENAME___View.h"
#import "___FILEBASENAME___ViewPresenter.h"
#import "___FILEBASENAME___Interactor.h"
//#import "___FILEBASENAME___ViewInput.h"

RegisterRoutableViewForExclusiveRouter(___FILEBASENAMEASIDENTIFIER___View, ___FILEBASENAMEASIDENTIFIER___ViewRouter)
//RegisterRoutableViewProtocol(___FILEBASENAME___ViewInput, ___FILEBASENAMEASIDENTIFIER___ViewRouter)

/*
 //RegisterRoutableViewConfigProtocol(___FILEBASENAME___ConfigProtocol, ___FILEBASENAMEASIDENTIFIER___ViewRouter)
@implementation ___FILEBASENAMEASIDENTIFIER___ViewRouteConfiguration
 
 - (id)copyWithZone:(nullable NSZone *)zone {
     ___FILEBASENAMEASIDENTIFIER___ViewRouteConfiguration *config = [super copyWithZone:zone];
 
 }
 
@end
 */

@interface ___FILEBASENAMEASIDENTIFIER___ViewRouter ()

@end

@implementation ___FILEBASENAMEASIDENTIFIER___ViewRouter

- (nullable ___FILEBASENAMEASIDENTIFIER___View *)destinationWithConfiguration:(ZIKViewRouteConfiguration *)configuration {
#error create destination
    //create your view, and initialize it with configuration. Return nil if configuration is invalid.
    ___FILEBASENAMEASIDENTIFIER___View *destination;
    
    return destination;
}

- (void)prepareDestination:(___FILEBASENAMEASIDENTIFIER___View *)destination configuration:(__kindof ZIKViewRouteConfiguration *)configuration {
    NSParameterAssert([destination isKindOfClass:[___FILEBASENAMEASIDENTIFIER___View class]]);
    NSParameterAssert([destination conformsToProtocol:@protocol(ZIKViperViewPrivate)]);
    if (![self isViperAssembled]) {
        [self assembleViper];
    } else {
        [self attachRouter];
    }
}

#pragma mark Viper assembly

- (void)assembleViper {
    id<ZIKViperViewPrivate> view = self.destination;
    NSAssert(view, @"Can't assemble viper when view is nil");
    NSAssert([self isViperAssembled] == NO, @"Already assembled");
    ___FILEBASENAMEASIDENTIFIER___ViewPresenter *presenter = [[___FILEBASENAMEASIDENTIFIER___ViewPresenter alloc] init];
    ___FILEBASENAMEASIDENTIFIER___Interactor *interactor = [[___FILEBASENAMEASIDENTIFIER___Interactor alloc] init];
    NSParameterAssert([view conformsToProtocol:@protocol(ZIKViperViewPrivate)]);
    NSParameterAssert([presenter conformsToProtocol:@protocol(ZIKViperPresenterPrivate)]);
    NSParameterAssert([interactor conformsToProtocol:@protocol(ZIKViperInteractorPrivate)]);
    [self assembleViperForView:view
                     presenter:(id<ZIKViperPresenterPrivate>)presenter
                    interactor:(id<ZIKViperInteractorPrivate>)interactor];
}

- (void)attachRouter {
    id<ZIKViperViewPrivate> view = self.destination;
    NSAssert(view, @"Can't assemble viper when view is nil");
    [self attachRouterForView:view];
}

#pragma mark AOP

+ (void)router:(ZIKViewRouter *)router willPerformRouteOnDestination:(id)destination fromSource:(id)source {
    NSAssert([ZIKViewRouter isViperAssembledForView:destination], @"Viper should be assembled");
}

+ (NSArray<NSNumber *> *)supportedRouteTypes {
    return kDefaultRouteTypesForView;
}

/*
 // Return your custom configuration
+ (ZIKViewRouteConfiguration *)defaultRouteConfiguration {
    return [[___FILEBASENAMEASIDENTIFIER___ViewRouteConfiguration alloc] init];
}
 */

@end
