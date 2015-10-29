//
//  ZHMREcommend_ViewController.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/7/24.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetManager.h"

@interface ZHMREcommend_ViewController : UIViewController<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    NetManager * _net;
}

@property(nonatomic, strong) NSMutableArray * dataSource;

- (IBAction)pressBackBtn:(id)sender;


@property (strong, nonatomic) IBOutlet UICollectionView *table;

@end
