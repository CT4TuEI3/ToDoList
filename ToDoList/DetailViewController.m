//
//  ViewController.m
//  ToDoList
//
//  Created by CT4TuEI3 on 20.05.2024.
//


#import "DetailViewController.h"

@interface DetailViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *buttonAction;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self datePickerSettings];
}

- (void)setupUI {
    [self.buttonAction addTarget:self
                          action:@selector(save)
                forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer * handleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleEndEditing)];
    [self.view addGestureRecognizer:handleTap];
}

- (void)datePickerSettings {
    self.datePicker.minimumDate = [NSDate date];
   [self.datePicker addTarget:self
                        action:@selector(datePickerValueChanged)
              forControlEvents:(UIControlEventValueChanged)];
}



- (void)save {
    NSString * eventInfo = self.textField.text;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm dd.MMMM.yyyy";
    NSString * eventDate = [formatter stringFromDate:self.eventDate];
    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                           eventInfo, @"eventInfo",
                           eventDate, @"eventDate", nil];
    UILocalNotification * notification = [[UILocalNotification alloc] init];
    notification.userInfo = dict;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.fireDate = self.eventDate;
    notification.alertBody = eventInfo;
    notification.applicationIconBadgeNumber = 1;
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication]scheduleLocalNotification:notification];
}

- (void)handleEndEditing {
    [self.view endEditing:YES];
}

- (void)datePickerValueChanged {
    self.eventDate = self.datePicker.date;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.textField]) {
        [self.textField resignFirstResponder];
    }
    return  YES;
}

@end
