//
//  LoginViewController.h
//  Eltec_testTask
//
//  Created by Боровик Василий on 27.03.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

+(LoginViewController*)storyboardInstance;
@end

NS_ASSUME_NONNULL_END
