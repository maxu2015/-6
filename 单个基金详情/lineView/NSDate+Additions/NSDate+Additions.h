//
//  NSDate+Additions.h
//
//  Created by Wess Cope on 6/1/11.
//  Copyright 2012. All rights reserved.
//

#import <Foundation/Foundation.h>

struct DateInformation {
	int day;
	int month;
	int year;
	
	int weekday;
	
	int minute;
	int hour;
	int second;
	
};
typedef struct DateInformation DateInformation;

typedef enum {
    
    NSDateSecondsType = 0,
    NSDateMinutesType = 1,
    NSDateHoursType   = 2,
    NSDateDaysType    = 3,
    NSDateWeekType    = 4,
    NSDateMonthsType  = 5,
    NSDateYearType    = 6
    
} NSDateTimeType;

@interface NSDate(Additions)

+(int) unixTimestampFromDate:(NSDate *)aDate;
+(int) unixTimestampNow;
+ (NSDate *)date:(NSDate *)aDate add:(NSUInteger)increment of:(NSDateTimeType)type;

+ (NSDate *) yesterday;
+ (NSDate *) month;

- (NSDate *) monthDate;
//- (NSDate *) lastOfMonthDate;



- (BOOL) isSameDay:(NSDate*)anotherDate;
- (int) monthsBetweenDate:(NSDate *)toDate;
- (NSInteger) daysBetweenDate:(NSDate*)d;
- (BOOL) isToday;


- (NSDate *) dateByAddingDays:(NSUInteger)days;
+ (NSDate *) dateWithDatePart:(NSDate *)aDate andTimePart:(NSDate *)aTime;

- (NSString *) monthString;
- (NSString *) yearString;


- (DateInformation) dateInformation;
- (DateInformation) dateInformationWithTimeZone:(NSTimeZone*)tz;
+ (NSDate*) dateFromDateInformation:(DateInformation)info;
+ (NSDate*) dateFromDateInformation:(DateInformation)info timeZone:(NSTimeZone*)tz;
+ (NSString*) dateInformationDescriptionWithInformation:(DateInformation)info;

@end
