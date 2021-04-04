//
//  LoginViewController.m
//  Eltec_testTask
//
//  Created by Боровик Василий on 27.03.2021.
//

#import "LoginScreen.h"
#import <Eltec_testTask-Swift.h>

@implementation LoginScreen

+ (LoginScreen *)storyboardInstance:(NSString *)url {
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil];
	UIViewController *viewController = [storyboard instantiateInitialViewController];
	[(LoginScreen *)viewController setUrl:url];
	return (LoginScreen *)viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)LoginButtonPressed {
	NSString* error = @"";
	NSString* token = @"";
	if (![_usernameTextField.text  isEqual: @""] && ![_passwordTextField.text  isEqual: @""]) {
		[self autorization];
		error = [AutorizationResponseClass shared].getError;
		token = [AutorizationResponseClass shared].getAccessToken;
	} else error = @"Не все поля заполнены";
	
	if (![error isEqual: @""] || token.length == 0) {
		[self showAlert:error];
	} else {
		NSError *error = nil;
		LocksmithObjCWrapper* keyChain  = [[LocksmithObjCWrapper alloc] init];
		[keyChain saveDatawithkey:_usernameTextField.text value:token forUserAccount:_usernameTextField.text error:&error];
		
		if (error != nil) {
			[self showAlert:error.localizedDescription];
		}
		
		[(CustomNavigationController *) self.navigationController showUserInfoScreenWithUserAccount:_usernameTextField.text];
	}
}

-(void)autorization {
	QueryService *queryService = [[QueryService alloc] init];
	[queryService autorizationWithUrl:_url login:_usernameTextField.text password:_passwordTextField.text];
}

-(void)showAlert:(NSString *)message {
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Внимание!" message:message preferredStyle:UIAlertControllerStyleAlert];
	UIAlertController* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
	[alert addAction:defaultAction];
	[self presentViewController:alert animated:YES completion:nil];
}

@end
