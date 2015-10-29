#import <Foundation/Foundation.h>

@interface MyItem : NSObject

@property (nonatomic,copy) NSString *leftText;
@property (nonatomic,copy) NSString *rightText;

//消息中心所用model
@property (nonatomic,copy)NSString *Content;
@property (nonatomic,copy)NSString *CreateTime;
@property (nonatomic,copy)NSString *Id;
@property (nonatomic,copy)NSString *IsRead;
@property (nonatomic,copy)NSString *MsgDetailURL;

//使用帮助所用model
@property (nonatomic,copy)NSString *AddDate;
@property (nonatomic,copy)NSString *AnsContent;
@property (nonatomic,copy)NSString *Title;

//评论列表所用model
@property (nonatomic,copy)NSString *commentsUserName;
@property (nonatomic,copy)NSString *commentsFundReview;
@property (nonatomic,copy)NSString *commentsSendTime;
@end
