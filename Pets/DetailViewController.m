//
//  DetailViewController.m
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *typePickerView;
@property (strong, nonatomic) NSArray *petTypes;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerBottomConstraint;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setPet:(Pet *)newPet
{
    if (_pet != newPet) {
        _pet = newPet;
            
        // Update the view.
        [self configureView];
    }
}

- (void)hidePicker
{
    [self.view layoutIfNeeded];
    self.pickerBottomConstraint.constant = -216;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)showPicker
{
    [self.view layoutIfNeeded];
    self.pickerBottomConstraint.constant = 0;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)configureView {
    
    //Set right bar button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    //Load pickerview values
    self.petTypes = [kPetTypes componentsSeparatedByString:@","];
    
    //Hide picker
    [self hidePicker];
    
     // Update the user interface for the pet item.
    if (self.pet) {
        self.nameTextField.text = self.pet.name;
        self.typeTextField.text = self.pet.stringForPetType;
    }
    
    //Set selected item for picker
    [self.typePickerView selectRow:self.pet.type inComponent:0 animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.petTypes.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.petTypes[row];
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.typeTextField.text = self.petTypes[row];
}

#pragma mark - 
#pragma mark - Textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self showPicker];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self hidePicker];
}

#pragma mark - 
#pragma mark - Bar Button item actions
- (void)save:(id)sender
{
    self.pet.name = self.nameTextField.text;
    self.pet.type = [self.typePickerView selectedRowInComponent:0];
    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}
@end
