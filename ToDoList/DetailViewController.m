//
//  ViewController.m
//  ToDoList
//
//  Created by CT4TuEI3 on 20.05.2024.
//


#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *buttonAction;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.buttonAction addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
}

- (void)save {
    
}

@end
