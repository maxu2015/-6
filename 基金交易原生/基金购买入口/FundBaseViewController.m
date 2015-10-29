//
//  FundBaseViewController.m
//  jiami2
//
//  Created by  展恒 on 15-1-5.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//


#import "FundBaseViewController.h"
#import "MYGTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>
#import "TipLabel.h"
@interface FundBaseViewController ()<NSXMLParserDelegate>
{
    NSString * element;
}
@end

@implementation FundBaseViewController

- (void)showToastWithMessage:(NSString *)message showTime:(float)interval
{
    TipLabel * tip = [[TipLabel alloc] init];
    [tip showToastWithMessage:message showTime:interval];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)requestDataURL:(NSString *)URL

{
    
    if (_dic) {
        _dic = nil ;
    }
    NSLog(@"=====URL==%@",URL);
    NSURL *dataURL = [NSURL URLWithString:URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:dataURL];
    

        [request setHTTPMethod:@"GET"];
        [request setValue:@"text/plain; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    //设置请求头，Content-Length字段
    //[request setValue:[NSString stringWithFormat:@"%ld", [envelope length]] forHTTPHeaderField:@"Content-Length"];
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            [self requestDataError:connectionError];
            
        }
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        NSLog(@"data//=%@", data);
        parser.delegate = self ;
        [parser parse];
        
    }];
}


#pragma mark-----请求数据出错了

-(void)requestDataError:(NSError *)err{

    NSLog(@"xx------%@",err);

}
#pragma mark------NSXMLParserDelegate

-(void)parserDidStartDocument:(NSXMLParser *)parser {
    //开始解析
    
    _notes = [NSMutableArray new];
}

//遇到一个开始标签的触发
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    NSLog(@"elementName=%@", elementName);
    if ([elementName isEqualToString:@"return"]) {
        _currentTagNameHead = elementName ;
        _currentTagName = [[NSMutableString alloc] initWithCapacity:0];
    }
    
}

//遇到字符串的触发
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    element = [string copy];
    NSLog(@"-----pppp=%@",string);
    
    
    if ([_currentTagNameHead isEqualToString:@"return"]) {
        
        
        // NSLog(@"-----%@",string);
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [_currentTagName appendString:string];
        //NSLog(@"------%@",_currentTagName);
        
    }
    
}

//遇到结束标签触发
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([_currentTagNameHead isEqualToString:@"return"]) {
    }
    if ([elementName isEqualToString:@"return"]) {
        NSLog(@"elelment==%@", element);
    }
}

//解析失败
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    
    [self requestDataEnd] ;
    
}
//遇到文件结束
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    
    _dic = [self dictionaryWithJsonString:_currentTagName];
    
    NSLog(@"----1_currentTagName=%@", _currentTagName);
    NSLog(@"-------数据请求结束=%@",_dic);//数据请求结束
    
    [self requestDataEnd];
}

-(void)requestDataEnd{
    
}

//json转字典
- (id)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                          options:NSJSONReadingMutableContainers
                                                            error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//json转数组
- (NSMutableArray *)nsarrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    NSLog(@"%@",arr);
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return arr;
}
//处理url特殊字符
-(NSString *)UrlEncodedString:(NSString *)sourceText
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)sourceText ,NULL ,CFSTR("!*'();:|@&=+$,/?%#[]") ,kCFStringEncodingUTF8));
   // NSLog(@"------%@",result);
       return result;
}

/*字符串加密
 *参数
 *plainText : 加密明文
 *key        : 密钥 64位
 */
- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    Byte iv[] = {1,2,3,4,5,6,7,8};
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [[NSString alloc] initWithData:[MYGTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }
    return ciphertext;
}

//解密
- (NSString *) decryptUseDES:(NSString*)cipherText key:(NSString*)key
{
    NSData* cipherData = [MYGTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
