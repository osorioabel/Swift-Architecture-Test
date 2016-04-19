//
//  HomeViewController.h
//  Vanidapp
//
//  Created by Giovanny Orozco on 5/5/15.
//  Copyright (c) 2015 LavertPhilips. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Move) <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *currentField;
@property (nonatomic, assign) BOOL keyboardShown;
@property (nonatomic, assign) BOOL moveViewWhenKeyboardAppears;

@end
