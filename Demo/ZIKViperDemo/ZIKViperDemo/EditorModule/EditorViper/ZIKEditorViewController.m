//
//  ZIKEditorViewController
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKEditorViewController.h"
#import <ZIKViper/ZIKViperViewPrivate.h>
#import <ZIKRouter/UIViewController+ZIKViewRouter.h>
#import "ZIKEditorViewEventHandler.h"
#import "ZIKEditorViewDataSource.h"
#import "ZIKTextWidgetViewProtocol.h"
#import "ZIKTextViewDataSource.h"

@interface ZIKEditorViewController () <ZIKViperViewPrivate,ZIKTextViewDataSource>
@property (nonatomic, strong) id<ZIKEditorViewEventHandler> eventHandler;
@property (nonatomic, strong) id<ZIKEditorViewDataSource> viewDataSource;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@end

@implementation ZIKEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Editor";
}

- (UIViewController *)routeSource {
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.ZIK_routed == NO) {
        NSAssert([self.eventHandler conformsToProtocol:@protocol(ZIKEditorViewEventHandler)], nil);
        UIBarButtonItem *addNoteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                     target:self.eventHandler
                                                                                     action:@selector(didTouchNavigationBarDoneButton)];
        self.navigationItem.rightBarButtonItem = addNoteItem;
        
        //Note: in -viewWillAppear:, if this view controller contains sub routable UIView added from external (addSubview:, storyboard or xib), it may not be ready yet. The UIView has to search the UIViewController with -nextResponder to prepare itself, nextResponder can only be gained after -willMoveToWindow:. But -willMoveToWindow: may not be called yet in -viewWillAppear:. If the subview is not ready, config the subview in -handleViewReady may fail. If you can make sure there is no sub routable UIView or the subview is added with router before -viewWillAppear:, you can do -handleViewReady in -viewWillAppear:.
        if ([self.eventHandler respondsToSelector:@selector(handleViewReady)]) {
            [self.eventHandler handleViewReady];
        }
    }
    if ([self.eventHandler respondsToSelector:@selector(handleViewWillAppear:)]) {
        [self.eventHandler handleViewWillAppear:animated];
    };
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewDidAppear:)]) {
        [self.eventHandler handleViewDidAppear:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewWillDisappear:)]) {
        [self.eventHandler handleViewWillDisappear:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewDidDisappear:)]) {
        [self.eventHandler handleViewDidDisappear:animated];
    }
    if (self.ZIK_routed == NO) {
        if ([self.eventHandler respondsToSelector:@selector(handleViewRemoved)]) {
            [self.eventHandler handleViewRemoved];
        }
    }
}

- (nullable NSString *)titleString {
    return self.titleTextField.text;
}

- (nullable NSString *)contentString {
    return self.contentTextView.text;
}

- (void)updateTitleString:(NSString *)title {
    self.titleTextField.text = title;
}

- (void)updateContentString:(NSString *)content {
    self.contentTextView.text = content;
}

#pragma mark ZIKTextViewDataSource

- (NSString *)prefixStringForTextView:(ZIKTextView *)textView {
    return [self.viewDataSource prefixStringForTextView];
}

- (BOOL)previewing {
    return [self.eventHandler previewing];
}

#pragma mark Route

 ///Prepare sub modules
- (void)prepareForDestinationRoutingFromExternal:(id)destination configuration:(__kindof ZIKViewRouteConfiguration *)configuration {
    if ([destination conformsToProtocol:@protocol(ZIKTextWidgetViewProtocol)]) {
        //Prepare
        id<ZIKTextWidgetViewProtocol> textView = destination;
        textView.colorForCopyright = [UIColor grayColor];
        //Config dependencies between presenter, you can alse let presenter to pass the interactor as sub module's dependency
        textView.dataSource = self;
        return;
    }
    NSAssert(NO, @"Can't prepare for unknown destination.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
