#import "UseHelpViewController.h"
#import "UseHelpTableViewCell.h"
#import "ZidonAFNetWork.h"
#import "MyItem.h"
#import "UseHelpDetailViewController.h"

@interface UseHelpViewController ()<UITableViewDataSource,UITableViewDelegate,zidonDelegate>
{
    NSMutableArray *_dataArray;
}
@end


@implementation UseHelpViewController

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
    //self.navigationController.navigationBarHidden=NO;
    _dataArray = [[NSMutableArray alloc]init];
    ZidonAFNetWork *zidonUseHelpUrl = [ZidonAFNetWork sharedInstace];
    [zidonUseHelpUrl requestWithUrl:kUseHelpUrl withDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//下载数据
-(void)requestFinished:(NSArray *)parmeters
{
    for (NSDictionary *dic in parmeters) {
        MyItem *model = [[MyItem alloc]init];
        model.AddDate = dic[@"AddDate"];
        model.AnsContent = dic[@"AnsContent"];
        model.Title = dic[@"Title"];
        [_dataArray addObject:model];
    }
    [_helpTableView reloadData];
}
-(void)requestFailed:(NSError *)error
{
    
}
//设置组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
//每组一行数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"";
    UseHelpTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"UseHelpTableViewCell" owner:self options:nil] lastObject];
    }
    MyItem *model = _dataArray[indexPath.section];
    cell.questionLabel.text = [NSString stringWithFormat:@"%d.%@",indexPath.section+1,model.Title];
    cell.detailLabel.text = model.AnsContent;
    return cell;
}
//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"点击了第%d组,第%d行",indexPath.section,indexPath.row);
    UseHelpDetailViewController *udvc = [[UseHelpDetailViewController alloc]init];
    MyItem *model = _dataArray[indexPath.section];
    udvc.useHelpDetail = model.AnsContent;
    udvc.addTime = model.AddDate;
    udvc.questionTitle = model.Title;
    [APP_DELEGATE.rootNav pushViewController:udvc animated:YES];
}
- (IBAction)returnBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
