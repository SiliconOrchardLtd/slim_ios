//
//  ProfileVC.h
//  WTNotification
//
//  Created by Mehedi Hasan on 7/22/16.
//  Copyright © 2016 Mehedi Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVC : UIViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *statusTF;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *middleConstraint;

@property (weak, nonatomic) IBOutlet UIView *postBtn;

- (IBAction)postBtnPress:(UIButton *)sender;
- (IBAction)tapOnChangeBtnPress:(UIButton *)sender;


@end
