//
//  MainTableViewController.m
//  ToDoList
//
//  Created by CT4TuEI3 on 30.05.2024.
//


#import "MainTableViewController.h"
#import "DetailViewController.h"

@interface MainTableViewController ()

@property (strong, nonatomic) NSMutableArray * arrayEvents;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    self.arrayEvents = [[NSMutableArray alloc] initWithArray:array];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableViewWhenCreateNewEvent)
                                                 name:@"NewEvent"
                                               object:nil];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)reloadTableViewWhenCreateNewEvent {
    [self.arrayEvents removeAllObjects];
    NSArray * array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    self.arrayEvents = [[NSMutableArray alloc] initWithArray:array];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UILocalNotification * notification = [self.arrayEvents objectAtIndex:indexPath.row];
    NSDictionary * dict = notification.userInfo;
    cell.textLabel.text = [dict objectForKey:@"eventInfo"];
    cell.detailTextLabel.text = [dict objectForKey:@"eventDate"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UILocalNotification * notification = [self.arrayEvents objectAtIndex:indexPath.row];
    NSDictionary * dict = notification.userInfo;
    DetailViewController * detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    detailVC.eventInfo = [dict objectForKey:@"eventInfo"];
    detailVC.eventDate = notification.fireDate;
    detailVC.isDetail = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UILocalNotification * notification = [self.arrayEvents objectAtIndex:indexPath.row];
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
        [self.arrayEvents removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
