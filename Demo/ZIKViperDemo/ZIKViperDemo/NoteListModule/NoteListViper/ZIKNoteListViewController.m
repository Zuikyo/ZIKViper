//
//  ZIKNoteListViewController
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKNoteListViewController.h"
#import <ZIKViper/ZIKViperViewPrivate.h>
#import <ZIKRouter/UIViewController+ZIKViewRouter.h>
#import "ZIKNoteListViewEventHandler.h"
#import "ZIKNoteListViewDataSource.h"

@interface ZIKNoteListViewController () <ZIKViperViewPrivate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) id<ZIKNoteListViewEventHandler> eventHandler;
@property (nonatomic, strong) id<ZIKNoteListViewDataSource> viewDataSource;
@property (weak, nonatomic) IBOutlet UITableView *noteListTableView;
@end

@implementation ZIKNoteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert([self.eventHandler conformsToProtocol:@protocol(ZIKNoteListViewEventHandler)], nil);
    
    self.noteListTableView.delegate = self;
    self.noteListTableView.dataSource = self;
    [self registerForPreviewingWithDelegate:self.eventHandler sourceView:self.view];
    UIBarButtonItem *addNoteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self.eventHandler
                                                                                 action:@selector(didTouchNavigationBarAddButton)];
    self.navigationItem.rightBarButtonItem = addNoteItem;
    
    if ([self.eventHandler respondsToSelector:@selector(handleViewReady)]) {
        [self.eventHandler handleViewReady];
    }
}

- (UIViewController *)routeSource {
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    if (self.zix_routed == NO) {
        if ([self.eventHandler respondsToSelector:@selector(handleViewRemoved)]) {
            [self.eventHandler handleViewRemoved];
        }
    }
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
                                      text:(NSString *)text
                                detailText:(NSString *)detailText {
    UITableViewCell *cell = [self.noteListTableView dequeueReusableCellWithIdentifier:@"noteListCell" forIndexPath:indexPath];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailText;
    return cell;
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewDataSource numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [self.viewDataSource textOfCellForRowAtIndexPath:indexPath];
    NSString *detailText = [self.viewDataSource detailTextOfCellForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath
                                                   text:text
                                             detailText:detailText];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.eventHandler canEditRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.eventHandler handleDeleteCellForRowAtIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

#pragma mark UITableViewDelegate

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @[
             [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                 [self.eventHandler handleDeleteCellForRowAtIndexPath:indexPath];
                 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
             }]
             ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.eventHandler handleDidSelectRowAtIndexPath:indexPath];
}

#pragma mark Route
/*
 ///Prepare sub modules
- (void)prepareForDestinationRoutingFromExternal:(id)destination configuration:(__kindof ZIKViewRouteConfiguration *)configuration {
    if ([destination conformsToProtocol:@protocol(view-protocol)]) {
        //Prepare
        return;
    }
    NSAssert(NO, @"Can't prepare for unknown destination.");
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
