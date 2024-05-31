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
    if (self.isDetail) {
        self.textField.text = self.eventInfo;
        self.textField.userInteractionEnabled = NO;
        self.datePicker.date = self.eventDate;
        self.datePicker.userInteractionEnabled = NO;
        self.buttonAction.alpha = 0;
        [self performSelector:@selector(setDatePickerValueWithAnimation)
                   withObject:nil
                   afterDelay:0.5];
    } else {
        [self setupUI];
        [self datePickerSettings];
    }
}

- (void)setupUI {
    self.buttonAction.userInteractionEnabled = NO;
    self.buttonAction.alpha = 0.5;
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

- (void)setDatePickerValueWithAnimation {
    [self.datePicker setDate:self.eventDate animated:YES];
}


- (void)save {
    if (self.eventDate) {
        if ([self.eventDate compare: [NSDate date]] == NSOrderedSame) {
            [self showAlertWithMessage:@"Дата будущего события не может совпадать с текущей датой"];
        } else if ([self.eventDate compare: [NSDate date]] == NSOrderedAscending) {
            [self showAlertWithMessage:@"Дата будущего события не может быть ранее текущей"];
        } else {
            [self setNotification];
        }
    } else {
        [self showAlertWithMessage:@"Для сохранения события, измените значение даты"];
    }
}

- (void)setNotification {
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewEvent" object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)handleEndEditing {
    if ([self.textField.text length] != 0) {
        [self.view endEditing:YES];
        self.buttonAction.userInteractionEnabled = YES;
        self.buttonAction.alpha = 1;
    } else {
        [self showAlertWithMessage:@"Для сохранения события, введите значение в текстовое поле"];
    }
}

- (void)datePickerValueChanged {
    self.eventDate = self.datePicker.date;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:(self.textField)]) {
        if ([self.textField.text length] != 0) {
            [self.textField resignFirstResponder];
            self.buttonAction.userInteractionEnabled = YES;
            self.buttonAction.alpha = 1;
            return YES;
        } else {
            [self showAlertWithMessage:@"Для сохранения события, введите значение в текстовое поле"];
        }
    }
    return  NO;
}

- (void)showAlertWithMessage : (NSString *) message{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle: @"Внимание"
                                 message: message
                                 preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction
                                actionWithTitle: @"Ok"
                                style: UIAlertActionStyleDefault
                                handler: nil];
    [alert addAction: okAction];
    [self presentViewController: alert animated: YES completion: nil];
}


@end
