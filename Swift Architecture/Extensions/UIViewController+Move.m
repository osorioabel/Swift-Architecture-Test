//
//  HomeViewController.h
//  Vanidapp
//
//  Created by Giovanny Orozco on 5/5/15.
//  Copyright (c) 2015 LavertPhilips. All rights reserved.
//

#import "UIViewController+Move.h"
#import <objc/runtime.h>

static char const * moveViewWhenKeyboardAppearsKey = "moveViewWhenKeyboardAppearsKey";

@implementation UIViewController (Move)

UITextField * _currentField_;
BOOL _keyboardShown_;

-(void)setCurrentField:(UITextField *)currentField {
    _currentField_ = currentField;
}

-(UITextField *)currentField {
    return _currentField_;
}

-(void)setKeyboardShown:(BOOL)keyboardShown {

    _keyboardShown_ = keyboardShown;
}

-(BOOL)keyboardShown {
    return _keyboardShown_;
}

@dynamic moveViewWhenKeyboardAppears;

-(void)setMoveViewWhenKeyboardAppears:(BOOL)moveViewWhenKeyboardAppears {

    objc_setAssociatedObject(self, moveViewWhenKeyboardAppearsKey, @(moveViewWhenKeyboardAppears), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)moveViewWhenKeyboardAppears {

    return [objc_getAssociatedObject(self, moveViewWhenKeyboardAppearsKey) boolValue];
}


//Exchanges implementation for calling both viewDidLoads
+(void)load {
    
    Method originalAppear, swizzledAppear, originalDisappear, swizzledDisappear;
    
    originalAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
    swizzledAppear = class_getInstanceMethod(self, @selector(swizzled_viewWillAppear));
    
    originalDisappear = class_getInstanceMethod(self, @selector(viewWillDisappear:));
    swizzledDisappear = class_getInstanceMethod(self, @selector(swizzled_viewWillDisappear));
    
    method_exchangeImplementations(originalAppear, swizzledAppear);
    method_exchangeImplementations(originalDisappear, swizzledDisappear);
}

//This method tries to add a custom back buttonItem o menu buttonItem to all viewControllers of the App
-(void)swizzled_viewWillAppear {
    
    [self swizzled_viewWillAppear];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)swizzled_viewWillDisappear {
    
    [self swizzled_viewWillDisappear];
    
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [self.view endEditing:YES];
    
    CGRect frame = self.navigationController.navigationBar.frame;
    frame.origin.y = [[UIApplication sharedApplication] statusBarFrame].size.height;
    self.navigationController.navigationBar.frame = frame;
}

-(void)keyboardWillShow:(NSNotification *)notification {
    
    if (self.moveViewWhenKeyboardAppears) {
        
        NSDictionary *userInfo = notification.userInfo;
        CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        keyboardFrameEnd = [self.view convertRect:keyboardFrameEnd fromView:nil];
        
        CGRect frameWithKeyBoard = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y);
        NSInteger originY = [self.currentField convertPoint:CGPointMake(0, 0) toView:self.view].y;
        
        if ((frameWithKeyBoard.size.height/2) < originY) {
            
            CGRect viewFrame = self.view.frame;
            viewFrame.origin.y = -(originY - (frameWithKeyBoard.size.height / 2));
            
            [UIView animateWithDuration:.25 animations:^{
                
                self.view.frame = viewFrame;
                CGRect frame = self.navigationController.navigationBar.frame;
                frame.origin.y = -frame.size.height;
                self.navigationController.navigationBar.frame = frame;
                
            } completion:nil];
        }
    }
}

-(void)keyboardWillHide:(NSNotification *)notification {
    
    CGRect viewFrame = self.view.frame;
    
    if (viewFrame.origin.y < 0) {
    
        viewFrame.origin.y = 0;
        
        [UIView animateWithDuration:.25 animations:^{
            
            self.view.frame = viewFrame;
            CGRect frame = self.navigationController.navigationBar.frame;
            frame.origin.y = [[UIApplication sharedApplication] statusBarFrame].size.height;
            self.navigationController.navigationBar.frame = frame;
        }];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    self.currentField = textField;
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.currentField resignFirstResponder];
}

@end
