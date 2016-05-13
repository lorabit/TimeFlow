//
//  ImageCell.m
//  TimeFlow
//
//  Created by lorabit on 5/13/16.
//
//

#import "ImageCell.h"

@implementation ImageCell{
    UIImageView* imageView;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    imageView = [UIImageView new];
    [self.contentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@50);
        make.top.left.equalTo(self.contentView);
    }];
    
    
    return self;
}

-(void)setData:(NSDictionary *)data{
    _data = data;
    NSString* urlStr = data[@"thumbURL"];
    NSURL * url = [NSURL URLWithString:urlStr];
   
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url]; // 创建请求对象
    request.timeoutInterval = 5;  // 设置请求超时；
    request.HTTPMethod = @"GET";  // 设置POST请求；
    // equest.HTTPMethod = @"HEAD";  // 获取http请求头信息(发送同步或者异步请求都行，但最好是异步请求)；
    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.94 Safari/537.36" forHTTPHeaderField:@"User-Agent"];  // 设置请求头；
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data){
            UIImage* image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                imageView.image = image;
            });
        }
    }];
    [task resume];
    
    imageView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        imageView.alpha = 1;
    }];
}

@end
