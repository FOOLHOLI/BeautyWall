//
//  MainViewController.h
//  BeautyWall
//
//  Created by AKI on 2015/3/10.
//  Copyright (c) 2015年 AKI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    IBOutlet UICollectionView *mCollection;
    
}

@property (nonatomic,retain) NSMutableArray *mArray;

@end
