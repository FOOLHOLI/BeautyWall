//
//  MainViewController.m
//  BeautyWall
//
//  Created by AKI on 2015/3/10.
//  Copyright (c) 2015年 AKI. All rights reserved.
//

#import "MainViewController.h"
#import "UIImageView+WebCache.h"
#import "mBtn.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize mArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"MyCellView" bundle:nil];
    [mCollection registerNib:cellNib forCellWithReuseIdentifier:@"MyCustomCell"];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UICollectionViewDataSource methods

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCustomCell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    
    mBtn *btn1 = (mBtn *)[cell viewWithTag:101];
    btn1.idx = (int)indexPath.row;
    [btn1 addTarget:self action:@selector(btn_click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://i.gbc.tw/gb_img/s100x100/%@.jpg",[[mArray objectAtIndex:indexPath.row] objectForKey:@"img_no"]]] placeholderImage:[UIImage imageNamed:@"images.png"]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mArray.count;
}

#pragma mark - UICollectionViewDelegate methods

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d selected", (int)indexPath.row);
}

-(void)btn_click:(mBtn *)sender{
    NSLog(@"%d",sender.idx);
    [[[UIAlertView alloc] initWithTitle:@"" message:[[mArray objectAtIndex:sender.idx] objectForKey:@"name"] delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil] show];
    
}


@end
