//
//  MYGTMBase64.h
//  CaiLiFang
//
//  Created by  展恒 on 15-3-12.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYGTMBase64 : NSObject
//
// Standard Base64 (RFC) handling
//

// encodeData:
//
/// Base64 encodes contents of the NSData object.
//
/// Returns:
///   A new autoreleased NSData with the encoded payload.  nil for any error.
//
+(NSData *)encodeData:(NSData *)data;

// decodeData:
//
/// Base64 decodes contents of the NSData object.
//
/// Returns:
///   A new autoreleased NSData with the decoded payload.  nil for any error.
//
+(NSData *)decodeData:(NSData *)data;

// encodeBytes:length:
//
/// Base64 encodes the data pointed at by |bytes|.
//
/// Returns:
///   A new autoreleased NSData with the encoded payload.  nil for any error.
//
+(NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;

// decodeBytes:length:
//
/// Base64 decodes the data pointed at by |bytes|.
//
/// Returns:
///   A new autoreleased NSData with the encoded payload.  nil for any error.
//
+(NSData *)decodeBytes:(const void *)bytes length:(NSUInteger)length;

// stringByEncodingData:
//
/// Base64 encodes contents of the NSData object.
//
/// Returns:
///   A new autoreleased NSString with the encoded payload.  nil for any error.
//
+(NSString *)stringByEncodingData:(NSData *)data;

// stringByEncodingBytes:length:
//
/// Base64 encodes the data pointed at by |bytes|.
//
/// Returns:
///   A new autoreleased NSString with the encoded payload.  nil for any error.
//
+(NSString *)stringByEncodingBytes:(const void *)bytes length:(NSUInteger)length;

// decodeString:
//
/// Base64 decodes contents of the NSString.
//
/// Returns:
///   A new autoreleased NSData with the decoded payload.  nil for any error.
//
+(NSData *)decodeString:(NSString *)string;

//
// Modified Base64 encoding so the results can go onto urls.
//
// The changes are in the characters generated and also allows the result to
// not be padded to a multiple of 4.
// Must use the matching call to encode/decode, won't interop with the
// RFC versions.
//

// webSafeEncodeData:padded:
//
/// WebSafe Base64 encodes contents of the NSData object.  If |padded| is YES
/// then padding characters are added so the result length is a multiple of 4.
//
/// Returns:
///   A new autoreleased NSData with the encoded payload.  nil for any error.
//
+(NSData *)webSafeEncodeData:(NSData *)data
                      padded:(BOOL)padded;

// webSafeDecodeData:
//
/// WebSafe Base64 decodes contents of the NSData object.
//
/// Returns:
///   A new autoreleased NSData with the decoded payload.  nil for any error.
//
+(NSData *)webSafeDecodeData:(NSData *)data;

// webSafeEncodeBytes:length:padded:
//
/// WebSafe Base64 encodes the data pointed at by |bytes|.  If |padded| is YES
/// then padding characters are added so the result length is a multiple of 4.
//
/// Returns:
///   A new autoreleased NSData with the encoded payload.  nil for any error.
//
+(NSData *)webSafeEncodeBytes:(const void *)bytes
                       length:(NSUInteger)length
                       padded:(BOOL)padded;

// webSafeDecodeBytes:length:
//
/// WebSafe Base64 decodes the data pointed at by |bytes|.
//
/// Returns:
///   A new autoreleased NSData with the encoded payload.  nil for any error.
//
+(NSData *)webSafeDecodeBytes:(const void *)bytes length:(NSUInteger)length;

// stringByWebSafeEncodingData:padded:
//
/// WebSafe Base64 encodes contents of the NSData object.  If |padded| is YES
/// then padding characters are added so the result length is a multiple of 4.
//
/// Returns:
///   A new autoreleased NSString with the encoded payload.  nil for any error.
//
+(NSString *)stringByWebSafeEncodingData:(NSData *)data
                                  padded:(BOOL)padded;

// stringByWebSafeEncodingBytes:length:padded:
//
/// WebSafe Base64 encodes the data pointed at by |bytes|.  If |padded| is YES
/// then padding characters are added so the result length is a multiple of 4.
//
/// Returns:
///   A new autoreleased NSString with the encoded payload.  nil for any error.
//
+(NSString *)stringByWebSafeEncodingBytes:(const void *)bytes
                                   length:(NSUInteger)length
                                   padded:(BOOL)padded;

// webSafeDecodeString:
//
/// WebSafe Base64 decodes contents of the NSString.
//
/// Returns:
///   A new autoreleased NSData with the decoded payload.  nil for any error.
//
+(NSData *)webSafeDecodeString:(NSString *)string;
@end
