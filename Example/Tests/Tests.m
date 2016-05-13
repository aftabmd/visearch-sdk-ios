//
//  ViSearchTests.m
//  ViSearchTests
//
//  Created by Shaohuan Li on 01/08/2015.
//  Copyright (c) 2014 Shaohuan Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViSearchAPI.h"

@interface ViSearchTests : XCTestCase

@property ViSearchClient *client;

@end

@implementation ViSearchTests

- (void)setUp {
    [super setUp];
    //[ViSearchAPI setupAccessKey:@"" andSecretKey:@""];
    //self.client = [ViSearchAPI defaultClient];
    
    self.client = [[ViSearchClient alloc] initWithBaseUrl:@"https://visearch.visenze.com"
        accessKey:@"" secretKey:@""];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
}

- (void)testTrack {
    UploadSearchParams *uploadSearchParams = [[UploadSearchParams alloc] init];
    uploadSearchParams.fl = @[@"price",@"brand",@"im_url"];
    uploadSearchParams.score = YES;
    uploadSearchParams.imageFile = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/d/da/Internet2.jpg"]]];


    uploadSearchParams.box = [[Box alloc] initWithX1:0 y1:0 x2:0 y2:0];
    [uploadSearchParams.fq setObject:@"0.0, 199.0" forKey:@"price"];

    __block int flag = 1;
    [self.client searchWithImageData:uploadSearchParams success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        NSLog(@"image data search test success");
        NSLog(@"%@",data.content);
        
        TrackParams *params = [TrackParams createWithCID:@"dummyCid" ReqId:data.reqId andAction:@"click"];
        [self.client track:params completion:^(BOOL success) {
            BOOL k = success;
            flag = 0;
        }];
        
    } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        NSLog(@"image data search test fail");
        NSLog(@"%@",data.error.message);
        flag = 0;
    }];

    while (flag);
}

- (void)testColorSearch {
    ColorSearchParams *colorSearchParams = [[ColorSearchParams alloc] init];
    colorSearchParams.color = @"012ACF";
    colorSearchParams.fl = @[@"price",@"brand",@"im_url"];
    
    __block int flag = 1;
    
    [self.client searchWithColor:colorSearchParams success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        NSLog(@"color search test success");
        NSLog(@"%@",data.content);
        flag = 0;
    } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        NSLog(@"color search test fail");
        NSLog(@"%@",data.error.message);
        flag = 0;
    }];
    
    
    while (flag);
}

- (void)testImageIdTest {
    SearchParams *searchParams = [[SearchParams alloc] init];
    searchParams.imName = @"yoox-34301262";
    searchParams.fl = @[@"price",@"brand",@"im_url"];
    
    __block int flag = 1;
    [self.client searchWithImageId:searchParams success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        NSLog(@"product search test success");
        NSLog(@"%@",data.content);
        flag = 0;
    } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        NSLog(@"product search test fail");
        NSLog(@"%@",data);
        flag = 0;
    }];
    
    while (flag);
}

- (void)testImageUrlSearchTest {
    UploadSearchParams *uploadSearchParams = [[UploadSearchParams alloc] init];
    uploadSearchParams.imageUrl = @"https://upload.wikimedia.org/wikipedia/commons/d/da/Internet2.jpg";
    uploadSearchParams.settings = [[ImageSettings alloc] initWithSize:CGSizeMake(800, 800) Quality:1.0];
    
    __block int flag = 1;
    [self.client searchWithImageUrl:uploadSearchParams success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        NSLog(@"image url search test success");
        NSLog(@"%@",data.content);
        flag = 0;
    } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        NSLog(@"image url search test fail");
        NSLog(@"%@",data);
        flag = 0;
    }];
    
    while (flag);
}

- (void)testImageDataSearchTest {
    UploadSearchParams *uploadSearchParams = [[UploadSearchParams alloc] init];
    uploadSearchParams.fl = @[@"price",@"brand",@"im_url"];
    uploadSearchParams.score = YES;
    uploadSearchParams.imageFile = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/d/da/Internet2.jpg"]]];

    
    uploadSearchParams.box = [[Box alloc] initWithX1:0 y1:0 x2:0 y2:0];
    [uploadSearchParams.fq setObject:@"0.0, 199.0" forKey:@"price"];

    __block int flag = 1;
    [self.client searchWithImageData:uploadSearchParams success:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        NSLog(@"image data search test success");
        NSLog(@"%@",data.content);
        flag = 0;
    } failure:^(NSInteger statusCode, ViSearchResult *data, NSError *error) {
        NSLog(@"image data search test fail");
        NSLog(@"%@",data);
        flag = 0;
    }];
    
    while (flag);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

