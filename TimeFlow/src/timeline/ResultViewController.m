//
//  ResultViewController.m
//  TimeFlow
//
//  Created by lorabit on 5/12/16.
//
//

#import "ResultViewController.h"
#import <AFNetworking.h>
#import "Masonry.h"

@implementation ResultViewController{
    UITableView* resultView;
    NSArray* resultArray;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"Search: %@",self.keyword];
    resultArray = [NSArray new];
    
    
    resultView = [[UITableView alloc] init];
    resultView.delegate = self;
    resultView.dataSource = self;
    [self.view addSubview:resultView];
    
    [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPAdditionalHeaders = @{
                                                   @"Content-Type"  : @"text/html"
                                                   };
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://image.baidu.com/search/acjson?tn=resultjson_com&ipn=rj&ct=201326592&is=&fp=result&queryWord=%@&cl=2&lm=-1&ie=utf-8&oe=utf-8&adpicid=&st=&z=&ic=&word=%@&s=&se=&tab=&width=&height=&face=&istype=&qc=&nc=1&fr=&pn=120&rn=30&gsm=5a&1463068060105=",[self.keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet new]],[self.keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet new]]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
//            NSLog(@"Error: %@", error);
        } else {
//            NSLog(@"%@ %@", response, responseObject);
            NSDictionary* dic = responseObject;
            resultArray = dic[@"data"];
            [resultView reloadData];
        }
    }];
    
    [dataTask resume];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return resultArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[ImageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    NSDictionary* dict = resultArray[indexPath.row];
    cell.data = dict;
    
    return cell;
}

-(void)clickBtn{

}



@end
