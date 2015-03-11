//
//  SplashViewController.m
//  BeautyWall
//
//  Created by AKI on 2015/3/10.
//  Copyright (c) 2015年 AKI. All rights reserved.
//

#import "SplashViewController.h"
#import "MainViewController.h"
#import "AFHTTPRequestOperationManager.h"



@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.1f];
    
  
}


-(void)loadData{
    
    SettingStr = [[NSString alloc] init];
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager1 GET:@"https://dl.dropboxusercontent.com/u/81233286/beauty/url1.html" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // do whatever you'd like here; for example, if you want to convert
        // it to a string and log it, you might do something like:
        
        SettingStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        [[NSUserDefaults standardUserDefaults] setObject:SettingStr forKey:@"SettingStr"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [self getData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    
        if([SettingStr rangeOfString:@"|"].location == NSNotFound){
            SettingStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"SettingStr"];
        }
        
        
        [self getData];
        
    }];
    
    
    
    
//    
//    //
//
//    
//    
//    NSURL *Url = [NSURL URLWithString:@"http://beauty.zones.gamebase.com.tw/wall"];
//    NSData *HtmlData = [NSData dataWithContentsOfURL:Url];
//    
//
//    
//    
//        TFHpple *Parser = [TFHpple hppleWithHTMLData:HtmlData];
//    
//        NSString *XpathQueryString = @"//div[@id='zoomin']";
//    
//       NSArray *mArray = [Parser searchWithXPathQuery:XpathQueryString];
//    
    
    
    
    //OK
    
   
}

-(void)getData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html"];
    
    // NSDictionary *params = @ {@"<#param#>" : <#value#>};
    
    [manager GET:[[SettingStr componentsSeparatedByString:@"|"] objectAtIndex:1] parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         
         MainViewController *main = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
         
         NSMutableArray *mArray = [[NSMutableArray alloc] init];
         
         for (NSDictionary *dic in [responseObject objectForKey:[[SettingStr componentsSeparatedByString:@"|"] objectAtIndex:0]]){
             [mArray addObject:[[responseObject objectForKey:[[SettingStr componentsSeparatedByString:@"|"] objectAtIndex:0]] objectForKey:dic]];
         }
         
         
         main.mArray = [self shuffle:mArray];
         [self.navigationController pushViewController: main
                                              animated:YES];
         
     }
         failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
     }];

}

- (NSMutableArray *)shuffle:(NSMutableArray *)nArray
{
    NSUInteger count = [nArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [nArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    
    return nArray;
    
}





@end
