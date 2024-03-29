//
//  IntelligenceController.m
//  Mimamori2
//
//  Created by totyu2 on 2017/4/28.
//  Copyright © 2017年 totyu3. All rights reserved.
//

#import "IntelligenceController.h"

@interface IntelligenceController ()
@property (strong, nonatomic) IBOutlet DropButton *facilityBtn;

//基本情报
@property (strong, nonatomic) IBOutlet UITextField *kodoField;
@property (strong, nonatomic) IBOutlet UITextField *nameField;

//设施情报
@property (strong, nonatomic) IBOutlet UITextField *hosutoIdField;

@property (strong, nonatomic) IBOutlet UITextField *facilityField;
@property (strong, nonatomic) IBOutlet UITextField *facilityNameField;
@property (strong, nonatomic) IBOutlet UITextField *fckanaField;
@property (strong, nonatomic) IBOutlet UITextField *facilityName2Field;

@property (strong, nonatomic) IBOutlet UITextField *fckana2Field;


//其他
//@property (strong, nonatomic) IBOutlet UITextField *numField;
//
//@property (strong, nonatomic) IBOutlet UITextField *pesronNumField;
//
//@property (strong, nonatomic) IBOutlet UITextField *sonotaField;


//@property (nonatomic, strong) NSArray              *allDatas;

@property (strong, nonatomic) IBOutlet UIButton    *editButton;
@end

@implementation IntelligenceController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getinfo];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (void)getinfo {
    [MBProgressHUD showMessage:@"" toView:WindowView];
    NSString *facd = [[NITUserDefaults objectForKey:@"TempFacilityName"] objectForKey:@"facilitycd"];
    NSDictionary *dic = @{@"facilitycd":facd};
    [MHttpTool postWithURL:NITGetFacilityInfo params:dic success:^(id json) {
        [MBProgressHUD hideHUDForView:WindowView];
        NSDictionary *indoDic = [json objectForKey:@"facilityinfo"];
        if (indoDic.count > 0) {
            
           
            self.kodoField.text = indoDic[@"companycd"];
            self.nameField.text = indoDic[@"companyname"];
            
            self.hosutoIdField.text = indoDic[@"hostcd"];
            
            self.facilityField.text = indoDic[@"facilitycd"];
            
            self.facilityNameField.text = indoDic[@"facilityname1"];
            
            self.fckanaField.text = indoDic[@"facilityname1kana"];
            
            self.facilityName2Field.text = indoDic[@"facilityname2"];
            
            
            self.fckana2Field.text = indoDic[@"facilityname2kana"];
            
            
//            self.numField.text = [NSString stringWithFormat:@"%@", indoDic[@"floorcount"]];
//            self.pesronNumField.text = [NSString stringWithFormat:@"%@", indoDic[@"roomcount"]];
//            self.sonotaField.text = indoDic[@"memo"];
            
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:WindowView];
        NITLog(@"%@",error);
    }];
    [self.tableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    
    _facilityBtn.buttonTitle = [[NITUserDefaults objectForKey:@"TempFacilityName"] objectForKey:@"facilityname2"];
}

- (IBAction)editCell:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"編集"]) {
        [sender setTitle:@"完了" forState:UIControlStateNormal];
        
        [self statusEdit:YES withColor:[UIColor whiteColor]];
        //进入编辑状态
    }else{
//        [sender setTitle:@"編集" forState:UIControlStateNormal];
//        
//        [self statusEdit:NO withColor:[UIColor whiteColor]];
        
        [self saveInfo]; //跟新或者追加
        
    }
    
    [CATransaction setCompletionBlock:^{
        [self.tableView reloadData];
    }];
    
}

- (void)statusEdit:(BOOL)noOp withColor:(UIColor *)color {
    NSString *master = [NITUserDefaults objectForKey:@"MASTER_UERTTYPE"];
    if (!master.length) return;
    
    if ([master isEqualToString:@"3"]) {
        
    } else if ([master isEqualToString:@"2"]) {
        [self.facilityName2Field setEnabled:noOp];
        [self.facilityName2Field setBackgroundColor:color];
        [self.fckana2Field setEnabled:noOp];
        [self.fckana2Field setBackgroundColor:color];
        
        
//        [self.numField setEnabled:noOp];
//        [self.numField setBackgroundColor:color];
//        [self.pesronNumField setEnabled:noOp];
//        [self.pesronNumField setBackgroundColor:color];
//        [self.sonotaField setEnabled:noOp];
//        [self.sonotaField setBackgroundColor:color];
    } else {
<<<<<<< HEAD
        [self.kodoField setEnabled:noOp];
        [self.kodoField setBackgroundColor:color];
        [self.nameField setEnabled:noOp];
        [self.nameField setBackgroundColor:color];
        
=======
//        [self.kodoField setEnabled:noOp];
//        [self.kodoField setBackgroundColor:color];
//        [self.nameField setEnabled:noOp];
//        [self.nameField setBackgroundColor:color];
//        
>>>>>>> 85f6cf125194154c0ce3efe6e3708823cba5cb9a
//        [self.hosutoIdField setEnabled:noOp];
//        [self.hosutoIdField setBackgroundColor:color];
//        [self.facilityField setEnabled:noOp];
//        [self.facilityField setBackgroundColor:color];
<<<<<<< HEAD
        
        [self.facilityNameField setEnabled:noOp];
        [self.facilityNameField setBackgroundColor:color];
        [self.fckanaField setEnabled:noOp];
        [self.fckanaField setBackgroundColor:color];
=======
//        [self.facilityNameField setEnabled:noOp];
//        [self.facilityNameField setBackgroundColor:color];
//        [self.fckanaField setEnabled:noOp];
//        [self.fckanaField setBackgroundColor:color];
>>>>>>> 85f6cf125194154c0ce3efe6e3708823cba5cb9a
        [self.facilityName2Field setEnabled:noOp];
        [self.facilityName2Field setBackgroundColor:color];
        [self.fckana2Field setEnabled:noOp];
        [self.fckana2Field setBackgroundColor:color];
        
        
//        [self.numField setEnabled:noOp];
//        [self.numField setBackgroundColor:color];
//        [self.pesronNumField setEnabled:noOp];
//        [self.pesronNumField setBackgroundColor:color];
//        [self.sonotaField setEnabled:noOp];
//        [self.sonotaField setBackgroundColor:color];
        
    }
}

- (void)saveInfo {
    [MBProgressHUD showMessage:@"" toView:WindowView];
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSString *staffid = [NITUserDefaults objectForKey:@"userid1"];
    
    dic[@"companycd"]= self.kodoField.text;
    dic[@"companyname"] = self.nameField.text;
    
    dic[@"hostcd"] = self.hosutoIdField.text;
    
    dic[@"facilitycd"] = self.facilityField.text;
    dic[@"facilityname1"]= self.facilityNameField.text;
    dic[@"facilityname1kana"] = self.fckanaField.text;
    dic[@"facilityname2"]= self.facilityName2Field.text;
    dic[@"facilityname2kana"]= self.fckana2Field.text;
    
//    dic[@"floorcount"] = self.numField.text;
//    dic[@"roomcount"] = self.pesronNumField.text;
//    dic[@"memo"] = self.sonotaField.text;
    
    NSError *parseError = nil;
    
    NSData  *json = [NSJSONSerialization dataWithJSONObject:dic options: NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    
    NSDictionary *lastDic = @{@"staffid":staffid,@"facilityinfo":str};
    
    [MHttpTool postWithURL:NITUpdateFacilityInfo params:lastDic success:^(id json) {
        [MBProgressHUD hideHUDForView:WindowView];
        if (json) {
            NSString *code = [json objectForKey:@"code"];
            NITLog(@"%@",code);
            
            [self.editButton setTitle:@"編集" forState:UIControlStateNormal];
            [self statusEdit:NO withColor:NITColor(235, 235, 241)];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:WindowView];
        NITLog(@"%@",error);
    }];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [textField setBackgroundColor:NITColor(253, 164, 181)];
    
    return YES;
}



-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField setBackgroundColor:[UIColor whiteColor]];
    
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return  YES;
}
@end
