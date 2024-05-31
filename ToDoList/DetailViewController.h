//
//  ViewController.h
//  ToDoList
//
//  Created by CT4TuEI3 on 20.05.2024.
//


#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) NSDate *eventDate;
@property (strong, nonatomic) NSString * eventInfo;
@property (assign, nonatomic) BOOL isDetail;

@end
