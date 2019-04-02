//
//  UserMngViewController.m
//  KES
//
//  Created by matata on 11/14/18.
//  Copyright © 2018 matata. All rights reserved.
//

#import "UserMngViewController.h"

@interface UserMngViewController ()

@end

@implementation UserMngViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objWebServices = [WebServices sharedInstance];
    objWebServices.delegate = self;
    userInfo = [NSUserDefaults standardUserDefaults];
    if (appDelegate.UserArray.count == 0) {
        [self getUserList];
    }
    [self toggleUserMngView];
    [_userMngButton setEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggleUserMngView {
    if (appDelegate.isLogAs) {
        [_userMngButton setTitle:appDelegate.logAsUser forState:UIControlStateNormal];
        [_logBackButton setHidden:NO];
        [_logBackButton setTitle:[NSString stringWithFormat:@"Login back as %@", appDelegate.logOriginUser] forState:UIControlStateNormal];
    } else {
        [_logBackButton setHidden:YES];
        [_userMngButton setTitle:@"User Management" forState:UIControlStateNormal];
    }
}

- (void)actionLoginAs:(NSString*)userId {
    NSDictionary *parameters=@{@"user_id":userId};
    loginAsApi = [NSString stringWithFormat:@"%@%@", strMainBaseUrl, USER_LOGINAS];
    [objWebServices callApiWithParameters:parameters apiName:loginAsApi type:POST_REQUEST loader:YES view:self];
}

- (void)actionLoginBack {
    loginBackApi = [NSString stringWithFormat:@"%@%@", strMainBaseUrl, USER_LOGINBACK];
    [objWebServices callApiWithParameters:nil apiName:loginBackApi type:GET_REQUEST loader:YES view:self];
}

- (void)getUserList {
    userListApi = [NSString stringWithFormat:@"%@%@", strMainBaseUrl, USER_LIST];
    [objWebServices callApiWithParameters:nil apiName:userListApi type:GET_REQUEST loader:YES view:self];
}

- (void)getProfile {
    getProfileApi = [NSString stringWithFormat:@"%@%@", strMainBaseUrl, PROFILE_API];
    [objWebServices callApiWithParameters:nil apiName:getProfileApi type:GET_REQUEST loader:YES view:self];
}

- (void)parseUserArray:(id)responseObject {
    NSArray* userObject = [responseObject valueForKey:@"users"];
    for (NSDictionary *obj in userObject) {
        UserModel *userModel = [[UserModel alloc] init];
        userModel.user_id = [obj valueForKey:@"id"];
        userModel.email = [obj valueForKey:@"email"];
        userModel.can_login = [obj valueForKey:@"can_login"];
        userModel.role = [obj valueForKey:@"role"];
        
        [appDelegate.UserArray addObject:userModel];
        [appDelegate.UserEmailArray addObject:[NSString stringWithFormat:@"%@ - %@", userModel.email, userModel.role]];
    }
    
    [self.userTableView reloadData];
}

#pragma mark - webservice call delegate
- (void)response:(NSDictionary *)responseDict apiName:(NSString *)apiName ifAnyError:(NSError *)error
{
    if ([apiName isEqualToString:loginAsApi])
    {
        if(responseDict != nil)
        {
            int success = [[responseDict valueForKey:@"success"] intValue];
            if (success == 1) {
                appDelegate.isLogAs = YES;
                appDelegate.logOriginUser = [responseDict valueForKey:@"login_as_return_email"];
                
                [self toggleUserMngView];
                [self getProfile];
                
            } else {
                [Functions checkError:responseDict];
            }
        }
    }
    else if ([apiName isEqualToString:loginBackApi])
    {
        if(responseDict != nil)
        {
            int success = [[responseDict valueForKey:@"success"] intValue];
            if (success == 1) {
                appDelegate.isLogAs = NO;
                
                [self toggleUserMngView];
                [self getProfile];
            } else {
                [Functions checkError:responseDict];
            }
        }
    }
    else if ([apiName isEqualToString:userListApi])
    {
        if(responseDict != nil)
        {
            int success = [[responseDict valueForKey:@"success"] intValue];
            if (success == 1) {
                [self parseUserArray:responseDict];
            } else {
                [Functions checkError:responseDict];
            }
        }
    }
    else if ([apiName isEqualToString:getProfileApi]) {
        if (responseDict != nil) {
            int success = [[responseDict valueForKey:@"success"] intValue];
            if (success == 1) {
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
                
                userRoleApi = [NSString stringWithFormat:@"%@%@", strMainBaseUrl, USER_ROLE];
                [objWebServices callApiWithParameters:nil apiName:userRoleApi type:GET_REQUEST loader:YES view:self];
            } else
                [Functions showAlert:@"" message:[responseDict valueForKey:@"msg"]];
        }
    }
    else if ([apiName isEqualToString:userRoleApi]) {
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
                [userInfo synchronize];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_RETRIEVE_FEED object:self];
            } else {
                [Functions showAlert:@"" message:[responseDict valueForKey:@"msg"]];
            }
        }
    }
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (appDelegate.UserEmailArray.count == 0) {
        return 0;
    } else {
        return appDelegate.UserEmailArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"UserCell";
    
    UITableViewCell *cell = [self.userTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel *namelbl = (UILabel*)[cell viewWithTag:20];
    namelbl.text = [appDelegate.UserEmailArray objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.userTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserModel *userObj = [appDelegate.UserArray objectAtIndex:indexPath.row];
    [self actionLoginAs:userObj.user_id];
    appDelegate.logAsUser = userObj.email;
}

#pragma mark - IBAction
- (IBAction)OnBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)UserMngClicked:(id)sender {
    
}

- (IBAction)LogBackClicked:(id)sender {
    [self actionLoginBack];
}
@end
