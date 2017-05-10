//
//  SelfViewController.m
//  Mimamori
//
//  Created by totyu3 on 16/6/13.
//  Copyright © 2016年 totyu3. All rights reserved.
//

#import "SelfViewController.h"
#import "NotificationModel.h"
#import "SelfModel.h"

#import "AFNetworking.h"

@interface SelfViewController ()<DropClickDelegate>
/**
 *  nikeName
 */
@property (weak, nonatomic) IBOutlet UITextField *nickName;
/**
 *  email
 */
@property (weak, nonatomic) IBOutlet UITextField *email;
/**
 *  groupPicker
 */
@property (weak, nonatomic) IBOutlet UIPickerView *groupPicker;


@property (nonatomic, strong) NSMutableArray *allGroupData;


@property (nonatomic, assign) NSString  *groupid;//当前是分组id


@property (nonatomic, strong) AFHTTPSessionManager *session;


@property (nonatomic, strong) SelfModel *user;
@property (strong, nonatomic) IBOutlet DropButton            *facilitiesBtn;


@end

@implementation SelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化session对象
    _session = [AFHTTPSessionManager manager];
    // 设置请求接口回来时支持什么类型的数组
    _session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    [self.navigationItem setHidesBackButton:YES];
    //GroupInfo
    NSArray *tmpArr = [NotificationModel mj_objectArrayWithKeyValuesArray:[NITUserDefaults objectForKey:@"allGroupData"]];
    self.allGroupData = tmpArr.count > 0 ? [NSMutableArray arrayWithArray:tmpArr] : [NSMutableArray new];
    
    [self getUserInfo];
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getUserInfo)];
//    
//    [NITRefreshInit MJRefreshNormalHeaderInit:(MJRefreshNormalHeader*)self.tableView.mj_header];
//    //UserInfo
    
    [MBProgressHUD showMessage:@"" toView:WindowView];
}


-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUD];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    _facilitiesBtn.buttonTitle = [[NITUserDefaults objectForKey:@"TempFacilityName"] objectForKey:@"facilityname2"];
}




-(void)getUserInfo{
    NSString *url = NITGetUserInfo;

    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionary];
    NSString *userid1 = [NITUserDefaults objectForKey:@"userid1"];
    [parametersDict setValue:userid1 forKey:@"staffid"];
    
    [_session POST:url parameters:parametersDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:WindowView];
        NSArray *userinfo = [responseObject objectForKey:@"userinfo"];
        if (userinfo){
            NSArray *tmpArr = [SelfModel mj_objectArrayWithKeyValuesArray:userinfo];
            
            SelfModel *smodel = tmpArr.firstObject;
            self.user = smodel;
            
            self.nickName.text = self.user.nickname;
            
            self.email.text = self.user.email;
            
            self.groupid = self.user.groupid;
            
            //setup PickerView
            if (self.groupid.length) {
                NSInteger row = [self.groupid intValue];
                [self.groupPicker selectRow:row inComponent:0 animated:NO];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:WindowView];
        NITLog(@"zwgetuserinfo请求失败");
    }];
    
}


-(void)updateUserInfo{
    [MBProgressHUD showMessage:@"" toView:WindowView];
    NSString *url = NITUpdateUserInfo;
    
    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionary];
    NSString *userid1 = [NITUserDefaults objectForKey:@"userid1"];
    [parametersDict setValue:userid1 forKey:@"staffid"];
    [parametersDict setValue:self.nickName.text forKey:@"nickname"];
    
    [parametersDict setValue:self.groupid forKey:@"groupid"];
    
    [parametersDict setValue:self.email.text forKey:@"email"];
    
    //当前时间
    NSString *currentTime = [[NSDate date] needDateStatus:HaveHMSType];
    [parametersDict setValue:currentTime forKey:@"updatedate"];

    [self.session POST:url parameters:parametersDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:WindowView];
        //更新模型
        self.user.nickname = self.nickName.text;
        self.user.email = self.email.text;
        self.user.groupid = self.groupid;
        
        [MBProgressHUD showSuccess:@"更新成功しました"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:WindowView];
        NITLog(@"zwupdateuserinfo请求失败");
        
        [MBProgressHUD showError:@"後ほど試してください"];
    }];
    

}

//保存个人信息
- (IBAction)saveButton:(id)sender {
    
    if (!self.nickName.text.length) {
        [MBProgressHUD showError:@"ニックネームを入力してください"];
        return;
    }
    if (!self.email.text.length) {
        [MBProgressHUD showError:@"メールアドレスを入力してください"];
        return;
    }
    [self updateUserInfo];
    
}

#pragma mark - PickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.allGroupData.count;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NotificationModel *model = self.allGroupData[row];
    if (model) {
        return model.groupname;
    }
    return nil;
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
//    NotificationModel *model = self.allGroupData[row];
    
    self.groupid = [NSString stringWithFormat:@"%ld",row];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}

@end
