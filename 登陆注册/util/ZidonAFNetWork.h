#import <Foundation/Foundation.h>

@protocol zidonDelegate <NSObject>

-(void)requestFinished:(NSDictionary *)parmeters;
-(void)requestFailed:(NSError *)error;

@end

@interface ZidonAFNetWork : NSObject

+(instancetype)sharedInstace;
//get请求
-(void)requestWithUrl:(NSString *)url withDelegate:(id<zidonDelegate>)delegate;
//post请求
-(void)requestWithUrl:(NSString *)url wihtParmeters:(NSDictionary *)parmeters withDelegate:(id<zidonDelegate>)delegate jsonValue:(BOOL)value;
@property (nonatomic,assign) BOOL isNetWork;
@property (nonatomic,weak) id<zidonDelegate> delegate;
@property (nonatomic,copy) NSString *postValueKey;

//上传图片

@end
