//
//  ZIKEditorViewRouter
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKEditorViewRouter.h"
@import ZIKRouter.Private;
#import <ZIKViper/ZIKViper.h>

#import "ZIKEditorViewController.h"
#import "ZIKEditorViewPresenter.h"
#import "ZIKEditorInteractor.h"
#import "ZIKEditorViewProtocol.h"


@interface ZIKEditorViewConfiguration ()
@property (nonatomic, assign) ZIKEditorMode editMode;
@property (nonatomic, strong, nullable) ZIKNoteModel *noteToModify;
@end

@implementation ZIKEditorViewConfiguration

- (void)constructForCreatingNewNote {
    self.editMode = ZIKEditorModeCreate;
}

- (void)constructForModifyingNote:(ZIKNoteModel *)note {
    NSParameterAssert(note);
    self.editMode = ZIKEditorModeModify;
    self.noteToModify = note;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    ZIKEditorViewConfiguration *config = [super copyWithZone:zone];
    config.previewing = self.previewing;
    config.delegate = self.delegate;
    config.editMode = self.editMode;
    config.noteToModify = self.noteToModify;
    return config;
}

@end

@interface ZIKEditorViewController (ZIKEditorViewRouter) <ZIKRoutableView>
@end
@implementation ZIKEditorViewController (ZIKEditorViewRouter)
@end

@interface ZIKEditorViewRouter ()

@end

@implementation ZIKEditorViewRouter

+ (void)registerRoutableDestination {
    ZIKViewRouter_registerView([ZIKEditorViewController class], self);
    ZIKViewRouter_registerConfigProtocol(@protocol(ZIKEditorConfigProtocol), self);
}

- (UIViewController *)destinationWithConfiguration:(ZIKEditorViewConfiguration *)configuration {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZIKEditorViewController *destination = [sb instantiateViewControllerWithIdentifier:@"ZIKEditorViewController"];
    
    //create your viewController, and initialize it with configuration
    if (configuration.editMode == ZIKEditorModeModify &&
        configuration.noteToModify == nil) {
        return nil;
    }
    return destination;
}

+ (BOOL)destinationPrepared:(id)destination {
    if ([destination delegate] == nil) {
        return NO;
    }
    return YES;
}

- (void)prepareDestination:(ZIKEditorViewController *)destination configuration:(ZIKEditorViewConfiguration *)configuration {
    NSParameterAssert([destination isKindOfClass:[ZIKEditorViewController class]]);
    NSParameterAssert([destination conformsToProtocol:@protocol(ZIKViperViewPrivate)]);
    
    id<ZIKEditorViewProtocol> editor = destination;
    editor.delegate = configuration.delegate;
    editor.editMode = configuration.editMode;
    
    if (![self isViperAssembled]) {
        [self assembleViper];
    } else {
        [self attachRouter];
    }
    ZIKEditorViewPresenter *presenter = (id)destination.eventHandler;
    presenter.previewing = configuration.previewing;
}

#pragma mark Viper assembly

- (void)assembleViper {
    ZIKEditorViewConfiguration *config = self._nocopy_configuration;
    id<ZIKViperViewPrivate> view = self.destination;
    NSAssert(view, @"Can't assemble viper when view is nil");
    ZIKEditorViewPresenter *presenter = [[ZIKEditorViewPresenter alloc] init];
    ZIKEditorInteractor *interactor = [[ZIKEditorInteractor alloc] initWithEditingNote:config.noteToModify];
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

+ (__kindof ZIKViewRouteConfiguration *)defaultRouteConfiguration {
    return [ZIKEditorViewConfiguration new];
}

@end
