//
//  UserTests.m
//  Blocstagram
//
//  Created by Ryan Rizzo on 7/27/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"
#import "Media.h"

@interface UserTests : XCTestCase

@end

@implementation UserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatInitializationWorks
{
    NSDictionary *sourceDictionary = @{@"id": @"8675309",
                                       @"username" : @"d'oh",
                                       @"full_name" : @"Homer Simpson",
                                       @"profile_picture" : @"http://www.example.com/example.jpg"};
    User *testUser = [[User alloc] initWithDictionary:sourceDictionary];
    
    XCTAssertEqualObjects(testUser.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
    XCTAssertEqualObjects(testUser.userName, sourceDictionary[@"username"], @"The username should be equal");
    XCTAssertEqualObjects(testUser.fullName, sourceDictionary[@"full_name"], @"The full name should be equal");
    XCTAssertEqualObjects(testUser.profilePictureURL, [NSURL URLWithString:sourceDictionary[@"profile_picture"]], @"The profile picture should be equal");
}

- (void)testThatMediaInitializationWorks
{
    NSDictionary *sourceDictionary = @{@"id": @"8675309",
                                       @"user" : @"http://www.example.com/example.jpg",
                                       @"image": {
                                           @"standard_resolution" : {
                                               @"url" : @"2.jpg"
                                           }
                                       }: [UIImage imageNamed:@"2.jpg"],
                                       @"caption" : @"blah",
                                       @"comments" : @[@"great photo", @"awesome!"]};
    Media *testMedia = [[Media alloc] initWithDictionary:sourceDictionary];
    
    XCTAssertEqualObjects(testMedia.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
    XCTAssertEqualObjects(testMedia.mediaURL, [NSURL URLWithString:sourceDictionary[@"mediaURL"]], @"The mediaURL should be equal");
    XCTAssertEqualObjects(testMedia.image, sourceDictionary[@"image"], @"The image should be equal");
    XCTAssertEqualObjects(testMedia.caption, sourceDictionary[@"caption"], @"The caption should be equal");
    XCTAssertEqualObjects(testMedia.comments, sourceDictionary[@"comments"], @"The comments should be equal");
}

- (void) testThatHeightForMediaItemWorks
{
    NSDictionary *sourceDictionary = @{@"idNumber": @"8675309",
                                       @"mediaURL" : @"http://www.example.com/example.jpg",
                                       @"image" : [UIImage imageNamed:@"2.jpg"],
                                       @"caption" : @"blah",
                                       @"comments" : @[@"great photo", @"awesome!"]};
    Media *testMedia = [[Media alloc] initWithDictionary:sourceDictionary];
    
    CGFloat testResult = [MediaTableViewCell heightForMediaItem:testMedia width:ImagesTableViewController.view.frame traitCollection:ImagesTableViewController.traitCollection.horizontalSizeClass];
    
}


@end
