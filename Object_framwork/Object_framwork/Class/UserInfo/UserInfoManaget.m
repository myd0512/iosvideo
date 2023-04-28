//
//  UserInfoManaget.m
//  Object_framwork

//  Created by apple on 2020/4/23.
//  Copyright © 2020 www.zzwanbei.com. All rights reserved.



#import "UserInfoManaget.h"

@implementation UserInfoManaget
FanweSingletonM(Instance) ;

-(void)save:(UserInfoModel *)model {
    NSString *plistFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"t.data"];
    [NSKeyedArchiver archiveRootObject:model toFile:plistFilePath];
    NSLog(@"存储成功") ;
}
 
- (void)get {
    NSString *plistFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"t.data"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:plistFilePath] == YES) {

        self.model = [NSKeyedUnarchiver unarchiveObjectWithFile:plistFilePath];
        NSLog( @"%@",self.model.token ) ;
        
    }else{
        self.model = NULL;
    }
}

@end
