//
//  LoginViewController.m
//  Eltec_testTask
//
//  Created by Боровик Василий on 27.03.2021.
//

#import "LoginScreen.h"
#import <Eltec_testTask-Swift.h>

@implementation LoginScreen
QueryService *queryService;

+ (LoginScreen *)storyboardInstance:(NSString *)url {
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil];
	UIViewController *viewController = [storyboard instantiateInitialViewController];
	[(LoginScreen *)viewController setUrl:url];
	return (LoginScreen *)viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	queryService = [[QueryService alloc] init];
	self.activityIndicator.hidden = true;
}

- (IBAction)LoginButtonPressed {
	if (![_usernameTextField.text  isEqual: @""] && ![_passwordTextField.text  isEqual: @""]) {
		[self autorization];
	} else [self showAlert: @"Не все поля заполнены"];
}

-(void)autorization {
	self.activityIndicator.hidden = false;
	
	__weak LoginScreen *weakSelf = self;
	[queryService autorizationWithUrl:_url login: _usernameTextField.text password:_passwordTextField.text completion:^(AutorizationResponseClass * _Nonnull response) {
		
		NSString* error = response.getError;
		NSString* token = response.getAccessToken;

		if (![error isEqual: @""] || token.length == 0) {
			[weakSelf showAlert:error];
		} else {
			NSError *error = nil;
			
			LocksmithObjCWrapper* keyChain  = [[LocksmithObjCWrapper alloc] init];
			[keyChain saveDatawithkey:weakSelf.usernameTextField.text value:token forUserAccount:weakSelf.usernameTextField.text error:&error];

			if (error != nil) {
				[weakSelf showAlert:error.localizedDescription];
			}

			[(RootNavigationController *) weakSelf.navigationController showUserInfoScreenWithUserAccount:weakSelf.usernameTextField.text];
		}
	}];
}

-(void)showAlert:(NSString *)message {
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Внимание!" message:message preferredStyle:UIAlertControllerStyleAlert];
	UIAlertController* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler: ^(UIAlertAction * _Nonnull action) {
		self.activityIndicator.hidden = true;
	}];
	[alert addAction:defaultAction];
	[self presentViewController:alert animated:YES completion:nil];
}

@end
