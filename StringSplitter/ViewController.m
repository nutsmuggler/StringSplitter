//
//  ViewController.m
//  StringSplitter
//
//  Created by Davide Benini on 20/01/16.
//  Copyright © 2016 NtNext. All rights reserved.
//

#import "ViewController.h"

#import "NSString+SplitEqually.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [self updateLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textChanged:(UITextField*)sender {
    [self updateLabel];
}

-(void)updateLabel {
    self.outputLabel.text = [self.textField.text splitEquallyWithTextAttributes:@{NSFontAttributeName: self.textField.font}];
}


@end
