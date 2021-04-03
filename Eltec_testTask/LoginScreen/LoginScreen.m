//
//  LoginViewController.m
//  Eltec_testTask
//
//  Created by Боровик Василий on 27.03.2021.
//

#import "LoginScreen.h"
#import <Eltec_testTask-Swift.h>

@implementation LoginScreen

+ (LoginScreen *)storyboardInstance {
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil];
	UIViewController *viewController = [storyboard instantiateInitialViewController];
	
	return (LoginScreen *)viewController;
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)LoginButtonPressed {
	[self loginWith: self.usernameTextField.text And: self.passwordTextField.text];
}


-(void)loginWith:(NSString *)user And:(NSString *)password {
	QueryService *queryService = [[QueryService alloc] init];
	[queryService loginWithUser:user password:password];
}



@end