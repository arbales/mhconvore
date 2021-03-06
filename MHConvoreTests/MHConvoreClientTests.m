//
//  MHConvoreClientTests.m
//  MHConvore
//
//  Created by Mikael Hallendal on 2011-02-17.
//  Copyright 2011 Mikael Hallendal. All rights reserved.
//

#import "MHConvoreClientTests.h"
#import "MHConvoreClient.h"

#import "ASIHTTPRequest.h"

@interface MHConvoreClient (TestAPI)

- (NSString *)dispatchSelectorFromKind:(NSString *)kind;
- (void)setupHTTPRequest:(ASIHTTPRequest *)request;

@end

@implementation MHConvoreClientTests

- (void)setUp
{
    [super setUp];
    client = [[MHConvoreClient alloc] init];

    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [client release];

    [super tearDown];
}

- (void)testBaseURL
{
    STAssertEqualObjects([NSURL URLWithString:@"https://convore.com"], [MHConvoreClient baseURL], nil);
}

- (void)testHasLiveTimeout
{
    // Test default value
    STAssertEquals(client.liveTimeout, (NSInteger)60, nil);
    client.liveTimeout = 30;
    STAssertEquals(client.liveTimeout, (NSInteger)30, nil);
}

- (void)testHasLiveFrequency
{
    // Test default value
    STAssertEquals(client.liveFrequency, (NSInteger)0, nil);
    client.liveFrequency = 30;
    STAssertEquals(client.liveFrequency, (NSInteger)30, nil);
}

- (void)testDispatcherNameFromKind
{
    STAssertEqualObjects(@"dispatchMessage:", [client dispatchSelectorFromKind:@"message"], nil);
    STAssertEqualObjects(@"dispatchMessage:", [client dispatchSelectorFromKind:@"MeSsage"], nil);
    STAssertEqualObjects(@"dispatchNewTopic:", [client dispatchSelectorFromKind:@"new-topic"], nil);
}

- (void)testSetupHTTPRequest
{
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[MHConvoreClient baseURL]];
    
    client.username = @"username";
    client.password = @"password";
    
    [client setupHTTPRequest:request];
    
    STAssertEqualObjects(@"username", request.username, nil);
    STAssertEqualObjects(@"password", request.password, nil);
    STAssertEquals(client.liveTimeout, (NSInteger)request.timeOutSeconds, nil);
}

@end
