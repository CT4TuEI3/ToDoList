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
    [self.buttonAction addTarget:self
                          action:@selector(save)
                forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer * handleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleEndEditing)];
    [self.view addGestureRecognizer:handleTap];
}

- (void)save {
    
}

- (void)handleEndEditing {
    [self.view endEditing:YES];    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.textField]) {
        [self.textField resignFirstResponder];
    }
    return  YES;
}

@end
