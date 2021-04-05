//
//  LoginScreen.h
//  Eltec_testTask
//
//  Created by Боровик Василий on 27.03.2021.
//

#import <UIKit/UIKit.h>
//#import <Eltec_testTask-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginScreen : UIViewController
@property (strong, nonatomic) NSString *url;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

+(LoginScreen*)storyboardInstance:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
