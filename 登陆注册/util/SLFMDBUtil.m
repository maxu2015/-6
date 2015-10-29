#import "SLFMDBUtil.h"
#import "FMDB.h"

#define DataFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"person.db"]

@implementation SLFMDBUtil

static FMDatabaseQueue *_queue;

+ (void)initialize{
    [self loadDatabase];
}

+ (void)loadDatabase{
    // 如果数据库文件不存在，说明表也不存在，则需要执行SQL语句创建表
    if(![[NSFileManager defaultManager] fileExistsAtPath:DataFilePath]){
        [self loadDatabaseQueue];
    }
    if(![self tableIsExist:@"person"]){
        [_queue inDatabase:^(FMDatabase *db) {
            NSString *sql = @"create table if not exists person (id integer primary key autoincrement, nickName,passWord,phoneNum,userName,userSex,manNum,userEmail);";
            NSError *error;
            BOOL isSuccess = [db executeUpdate:sql withErrorAndBindings:&error];
            if(!isSuccess){
                YYLog(@"执行的建表SQL语句: %@. \n失败原因: %@", sql, [error localizedDescription]);
            }
            [db close];
        }];
    }
}

+ (BOOL)tableIsExist:(NSString *)tableName{
    NSString *sql = [NSString stringWithFormat:@"select count(*) as table_count from sqlite_master t where t.type = 'table' and t.name = '%@'", tableName];
    [self loadDatabaseQueue];
    __block BOOL isExist = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        if([rs next]){
            isExist = [rs intForColumn:@"table_count"];
        }
        [db close];
    }];
    [_queue close];
    return isExist;
}

+ (void)loadDatabaseQueue{
    _queue = [FMDatabaseQueue databaseQueueWithPath:DataFilePath];
}

+ (BOOL)executeUpdate:(NSString *)sql, ...{
    va_list args;
    // 初始化va_list指针变量,即将args指向sql
    va_start(args, sql);
    [self loadDatabaseQueue];
    __block BOOL isSuccess = NO;
    __block FMDatabase *baseDB = nil ;
    [_queue inDatabase:^(FMDatabase *db) {
        baseDB = db ;
        
    }];
    isSuccess = [baseDB executeUpdate:sql withVAList:args];
    [baseDB close];
    // 清空参数列表,置指针args无效
    va_end(args);
    [_queue close];
    return isSuccess;
}

+ (BOOL)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)argumentsArray{
    [self loadDatabaseQueue];
    __block BOOL isSuccess = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        isSuccess = [db executeUpdate:sql withArgumentsInArray:argumentsArray];
        [db close];
    }];
    [_queue close];
    return isSuccess;
}

+ (SLResultSet *)executeQuery:(NSString *)sql, ...{
    va_list args;
    // 初始化va_list指针变量,即将args指向sql
    va_start(args, sql);
    [self loadDatabaseQueue];
    __block SLResultSet *resultSet = nil;
    __block FMDatabase *baseDB = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        baseDB = db;
       
    }];
    //[baseDB open];
    FMResultSet *rs = [baseDB executeQuery:sql withVAList:args];
    resultSet = [self convertResultSet:rs];
    [baseDB close];
    
    // 清空参数列表,置指针args无效
    va_end(args);
    [_queue close];
    return resultSet;
}

+ (SLResultSet *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)argumentsArray{
    [self loadDatabaseQueue];
    __block SLResultSet *resultSet = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql withArgumentsInArray:argumentsArray];
        resultSet = [self convertResultSet:rs];
        [db close];
    }];
    [_queue close];
    return resultSet;
}

/**
 *  结果转换，将FMResultSet转换为SLResultSet
 *
 *  @param rs FMDB结果集
 *
 *  @return 自定义结果集
 */
+ (SLResultSet *)convertResultSet:(FMResultSet *)rs{
    SLResultSet *resultSet = [[SLResultSet alloc] init];
    [resultSet setColumnNameToIndexMap:rs.columnNameToIndexMap];
    NSMutableArray *resultSetArray = [NSMutableArray array];
    int columnCount = [rs columnCount];
    while ([rs next]) {
        NSMutableDictionary *valuesMap = [NSMutableDictionary dictionary];
        for(int i = 0; i < columnCount; i ++){
            // 以小写key存储
            NSString *columnName = [[rs columnNameForIndex:i] lowercaseString];
            id columnValue = [rs objectForColumnIndex:i];
            [valuesMap setValue:columnValue forKey:columnName];
        }
        [resultSetArray addObject:valuesMap];
    }
    [resultSet setResultSet:[resultSetArray copy]];
    return resultSet;
}

+ (BOOL)executeStatements:(NSString *)sql{
    [self loadDatabaseQueue];
    __block BOOL isSuccess = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        isSuccess = [db executeStatements:sql];
        [db close];
    }];
    [_queue close];
    return isSuccess;
}

@end
