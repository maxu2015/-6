//
//  HCServer.m
//  SimpleHTTPCall
//
//  Created by  展恒 on 15-3-25.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "HCServer.h"

@interface HCServer()<NSXMLParserDelegate>

@end

@implementation HCServer


-(void)getServerUrl:(NSString *)url{

    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:URL];
    [theRequest setHTTPMethod:@"GET"];
    [theRequest setValue:@"text/plain; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    self.getConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (_getConnection) {
        _getData = [[NSMutableData alloc] init];
    }

}

#pragma mark-----get_block

-(void)sendAsynchronousRequest:(NSString *)url withBlock:(sendAsynchronousRequest)block{

    NSURL *dataURL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:dataURL];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"text/plain; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        block(data,connectionError);
    }];
    
    

}

#pragma mark-----xml

/*
 
解析xml
 */

-(void)sendAsynchronousRequestXML:(NSString *)url{

    NSURL *dataURL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:dataURL];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"text/plain; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (!connectionError) {
            NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
            parser.delegate = self ;
            [parser parse];
        }
    }];
}


#pragma mark------NSXMLParserDelegate

-(void)parserDidStartDocument:(NSXMLParser *)parser {
    //开始解析
    
}

//遇到一个开始标签的触发
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    
    if ([elementName isEqualToString:@"return"]) {
        
        _currentTagNameHead = elementName ;
        _currentTagName = [[NSMutableString alloc] initWithCapacity:0];
    }
    
}

//遇到字符串的触发
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    NSLog(@"-----%@",string);
    
    
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
}

//解析失败
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    
   
    
}
//遇到文件结束
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    
    id dic = [self dictionaryWithJsonString:_currentTagName];
    
    _XMLBlock(dic);
   
}

-(void)getXMLdata:(getXMLdataForDic)block{

    if (block) {
        _XMLBlock = block ; 
    }

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


#pragma mark-----get

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_getData setLength:0];//开始

}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_getData appendData:data];//追加

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{

    
    if (_delegate&&[_delegate respondsToSelector:@selector(getRequestFinish:)]) {
        [_delegate getRequestFinish:_getData];
    }
   
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

//加载失败
    if (_delegate&&[_delegate respondsToSelector:@selector(getRequestFaill:)]) {
        [_delegate getRequestFaill:error];
    }
}

@end
