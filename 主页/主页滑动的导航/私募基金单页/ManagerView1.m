//
//  ManagerView1.m
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "ManagerView1.h"
#import "UIImageView+WebCache.h"
@implementation ManagerView1


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [COLOR_RGB(51, 187, 238) CGColor];
        self.layer.borderWidth = 1 ;
        //(3, 5, 63, 80)
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 5, 63, 80)];
        _headImgView.backgroundColor = COLOR_RGB(83, 83, 83);
        [self addSubview:_headImgView];
        _jingliName = [self creatLB];
        _jingliName.frame = CGRectMake(72, 10, 310-72, 15);
        _jingliName.font = [UIFont systemFontOfSize:13];
        _jingliName.textColor = COLOR_RGB(51, 187, 238);
        [self addSubview:_jingliName];
        
        
        _jingliName2 = [self creatLB];
        _xueliLB = [self creatLB];
        _productNubLB = [self creatLB];
        _schoolLB = [self creatLB];
        _comLB = [self creatLB];
        _yearLB = [self creatLB];
        
        NSArray *uiarray = [[NSArray alloc] initWithObjects:_jingliName2,_xueliLB,_productNubLB,_schoolLB,_comLB,_yearLB, nil];
        for (int i = 0; i<6; i++) {
            float posY = 35+17*(i/2);
            float posX =72+108*(i%2);
            UILabel *mylabel = [uiarray objectAtIndex:i];
            [self addSubview:mylabel];
            if (i%2==0) {
                mylabel.frame = CGRectMake(posX, posY, 108, 17);
            }
            else{
            mylabel.frame = CGRectMake(posX, posY, 310-108-72, 17);
            }
        }
        
    }
    return self;
}

-(void)reloadContentData:(NSArray *)mangerArr{
    
    NSDictionary *dic = [mangerArr objectAtIndex:0];
    
    NSLog(@"========%@",dic);
    if ([dic isKindOfClass:[NSDictionary class]]) {
        _jingliName.text  = [NSString stringWithFormat:@"经理姓名：%@",[dic objectForKey:@"ManageName"]];
        _jingliName2.text = [NSString stringWithFormat:@"经理姓名：%@",[dic objectForKey:@"ManageName"]];
        
        _xueliLB.text = [NSString stringWithFormat:@"学      历：%@",[dic objectForKey:@"Degree"]];
        _productNubLB.text =[NSString stringWithFormat:@"旗下产品：%@支",[dic objectForKey:@"FundProduct"]];
        _schoolLB.text = [NSString stringWithFormat:@"毕业院校：%@",[dic objectForKey:@"Colleges"]];;//毕业院校：
        _comLB.text = [NSString stringWithFormat:@"所在公司：%@",[dic objectForKey:@"CompName"]];//@"清水源投资";
        _yearLB.text = [NSString stringWithFormat:@"从业经验：%@年",[dic objectForKey:@"Experience"]];//@"从业经验：9年";
        
        NSString *PicName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"PicName"]];
        
       
        NSURL *photourl = [NSURL URLWithString:PicName];
        UIImage *images = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];
        _headImgView.image = images;
        
       // UIImage *headImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:PicName]]];
        //UIImageJPEGRepresentation(headImg, .1);
       // _headImgView.image = headImg ;
        NSLog(@"====pic = %@===%@===%@",PicName,[PicName class],images);
        [_headImgView setImageWithURL:[NSURL URLWithString:[PicName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:nil];
    }
    

}
-(UILabel *)creatLB{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = COLOR_RGB(73, 73, 73);
    label.textAlignment = NSTextAlignmentLeft;
    label.adjustsFontSizeToFitWidth = YES ;
    return label;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
