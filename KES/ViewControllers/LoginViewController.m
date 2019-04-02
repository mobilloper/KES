//
//  LoginViewController.m
//  KES
//
//  Created by matata on 11/21/17.
//  Copyright © 2017 matata. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeightOfTosTextView];
    [Functions makeFloatingField:_EmailField placeholder:@"Your email"];
    [Functions makeFloatingField:_PasswordField placeholder:@"Password"];
    _PasswordField.clearButtonMode = UITextFieldViewModeNever;
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if ([[userInfo objectForKey:KEY_REMEMBER] isEqualToString:@"yes"]) {
        [_EmailField setText:[userInfo objectForKey:KEY_EMAIL]];
        [_PasswordField setText:[userInfo objectForKey:KEY_PASSWORD]];
    }
    

    if (strMainBaseUrl.length == 0) {
        strMainBaseUrl = BASE_URL;
    }
    
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"By signing in, you agree to Kilmartin' \nPrivacy Policy and Terms of use"];
    [hogan addAttribute:NSForegroundColorAttributeName
                  value:[UIColor colorWithHex:COLOR_PRIMARY]
                  range:NSMakeRange(40, 15)];
    [hogan addAttribute:NSLinkAttributeName
                  value:[NSString stringWithFormat:@"%@%@", strMainBaseUrl, PRIVACY_POLICY]
                  range:NSMakeRange(40, 15)];
    [hogan addAttribute:NSForegroundColorAttributeName
                  value:[UIColor colorWithHex:COLOR_PRIMARY]
                  range:NSMakeRange(58, 13)];
    [hogan addAttribute:NSLinkAttributeName
                  value:[NSString stringWithFormat:@"%@%@", strMainBaseUrl, TERMS_SERVICE]
                  range:NSMakeRange(58, 13)];
    _TOSTextView.attributedText = hogan;
    [_TOSTextView setFont:[UIFont fontWithName:@"Roboto-Regular" size:13]];
    
    UILongPressGestureRecognizer *tap1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongTap1:)];
    tap1.minimumPressDuration = 0;
    [self.PwdToggleButton addGestureRecognizer:tap1];
}

- (void)viewDidAppear:(BOOL)animated {
    _objWebServices = [WebServices sharedInstance];
    _objWebServices.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setHeightOfTosTextView
{
    CGFloat width = self.view.bounds.size.width - 125 - 2.0 * self.TOSTextView.textContainer.lineFragmentPadding;
    CGRect boundingRect = [self.TOSTextView.text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                              options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                           attributes:@{ NSFontAttributeName:self.TOSTextView.font}
                                                              context:nil];
    
    CGFloat heightByBoundingRect = CGRectGetHeight(boundingRect);
    if (heightByBoundingRect > self.constraint_tosTextView_height.constant) {
        self.constraint_tosTextView_height.constant = heightByBoundingRect;
        [self.view layoutIfNeeded];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.PasswordField) {
        [theTextField resignFirstResponder];
    } else if (theTextField == self.EmailField) {
        [self.PasswordField becomeFirstResponder];
    }
    return YES;
}

- (void)handleLongTap1:(UIGestureRecognizer*)gesture {
    if (gesture.state == UIPressPhaseChanged) {
        _PasswordField.secureTextEntry = NO;
    } else if (gesture.state == UIPressPhaseEnded) {
        _PasswordField.secureTextEntry = YES;
    }
    
    NSString *tmpString;
    tmpString = _PasswordField.text;
    _PasswordField.text = @" ";
    _PasswordField.text = tmpString;
}

- (BOOL)isValid {
    
    if (_EmailField.text == nil || [_EmailField.text length] == 0 ||
        [[_EmailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 ) {
        [_EmailField becomeFirstResponder];
        [Functions showAlert:@"" message:@"Please input email address"];
        return FALSE;
    }
    else if (![Functions validateEmailField:_EmailField.text]) {
        [_EmailField becomeFirstResponder];
        [Functions showAlert:@"" message:@"Please input correct email address"];
        return FALSE;
    }
    else if (_PasswordField.text == nil || [_PasswordField.text length] == 0
        ||[[_PasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 ) {
        [_PasswordField becomeFirstResponder];
        [Functions showAlert:@"" message:@"Please input password"];
        return FALSE;
    }
                 
    return TRUE;
}

- (void)actionLogin {
    
    NSDictionary * parameters=@{@"email":_EmailField.text,
                                @"password":_PasswordField.text
                                };
    
    loginApi = [NSString stringWithFormat:@"%@%@", strMainBaseUrl, LOGIN_API];
    [_objWebServices callApiWithParameters:parameters apiName:loginApi type:POST_REQUEST loader:YES view:self];
}

- (void)getProfile {
    getProfileApi = [NSString stringWithFormat:@"%@%@", strMainBaseUrl, PROFILE_API];
    [_objWebServices callApiWithParameters:nil apiName:getProfileApi type:GET_REQUEST loader:YES view:self];
}

#pragma mark - UITextField delegate
- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= MAXFIELDLENGTH || returnKey;
}

#pragma mark - webservice call delegate
-(void)response:(NSDictionary *)responseDict apiName:(NSString *)apiName ifAnyError:(NSError *)error
{
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if ([apiName isEqualToString:loginApi])
    {
        if(responseDict != nil)
        {
            int success = [[responseDict valueForKey:@"success"] intValue];
            if (success == 1) {
                [self getProfile];
            } else {
                [Functions showAlert:@"" message:[responseDict valueForKey:@"msg"]];
            }
        }
    } else if ([apiName isEqualToString:getProfileApi]) {
        if (responseDict != nil) {
            int success = [[responseDict valueForKey:@"success"] intValue];
            if (success == 1) {
                [userInfo setObject:[_RememberSwitch isOn] ? @"yes" : @"no" forKey:KEY_REMEMBER];
                [userInfo setObject:_PasswordField.text forKey:KEY_PASSWORD];
                
                id profileObject = [responseDict valueForKey:@"profile"];
                
                if (profileObject != [NSNull null]) {
                    [userInfo setObject:[Functions checkNullValue:[profileObject valueForKey:@"name"]]    forKey:KEY_FIRSTNAME];
                    [userInfo setObject:[Functions checkNullValue:[profileObject valueForKey:@"surname"]] forKey:KEY_LASTNAME];
                    [userInfo setObject:[Functions checkNullValue:[profileObject valueForKey:@"email"]]   forKey:KEY_EMAIL];
                    [userInfo setObject:[Functions checkNullValue:[profileObject valueForKey:@"phone"]]   forKey:KEY_PHONE];
                    [userInfo setObject:[Functions checkNullValue:[profileObject valueForKey:@"address"]] forKey:KEY_ADDRESS];
                    [userInfo setObject:[Functions checkNullValue:[profileObject valueForKey:@"eircode"]] forKey:KEY_EIRCODE];
                    [userInfo setValue:[profileObject valueForKey:@"avatar"] forKey:KEY_AVATAR];
                    [userInfo setObject:[profileObject valueForKey:@"id"]      forKey:KEY_USERID];
                    [userInfo setObject:[Functions checkNullValue:[profileObject valueForKey:@"registered"]] forKey:KEY_REGISTERED];
                }
                
                BOOL has_login_as = [[responseDict valueForKey:@"has_login_as"] boolValue];
                [userInfo setObject:has_login_as == YES ? @"1":@"0" forKey:KEY_SUPER_USER];
                
                userRoleApi = [NSString stringWithFormat:@"%@%@", strMainBaseUrl, USER_ROLE];
                [_objWebServices callApiWithParameters:nil apiName:userRoleApi type:GET_REQUEST loader:YES view:self];
            } else
                [Functions showAlert:@"" message:[responseDict valueForKey:@"msg"]];
        }
    } else if ([apiName isEqualToString:userRoleApi]) {
        if(responseDict != nil) {
            int success = [[responseDict valueForKey:@"success"] intValue];
            if (success == 1) {
                id roleObject = [responseDict valueForKey:@"role"];
                id permissionsObject = [responseDict valueForKey:@"permissions"];
                BOOL messaging = [[permissionsObject valueForKey:@"messaging"] boolValue];
                BOOL todos = [[permissionsObject valueForKey:@"todos"] boolValue];
                [userInfo setValue:[roleObject valueForKey:@"role"] forKey:@"user_role"];
                [userInfo setValue:messaging == YES ? @"1" : @"0" forKey:@"messaging"];
                [userInfo setValue:todos     == YES ? @"1" : @"0" forKey:@"todos"];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GO_HOME object:self];
            } else {
                [Functions showAlert:@"" message:[responseDict valueForKey:@"msg"]];
            }
        }
    }
    else
    {
        NSLog(@"Connection time out!");
    }
}

- (IBAction)OnSignupClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SIGNUP object:self];
}

- (IBAction)OnForgotClicked:(id)sender {
    NSDictionary* info = @{@"info": @"ForgotPassword"};
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FORGOT object:self userInfo:info];
}

- (IBAction)OnPwdShowClicked:(id)sender {
    if (_passwordShown) {
        _passwordShown = NO;
        _PasswordField.secureTextEntry = YES;
        [_PwdToggleButton setTitle:@"Show" forState:UIControlStateNormal];
    }
    else
    {
        _passwordShown = YES;
        _PasswordField.secureTextEntry = NO;
        [_PwdToggleButton setTitle:@"Hide" forState:UIControlStateNormal];
    }
    
    NSString *tmpString;
    tmpString = _PasswordField.text;
    _PasswordField.text = @" ";
    _PasswordField.text = tmpString;
}

- (IBAction)OnQuestionClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_QUESTION object:self];
}

- (IBAction)OnContinueClicked:(id)sender {
    [Functions openURl:BASE_URL];
}

- (IBAction)OnLoginClicked:(id)sender {
    if ([self isValid]) {
        [self actionLogin];
    };
}
@end
