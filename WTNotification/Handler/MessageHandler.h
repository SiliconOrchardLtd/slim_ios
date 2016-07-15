//
//  MessageHandler.h
//  SocketTest_walkieTalkie
//
//  Created by salahuddin yousuf on 4/27/16.
//  Copyright © 2016 salahuddin yousuf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ifaddrs.h>
#import <arpa/inet.h>


@interface MessageHandler : NSObject

@property (nonatomic, strong) NSString *deviceIPAddress;
@property (nonatomic, strong) NSString *deviceName;
@property (nonatomic, strong) NSString *deviceID;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) int messageTYPE;
@property (nonatomic, assign) uint16_t port;
@property (nonatomic, strong) NSString *clientIP;
@property (nonatomic, assign) uint16_t clientPort;
@property (nonatomic, assign) int channelID;

+(MessageHandler*)sharedHandler;



-(NSString *)getUUID;
-(NSString *)getIPAddress;


-(NSString *)requestInfoAtStartMessage;
-(NSString *)acknowledgeDeviceInNetwork;
-(NSString *)leftApplicationMessage;

-(NSArray *)jsonStringArrayWithFile:(NSString *)fileName OfType:(int)type;

@end
