#import <Foundation/Foundation.h>

@interface SLResultSet : NSObject

/**
 *  设置结果集数据
 *
 *  @param resultSetArray 结果集数据
 */
- (void)setResultSet:(NSArray *)resultSetArray;

/**
 *  设置查询结果集列号与列名的对应关系(key:列名 value:列号)
 *
 *  @param columnNameToIndexMap 字典
 */
- (void)setColumnNameToIndexMap:(NSDictionary *)columnNameToIndexMap;

/**
 *  是否有下一条数据
 *
 */
- (BOOL)next;

/**
 *  结果集的总行数
 *
 */
- (NSUInteger)rowCount;

/**
 *  结果集的总列数
 *
 */
- (NSUInteger)columnCount;

/**
 *  结果集的所有列名
 *
 */
- (NSArray *)allColumnName;

/**
 *  根据列名返回对应的列号
 *
 *  @param columnName 列名
 *
 *  @return 列号
 */
- (int)columnIndexForName:(NSString*)columnName;
/**
 *  根据列号返回对应的列名
 *
 *  @param columnIndex 列号
 *
 *  @return 列名
 */
- (NSString*)columnNameForIndex:(int)columnIndex;

/**
 *  根据列名或列号返回int类型的值
 *
 */
- (int)intForColumn:(NSString*)columnName;
- (int)intForColumnIndex:(int)columnIndex;

/**
 *  根据列名或列号返回long类型的值
 *
 */
- (long)longForColumn:(NSString*)columnName;
- (long)longForColumnIndex:(int)columnIndex;

/**
 *  根据列名或列号返回long long类型的值
 *
 */
- (long long int)longLongIntForColumn:(NSString*)columnName;
- (long long int)longLongIntForColumnIndex:(int)columnIndex;

/**
 *  根据列名或列号返回BOOL类型的值
 *
 */
- (BOOL)boolForColumn:(NSString*)columnName;
- (BOOL)boolForColumnIndex:(int)columnIndex;

/**
 *  根据列名或列号返回double类型的值
 *
 */
- (double)doubleForColumn:(NSString*)columnName;
- (double)doubleForColumnIndex:(int)columnIndex;

/**
 *  根据列名或列号返回NSString类型的值
 *
 */
- (NSString*)stringForColumn:(NSString*)columnName;
- (NSString*)stringForColumnIndex:(int)columnIndex;

/**
 *  根据列名或列号返回NSDate类型的值
 *
 */
- (NSDate*)dateForColumn:(NSString*)columnName;
- (NSDate*)dateForColumnIndex:(int)columnIndex;

/**
 *  根据列名或列号返回NSData类型的值
 *
 */
- (NSData*)dataForColumn:(NSString*)columnName;
- (NSData*)dataForColumnIndex:(int)columnIndex;

/**
 *  根据列名或列号返回id类型的值
 *
 */
- (id)objectForColumnName:(NSString*)columnName;
- (id)objectForColumnIndex:(int)columnIndex;

/**
 *  根据列名或列号判断值是否为NULL，注意不是判断nil或者@""
 *
 */
- (BOOL)columnIndexIsNull:(int)columnIndex;
- (BOOL)columnIsNull:(NSString*)columnName;

@end
