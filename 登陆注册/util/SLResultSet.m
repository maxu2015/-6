#import "SLResultSet.h"

@interface SLResultSet(){
    NSArray *_resultSetArray;
    NSDictionary *_columnNameToIndexMap;
    NSMutableDictionary *_columnIndexToNameMap;
    int _currentRow;
}

@end

@implementation SLResultSet

static NSString *columnIndexToNameKey = @"ColumnIndexToNameKey";

- (id)init{
    if(self = [super init]){
        _currentRow = -1;
        _columnIndexToNameMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setResultSet:(NSArray *)resultSetArray{
    _resultSetArray = resultSetArray;
}

- (void)setColumnNameToIndexMap:(NSMutableDictionary *)columnNameToIndexMap{
    _columnNameToIndexMap = columnNameToIndexMap;
    NSArray *values = [columnNameToIndexMap allValues];
    NSArray *keys = [columnNameToIndexMap allKeys];
    if(keys != nil && keys.count > 0){
        for(int i = 0; i < keys.count; i ++){
            NSString *key = [NSString stringWithFormat:@"%@%@", columnIndexToNameKey, values[i]];
            [_columnIndexToNameMap setValue:keys[i] forKey:key];
        }
    }
}

- (BOOL)next{
    _currentRow ++;
    if(self.rowCount && _currentRow < self.rowCount){
        return YES;
    }
    return NO;
}

- (NSUInteger)rowCount{
    return [_resultSetArray count];
}

- (NSUInteger)columnCount{
    return [_columnNameToIndexMap count];
}

- (NSArray *)allColumnName{
    return [_columnNameToIndexMap allKeys];
}

- (int)columnIndexForName:(NSString*)columnName{
    return [_columnNameToIndexMap[[columnName lowercaseString]] intValue];
}
- (NSString*)columnNameForIndex:(int)columnIndex{
    NSString *name = [NSString stringWithFormat:@"%@%d", columnIndexToNameKey, columnIndex];
    return _columnIndexToNameMap[name];
}

- (int)intForColumn:(NSString*)columnName{
    NSDictionary *valueDictionary = _resultSetArray[_currentRow];
    return [valueDictionary[[columnName lowercaseString]] intValue];
}
- (int)intForColumnIndex:(int)columnIndex{
    NSString *columnName = [self columnNameForIndex:columnIndex];
    return [self intForColumn:columnName];
}

- (long)longForColumn:(NSString*)columnName{
    NSDictionary *valueDictionary = _resultSetArray[_currentRow];
    return [valueDictionary[[columnName lowercaseString]] longValue];
}
- (long)longForColumnIndex:(int)columnIndex{
    NSString *columnName = [self columnNameForIndex:columnIndex];
    return [self longForColumn:columnName];
}

- (long long int)longLongIntForColumn:(NSString*)columnName{
    NSDictionary *valueDictionary = _resultSetArray[_currentRow];
    return [valueDictionary[[columnName lowercaseString]] longLongValue];
}
- (long long int)longLongIntForColumnIndex:(int)columnIndex{
    NSString *columnName = [self columnNameForIndex:columnIndex];
    return [self longLongIntForColumn:columnName];
}

- (BOOL)boolForColumn:(NSString*)columnName{
    NSDictionary *valueDictionary = _resultSetArray[_currentRow];
    return [valueDictionary[[columnName lowercaseString]] boolValue];
}
- (BOOL)boolForColumnIndex:(int)columnIndex{
    NSString *columnName = [self columnNameForIndex:columnIndex];
    return [self boolForColumn:columnName];
}

- (double)doubleForColumn:(NSString*)columnName{
    NSDictionary *valueDictionary = _resultSetArray[_currentRow];
    return [valueDictionary[[columnName lowercaseString]] doubleValue];
}
- (double)doubleForColumnIndex:(int)columnIndex{
    NSString *columnName = [self columnNameForIndex:columnIndex];
    return [self doubleForColumn:columnName];
}

- (NSString*)stringForColumn:(NSString*)columnName{
    NSDictionary *valueDictionary = _resultSetArray[_currentRow];
    return valueDictionary[[columnName lowercaseString]];
}
- (NSString*)stringForColumnIndex:(int)columnIndex{
    NSString *columnName = [self columnNameForIndex:columnIndex];
    return [self stringForColumn:columnName];
}

- (NSDate*)dateForColumn:(NSString*)columnName{
    NSDictionary *valueDictionary = _resultSetArray[_currentRow];
    return (NSDate *)valueDictionary[[columnName lowercaseString]];
}
- (NSDate*)dateForColumnIndex:(int)columnIndex{
    NSString *columnName = [self columnNameForIndex:columnIndex];
    return [self dateForColumn:columnName];
}

- (NSData*)dataForColumn:(NSString*)columnName{
    NSDictionary *valueDictionary = _resultSetArray[_currentRow];
    NSUInteger length = [valueDictionary[[columnName lowercaseString]] length];
    return [NSData dataWithBytes:[valueDictionary[[columnName lowercaseString]] bytes] length:length];
}
- (NSData*)dataForColumnIndex:(int)columnIndex{
    NSString *columnName = [self columnNameForIndex:columnIndex];
    return [self dataForColumn:columnName];
}

- (id)objectForColumnName:(NSString*)columnName{
    NSDictionary *valueDictionary = _resultSetArray[_currentRow];
    return valueDictionary[[columnName lowercaseString]];
}
- (id)objectForColumnIndex:(int)columnIndex{
    NSString *columnName = [self columnNameForIndex:columnIndex];
    return [self objectForColumnName:columnName];
}

- (BOOL)columnIndexIsNull:(int)columnIndex{
    NSString *columnName = [self columnNameForIndex:columnIndex];
    return [self columnIsNull:columnName];
}
- (BOOL)columnIsNull:(NSString*)columnName{
    NSDictionary *valueDictionary = _resultSetArray[_currentRow];
    id value = valueDictionary[[columnName lowercaseString]];
    return [value isKindOfClass:[NSNull class]];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"\n{\n\t\"rowCount\" : \"%lu\", \n\t\"columnCount\" : \"%lu\", \n\t\"data\" : \"%@\"\n}", (unsigned long)[self rowCount], (unsigned long)[self columnCount], [self arrayToString:_resultSetArray]];
}

- (NSString *)arrayToString:(NSArray *)array{
    NSMutableString *ms = [[NSMutableString alloc] init];
    [ms appendString:@"["];
    for(int i = 0; i < array.count; i ++){
        NSDictionary *dictionary = array[i];
        if(i != 0){
            [ms appendFormat:@"\t%@", [self dictionaryToString:dictionary]];
        }else{
            [ms appendString:[self dictionaryToString:dictionary]];
        }
        if(i != array.count - 1){
            [ms appendString:@", \n"];
        }
    }
    [ms appendString:@"]"];
    return [ms copy];
}

- (NSString *)dictionaryToString:(NSDictionary *)dictionary{
    NSMutableString *ms = [[NSMutableString alloc] init];
    NSArray *keys = [dictionary allKeys];
    [ms appendString:@"{\n"];
    for(int i = 0; i < keys.count; i ++){
        id value = dictionary[keys[i]];
        if([value isKindOfClass:[NSData class]]){
            // 字典中的二进制数据显示为'<blob>'
            [ms appendFormat:@"\t\t\"%@\" : <blob>", keys[i]];
        }else{
            [ms appendFormat:@"\t\t\"%@\" : \"%@\"", keys[i], dictionary[keys[i]]];
        }
        if(i != keys.count - 1){
            [ms appendString:@", \n"];
        }
    }
    [ms appendString:@"\n\t}"];
    return [ms copy];
}

@end
