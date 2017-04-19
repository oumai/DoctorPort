//
//  ASnewSqlTool.m
//  AngelSoundsButler
//
//  Created by apple on 15/10/11.
//  Copyright © 2015年 黄云晋. All rights reserved.
//

#import "ASnewSqlTool.h"
#import "FMDB.h"
@implementation ASnewSqlTool
static FMDatabase *_db;
+(void)createNewsTable:(NSString *)moboleNum{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JNews.sqlite"];
    NSLog(@"%@",path);
    _db = [FMDatabase databaseWithPath:path];
    [_db open];

    NSString *tableString=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (time text, detail text);",moboleNum];
  
    [_db executeUpdate:tableString];
}
+(void)addNews:(NSDictionary *)NewJ andTable:(NSString *)moboleNum{
    
    NSString *string=[NSString stringWithFormat:@"INSERT INTO %@(time,detail) VALUES ('%@', '%@');",moboleNum,[NewJ objectForKey:@"time"],[NewJ objectForKey:@"detail"]];
    NSLog(@"插入语句%@",string);
    BOOL res= [_db executeUpdate:string];
    if (!res) {
        NSLog(@"插入失败");
    } else {
        NSLog(@"插入成功");
    }
    
}

+(NSMutableArray *)selectAllNewsAndTable:(NSString *)moboleNum{
    
    NSMutableArray *persons=[NSMutableArray array];
    NSString *string=[NSString stringWithFormat:  @"SELECT * FROM %@;",moboleNum];
    
    FMResultSet *set = [_db executeQuery:string];

    while (set.next) {
        NSDictionary *dic=[[NSDictionary alloc]init];
        
        NSString *timeStr=[set stringForColumn:@"time"];
        NSString * detailStr=[set stringForColumn:@"detail"];
        dic=[NSDictionary dictionaryWithObjectsAndKeys:
             timeStr.length==0?@"":timeStr,@"time",
             detailStr.length==0?@"":detailStr,@"detail",
             nil];
   
        NSLog(@"%@",dic);
        [persons addObject:dic];
        
    }
    return persons;
    
}
@end
