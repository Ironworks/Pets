//
//  NetworkManager.m
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"
#import "OHHTTPStubs.h"
#import "OHPathHelpers.h"

NSString * const kURL = @"https://petsAPI.com/allPets";

@implementation NetworkManager

- (instancetype)init {
    
    if (self = [super init]) {
        //Don't hava a back end so load data from file
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return [request.URL.host isEqualToString:@"petsAPI.com"];
        } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
            // Stub it with our "applications.json" stub file
            return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"pets.json",self.class)
                                                    statusCode:200 headers:@{@"Content-Type":@"application/json"}];
        }];

    }
    
    return self;
}



- (void)retrieveApplicationsSuccess:(success)success failure:(failure)failure {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:kURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failure) {
                    failure(error.localizedDescription, httpResp.statusCode);
                }
            });
            
        } else {
            
            
            
            NSDictionary *feed = responseObject[@"feed"];
            NSArray *entries  = feed[@"pets"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success(entries);
                }
            });
            
        }
    }];
    [dataTask resume];}

@end

