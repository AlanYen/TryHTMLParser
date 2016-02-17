//
//  ViewController.m
//  TryHTMLParser
//
//  Created by AlanYen on 2016/2/16.
//  Copyright © 2016年 17Life. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startGetHTML];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startGetHTML {
    
    // NSURLSessionDataTask
    NSURL *url = [NSURL URLWithString:@"http://pda.5284.com.tw/MQS/businfo2.jsp?routeId=909"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask =
    [session dataTaskWithRequest:request
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSLog(@"Response:%@ %@\n", response, error);
        if (!error) {
            NSString *html = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"Response data = %@", html);
            [self parseHTML:data];
        }
    }];
    
    // resume
    [dataTask resume];
}

- (void)parseHTML:(NSData *)data {
    
    TFHpple *parser = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elements = [parser searchWithXPathQuery:@"//tr[@class='ttego1']"];
    for (TFHppleElement *element in elements) {
        NSArray *tds = [element childrenWithTagName:@"td"];
        if (tds.count == 2) {
            TFHppleElement *a = [[tds firstObject] firstChildWithTagName:@"a"];
            if (a) {
                NSLog(@"%@ (%@)", [a text], [[tds lastObject] text]);
            }
        }
    }
    
    elements = [parser searchWithXPathQuery:@"//tr[@class='ttego2']"];
    for (TFHppleElement *element in elements) {
        NSArray *tds = [element childrenWithTagName:@"td"];
        if (tds.count == 2) {
            TFHppleElement *a = [[tds firstObject] firstChildWithTagName:@"a"];
            if (a) {
                NSLog(@"%@ (%@)", [a text], [[tds lastObject] text]);
            }
        }
    }
    
    elements = [parser searchWithXPathQuery:@"//tr[@class='tteback1']"];
    for (TFHppleElement *element in elements) {
        NSArray *tds = [element childrenWithTagName:@"td"];
        if (tds.count == 2) {
            TFHppleElement *a = [[tds firstObject] firstChildWithTagName:@"a"];
            if (a) {
                NSLog(@"%@ (%@)", [a text], [[tds lastObject] text]);
            }
        }
    }
    
    elements = [parser searchWithXPathQuery:@"//tr[@class='tteback2']"];
    for (TFHppleElement *element in elements) {
        NSArray *tds = [element childrenWithTagName:@"td"];
        if (tds.count == 2) {
            TFHppleElement *a = [[tds firstObject] firstChildWithTagName:@"a"];
            if (a) {
                NSLog(@"%@ (%@)", [a text], [[tds lastObject] text]);
            }
        }
    }
}

@end
