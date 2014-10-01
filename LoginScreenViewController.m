//
//  LoginScreenViewController.m
//  LoginScreen
//
//  Created by Lucas Menezes on 23/09/14.
//  Copyright (c) 2014 MENEZESWORKS. All rights reserved.
//

#import "LoginScreenViewController.h"

@interface LoginScreenViewController ()
@property (weak, nonatomic) IBOutlet UITextField *LoginText;
@property (weak, nonatomic) IBOutlet UITextField *Passwordtext;
@property (nonatomic) NSArray* DBLoginNames;
@property (nonatomic) NSArray* DBPasswordNames;

@end

@implementation LoginScreenViewController

bool flagLoginExists=false;
bool flagPasswordMatches=false;
int countattempts=0; //it starts on zero
int loginId;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


void JSonTest (void)
{
    NSData * JsonData=[[NSData alloc] init];
    NSString* filePath;
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    
    
}
NSArray* GetLoginNamesFromDB(void)
{
    NSArray * users =[[NSArray alloc] init];
    NSString * data =@"Lucas;Lorenzo;lucas;lorenzo;natalia;Natalia;Lucena;eu;login";
    users = [data componentsSeparatedByString:@";"];
    
    JSonTest();
    
    
    return users;
    
}
NSArray* GetPasswordEntriesFromDB(void)
{
    NSArray * passwords =[[NSArray alloc] init];
    NSString * data =@"123;12345;123;12345;anything;LES;LES;LES;senha";
    passwords = [data componentsSeparatedByString:@";"];
    
    return passwords;
}
bool LoginEntryExists( NSString* LoginTxt)
{
    if([LoginTxt isEqualToString:@""])
        return false;
    NSArray* db=GetLoginNamesFromDB();
    for (loginId=0;loginId < [db count] ;loginId++)
        if([db[loginId] isEqualToString:LoginTxt])
        {
            return true;
        }
    
    return false;
    
}
bool PasswordMatches (NSString* PassTxt)
{
    
    if(!flagLoginExists)
    {
         NSLog(@"Cannot Have Password without login");
        return false;
    }
    NSArray* dBPasswords=GetPasswordEntriesFromDB();
    if([dBPasswords[loginId] isEqualToString:PassTxt])
        return true;
    
    return false;
    
}
- (IBAction)LoginFieldAltered:(id)sender {
    NSLog(@"Login changed");
    
    if(LoginEntryExists([_LoginText text]))
    { NSLog(@"Username Exists");
        flagLoginExists=true;
    }
    else
    {   NSLog(@"USERNAME INCORRECT");
        flagLoginExists=false;
    }
        
    
    
}
- (IBAction)PasswordFieldAltered:(id)sender {
    NSLog(@"Password changed");
    if(PasswordMatches([_Passwordtext text]))
    { NSLog(@"Password Matches");
        flagPasswordMatches=true;
    }
    else
    {   NSLog(@"Password does not match");
        flagPasswordMatches=false;
    }
   
    
}
- (IBAction)EntrarButtonPressed:(id)sender {
    NSLog(@"Entrar Pressed");
    if(flagLoginExists && flagPasswordMatches)
    {    NSLog(@"You may enter");
        flagLoginExists=false;
        flagPasswordMatches=false;
        [self performSegueWithIdentifier:@"SignIn" sender:sender];
    }
    else
    {
     if(!LoginEntryExists([ _LoginText text]))
     {
         NSLog(@"LOGIN DOES NOT EXIST");
         //[self performSegueWithIdentifier:@"PopupCalled" sender:sender];
         
         
     }
     else
     { if( PasswordMatches([_Passwordtext text]))
        {  NSLog(@"You may enter");
            flagLoginExists=false;
            flagPasswordMatches=false;
           [self performSegueWithIdentifier:@"SignIn" sender:sender];
        }
        else
        {
            NSLog(@"PASSWORD INCORRECT");
        }
     }
    
         
    }
    
    
    
}
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
