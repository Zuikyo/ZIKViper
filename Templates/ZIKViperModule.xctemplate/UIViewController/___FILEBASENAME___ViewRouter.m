//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___VARIABLE_productName___ViewRouter.h"
#import <ZIKRouter/ZIKRouterInternal.h>
#import <ZIKRouter/ZIKViewRouterInternal.h>
#import <ZIKViper/ZIKViper.h>
#import "___VARIABLE_productName___ViewController.h"
#import "___VARIABLE_productName___ViewPresenter.h"
#import "___VARIABLE_productName___Interactor.h"
//#import "___VARIABLE_productName___ViewInput.h"

/*
@implementation ___VARIABLE_productName___ViewRouteConfiguration
 
 - (id)copyWithZone:(nullable NSZone *)zone {
     ___VARIABLE_productName___ViewRouteConfiguration *config = [super copyWithZone:zone];
 
 }
 
@end
 */

@interface ___VARIABLE_productName___ViewController (___VARIABLE_productName___ViewRouter) <ZIKRoutableView>
@end
@implementation ___VARIABLE_productName___ViewController (___VARIABLE_productName___ViewRouter)
@end

@interface ___VARIABLE_productName___ViewRouter ()

@end

@implementation ___VARIABLE_productName___ViewRouter

+ (void)registerRoutableDestination {
    [self registerExclusiveView:[___VARIABLE_productName___ViewController class]];
    //[self registerView:[___VARIABLE_productName___ViewController class]];
    //[self registerViewProtocol:ZIKRoutableProtocol(___VARIABLE_productName___ViewInput)];
    //[self registerModuleProtocol:ZIKRoutableProtocol(___VARIABLE_productName___ConfigInput)];
}

- (nullable ___VARIABLE_productName___ViewController *)destinationWithConfiguration:(ZIKViewRouteConfiguration *)configuration {
#error Create destination
    //create your view, and initialize it with configuration. return nil if configuration is invalid.
    ___VARIABLE_productName___ViewController *destination = ;
    
    return destination;
}

- (void)prepareDestination:(___VARIABLE_productName___ViewController *)destination configuration:(__kindof ZIKViewRouteConfiguration *)configuration {
    NSParameterAssert([destination isKindOfClass:[___VARIABLE_productName___ViewController class]]);
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
    ___VARIABLE_productName___ViewPresenter *presenter = [[___VARIABLE_productName___ViewPresenter alloc] init];
    ___VARIABLE_productName___Interactor *interactor = [[___VARIABLE_productName___Interactor alloc] init];
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

/*
 // Return your custom configuration
+ (ZIKViewRouteConfiguration *)defaultRouteConfiguration {
    return [[___VARIABLE_productName___ViewRouteConfiguration alloc] init];
}
 */

@end
