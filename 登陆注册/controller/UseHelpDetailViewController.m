//
//  UseHelpDetailViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "UseHelpDetailViewController.h"

@interface UseHelpDetailViewController ()

@end

@implementation UseHelpDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _questionTitleLabel.text = self.questionTitle;
    CGSize size = [self.useHelpDetail sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(240, 999) lineBreakMode:NSLineBreakByCharWrapping];
    _answerDetail.font = [UIFont systemFontOfSize:15];
    _answerDetail.numberOfLines = 0;
    _answerDetail.frame = CGRectMake(20, 50, size.width, size.height);
    _addDate.frame = CGRectMake(101, 70+size.height, 159, 21);
    _bgView.frame = CGRectMake(20, 109, 280,size.height+91);
    _answerDetail.text = self.useHelpDetail;
    _addDate.text = self.addTime;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
