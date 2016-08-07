//
//  SubChildViewController.m
//  NO.1
//
//  Created by chanyezhenghe on 16/4/18.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "SubChildViewController.h"
#import "IndustryCell.h"


@interface SubChildViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * lzTableView;

@end

@implementation SubChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _lzTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LSelf_Width, LSelf_Height - 64 - 44) style:UITableViewStylePlain];
    
    _lzTableView.delegate = self;
    _lzTableView.dataSource = self;
    
    
    [self.view addSubview:_lzTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 164;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndustryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ACell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IndustryCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
