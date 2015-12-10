//
//  ViewController.m
//  DownLoadImage
//
//  Created by zhang xu on 15/11/21.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+Cache.h"
#import "CacheManager.h"
static NSString *IndetifCell =@"kcell";
#define Kurl @"http://api.tietuku.com/v2/api/getpiclist?key=aJnHxsVik5mYmpaWxWTImWFvn2aVnMNrmWuXZWaYmJqal8qWlGlqmsOblWmZZ5U="
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self addTableView];
    [self addBarItems];
    [self getData];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)addViews{
    self.view.backgroundColor =[UIColor whiteColor];
    
    
}

-(void)addTableView{
    
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    [self.view addSubview:self.tableView];
    
}

-(void)addBarItems{
    
    self.title =@"显示图片";
    
    UIBarButtonItem *left =[[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    self.navigationItem.leftBarButtonItem =left;
    self.navigationItem.rightBarButtonItem=right;

}
-(void)rightAction:(UIBarButtonItem *)sender{
    
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"显示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NULL;
    }]];
    
    NSString *string =[NSString stringWithFormat:@"清空缓存大小:%llu",[CacheManager cacheBytesCount]];
    
    alert.message =string;
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    [CacheManager clearCache];
    self.dataArray =nil;
    [self.tableView reloadData];
    
}




-(void)leftAction:(UIBarButtonItem *)sender{
    [self getData];
}
-(void)getData{
    __weak typeof(self)weakSelf =self;
    NSURL *url =[NSURL URLWithString:Kurl];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task =[[NSURLSession sharedSession]downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSData *content =[NSData dataWithContentsOfURL:location];
        id dic =[NSJSONSerialization  JSONObjectWithData:content options:0 error:nil];
        weakSelf.dataArray =[dic  objectForKey:@"pic"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf.tableView reloadData];
        });
        
    }];
    
    [task resume];
}





#pragma mark- 
#pragma 懒加载

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];

    }
    return _dataArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IndetifCell];
    }
    
    return _tableView;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return self.dataArray.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:IndetifCell forIndexPath:indexPath];
    
    NSDictionary *item =[self.dataArray objectAtIndex:indexPath.row];
    NSString *url =item[@"linkurl"];
    cell.textLabel.text=item[@"name"];
    
    __weak UITableViewCell *wcell =cell;
    
    [cell.imageView setImageWithUrl:[NSURL URLWithString:url] completion:^(BOOL flag) {
        [wcell setNeedsLayout];
    }];
    
    return cell;
    
}

#pragma mark -
#pragma 隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    
    return YES;
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
