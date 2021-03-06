//
//  NewFeatureViewController.m
//  新浪微博
//
//  Created by TOM on 15/4/4.
//  Copyright (c) 2015年 C.C.R. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "MainViewController.h"
#import "UIImage+Thh.h"

#define kCount 4

@interface NewFeatureViewController ()<UIScrollViewDelegate>{

    UIScrollView *_scrollView;
    UIPageControl *_page;
}

@end

@implementation NewFeatureViewController
#pragma mark 自定义view
-(void)loadView{

    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.image=[UIImage fullscreenImage:@"new_feature_background.png"];
    imageView.frame=[UIScreen mainScreen].applicationFrame;
    // 给用户交互
    imageView.userInteractionEnabled=YES;
    self.view=imageView;
    
} 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addScrollView];
    
    [self addScrollImages];
    
    [self addPageController];
    
   
    //self.view.backgroundColor=[UIColor blueColor];
    // Do any additional setup after loading the view.
}
#pragma  mark -UI界面初始化
-(void)addScrollView{
    UIScrollView *scrollView=[[UIScrollView alloc]init];
    scrollView.frame=self.view.bounds;
    scrollView.showsHorizontalScrollIndicator=NO;//隐藏水平滚动条
    CGSize size=scrollView.frame.size;
    scrollView.contentSize=CGSizeMake(size.width*kCount, 0);//内容尺寸
    scrollView.pagingEnabled=YES;//分页
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    _scrollView=scrollView;
    
}
-(void)addScrollImages{
    CGSize size=_scrollView.frame.size;
    for (int i=0; i<kCount; i ++) {

       UIImageView *imageView=[[UIImageView alloc]init];
       //显示图片
        NSString *name=[NSString stringWithFormat:@"new_feature_%d.png",i+1];
       imageView.image=[UIImage fullscreenImage:name];
       imageView.frame=CGRectMake(i*size.width, 0, size.width, size.height);
        //设置frame
        [_scrollView  addSubview:imageView];
       
        if (i==kCount-1) {//最后一页添加两个按钮
            //立即开始
            UIButton *start=[UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *startNormal=[UIImage imageNamed:@"new_feature_finish_button.png"];
            [start setBackgroundImage:startNormal forState:UIControlStateNormal];
            [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted.png"] forState:UIControlStateHighlighted];
            start.center=CGPointMake(size.width*0.5, size.height*0.8);
            start.bounds=(CGRect){CGPointZero,startNormal.size};
            [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:start];

            //分享
            UIButton *share=[UIButton buttonWithType:UIButtonTypeCustom];
            //普通状态显示的图片
            UIImage *shareNormal=[UIImage imageNamed:@"new_feature_share_false.png"];
            [share setBackgroundImage:shareNormal forState:UIControlStateNormal];
            //选中状态下显示的图片
            [share setBackgroundImage:[UIImage imageNamed:@"new_feature_share_true.png"] forState:UIControlStateSelected];
            share.center=CGPointMake(start.center.x, start.center.y-50);
            share.bounds=(CGRect){CGPointZero,shareNormal.size};
            [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            //设置选中
            share.selected=YES;
            //按钮在高亮时不需要变成灰色
            share.adjustsImageWhenHighlighted=NO;
            [imageView addSubview:share];
            imageView.userInteractionEnabled=YES;
            
            
            }

    }
    
}
#pragma  mark 分页指示器
-(void)addPageController{

    CGSize size=self.view.frame.size;
    UIPageControl *PageController=[[UIPageControl alloc]init];
    PageController.center=CGPointMake(size.width*0.5, size.height*0.95);
    PageController.numberOfPages=kCount;
    PageController.currentPageIndicatorTintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]];
    PageController.pageIndicatorTintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]];
    PageController.bounds=CGRectMake(0, 0, 150, 0);
    [self.view addSubview:PageController];
    _page=PageController;
    
    
}
#pragma mark 监听按钮
#pragma mark 开始
-(void)start{
    
    [UIApplication sharedApplication].statusBarHidden=NO;
    self.view.window.rootViewController=[[MainViewController alloc]init];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark 分享
-(void)share:(UIButton*)btn{
    
    btn.selected=!btn.selected;
}
#pragma mark 滚动代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _page.currentPage=scrollView.contentOffset.x/scrollView.frame.size.width;

}




@end














