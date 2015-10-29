#import <Foundation/Foundation.h>
#import "SLResultSet.h"

@interface SLFMDBUtil : NSObject

/**
 *  执行数据库的update语句(建议?占位符个数固定时使用)
 *
 *  @param sql, ... SQL语句及其中的?替换参数
 *
 *  @return YES: 执行成功, NO: 执行失败
 */
+ (BOOL)executeUpdate:(NSString *)sql, ...;

/**
 *  执行数据库的update语句(建议?占位符个数不固定时使用)
 *
 *  @param sql            SQL语句，可以包含有?占位符
 *  @param argumentsArray ?占位符的替换值(?占位符必须与数组值一一对应)
 *
 *  @return YES: 执行成功, NO: 执行失败
 */
+ (BOOL)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)argumentsArray;

/**
 *  执行数据库的查询语句(建议?占位符个数固定时使用)
 *
 *  @param sql, ... SQL语句及其中的?替换参数
 *
 *  @return 查询的结果集
 */
+ (SLResultSet *)executeQuery:(NSString *)sql, ...;

/**
 *  执行数据库的查询语句(建议?占位符个数不固定时使用)
 *
 *  @param sql            SQL语句，可以包含有?占位符
 *  @param argumentsArray ?占位符的替换值(?占位符必须与数组值一一对应)
 *
 *  @return 查询的结果集
 */
+ (SLResultSet *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)argumentsArray;


/**
 *  SQL语句正确性校验
 *
 *  @param sql SQL语句,必须是完整的SQL,其中不能带有?占位符
 *
 *  @return YES:正确(能正常执行),NO:不正确(执行报错)
 */
+ (BOOL)executeStatements:(NSString *)sql;

@end
