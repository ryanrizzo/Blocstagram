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
#import "MediaTableViewCell.h"
#import "ImagesTableViewController.h"
#import "ComposeCommentView.h"

@interface UserTests : XCTestCase

@end

@implementation UserTests
User *testUser;
NSDictionary *userSourceDictionary;
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    userSourceDictionary = @{@"id": @"8675309",
                                       @"username" : @"d'oh",
                                       @"full_name" : @"Homer Simpson",
                                       @"profile_picture" : @"http://www.example.com/example.jpg"};
    testUser = [[User alloc] initWithDictionary:userSourceDictionary];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatInitializationWorks
{

    XCTAssertEqualObjects(testUser.idNumber, userSourceDictionary[@"id"], @"The ID number should be equal");
    XCTAssertEqualObjects(testUser.userName, userSourceDictionary[@"username"], @"The username should be equal");
    XCTAssertEqualObjects(testUser.fullName, userSourceDictionary[@"full_name"], @"The full name should be equal");
    XCTAssertEqualObjects(testUser.profilePictureURL, [NSURL URLWithString:userSourceDictionary[@"profile_picture"]], @"The profile picture should be equal");
}

- (void)testThatMediaInitializationWorks
{
    NSDictionary *secondSourceDictionary = @{@"id": @"8675309",
                                       @"user": userSourceDictionary,
                                       @"images" : @{
                                               @"standard resolution": @{
                                                       @"url": @"http://www.example.com/example.jpg"
                                                       }
                                               },
                                             @"caption" : @{ @"text" : @"blah"
                                                             },
                                             @"comments" : @{ @"comments": @{ @"data": @[@"great photo", @"awesome!"]}}};
    Media *testMedia = [[Media alloc] initWithDictionary:secondSourceDictionary];
    
    
    XCTAssertEqualObjects(testMedia.idNumber, secondSourceDictionary[@"id"], @"The ID number should be equal");
    
    XCTAssertEqualObjects(testMedia.user.fullName, secondSourceDictionary[@"user"][@"full_name"], @"The ID number should be equal");
    
    XCTAssertEqualObjects(testMedia.image, secondSourceDictionary[@"image"][@"standard_url"][@"url"], @"The image should be equal");
    XCTAssertEqualObjects(testMedia.caption, secondSourceDictionary[@"caption"][@"text"], @"The caption should be equal");
 //   XCTAssertEqualObjects(testMedia.comments, secondSourceDictionary[@"comments"], @"The comments should be equal");
}

- (void) testThatHeightForMediaItemWorks
{
    NSDictionary *heightSourceDictionary = @{@"id": @"8675309",
                                       @"user": userSourceDictionary,
                                       @"images" : @{
                                               @"standard resolution": @{
                                                       @"url": @"http://mybwdoc.com/wp-content/uploads/2011/11/thoracic-outlet-syndrome.jpg"
                                                       }
                                               },
                                       @"caption" : @"blah",
                                       @"comments" : @{ @"comments": @{ @"data": @[@"great photo", @"awesome!"]}}};
    Media *testMedia = [[Media alloc] initWithDictionary:heightSourceDictionary];
    ImagesTableViewController *tableViewController = [[ImagesTableViewController alloc] init];
    
    CGFloat testResult = [MediaTableViewCell heightForMediaItem:testMedia width:tableViewController.view.frame.size.width traitCollection:tableViewController.traitCollection];
    XCTAssertEqual(testResult, 488);


    NSDictionary *heightSourceDictionary2 = @{@"id": @"8675309",
                                             @"user": userSourceDictionary,
                                             @"images" : @{
                                                     @"standard resolution": @{
                                                             @"url": @"http://www.personal.psu.edu/jul229/mini.jpg"
                                                             }
                                                     },
                                             @"caption" : @"blah",
                                             @"comments" : @{ @"comments": @{ @"data": @[@"great photo this is awesome blah blah blah blah blah blah blah kjadsbck;abndlcbasdkjbcalkjsdbclakjsdbcjklasbdjklcabsdkjbcaskljdbcklajsdbcklajsdbcjkadsbckljabsdkjcbadsjkcbaskjldbcadls", @"awesome!"]}}};
    Media *testMedia2 = [[Media alloc] initWithDictionary:heightSourceDictionary2];
    ImagesTableViewController *tableViewController2 = [[ImagesTableViewController alloc] init];
    
    CGFloat testResult2 = [MediaTableViewCell heightForMediaItem:testMedia2 width:tableViewController2.view.frame.size.width traitCollection:tableViewController2.traitCollection];
    XCTAssertEqual(testResult2, 488);
}

- (void) testThatSetTextWorks
{
    ComposeCommentView *commentView = [[ComposeCommentView alloc] init];
    NSString *text = @"word";
    NSString *noText = @"";
    
    [commentView setText:text];
    
    XCTAssertTrue(commentView.isWritingComment);
    
    [commentView setText:noText];
    
    XCTAssertFalse(commentView.isWritingComment);
}

@end
