//
//  MessageHandler.m
//  SocketTest_walkieTalkie
//
//  Created by salahuddin yousuf on 4/27/16.
//  Copyright © 2016 salahuddin yousuf. All rights reserved.
//

#import "MessageHandler.h"
#import <UIKit/UIKit.h>
#import "Constants.h"

@implementation MessageHandler

+(MessageHandler*)sharedHandler{
    static MessageHandler *mySharedHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mySharedHandler = [[MessageHandler alloc] init];
        // Do any other initialisation stuff here
    });
    
    return mySharedHandler;
}

#pragma mark - Helpers


- (NSString *)getIPAddress {
    
#warning TODO: Remove this code
#if TARGET_OS_SIMULATOR
    
    //Simulator
    
    return @"192.168.1.106";
    
#else
    
    // Device
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
#endif
}


#pragma mark - TYPE_MESSAGE

-(NSString *)createChatMessageWithChannelID:(int) channelID deviceName:(NSString *)deviceNameForChannel chatmessage:(NSString *)message{
    
    
    NSDictionary * postDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:DEVICE_UUID_KEY_FORUSERDEFAULTS], deviceNameForChannel, [self getIPAddress ],[NSNumber numberWithInt:TYPE_MESSAGE], [NSNumber numberWithInt:channelID], message,nil]
                                                                forKeys:[NSArray arrayWithObjects:JSON_KEY_DEVICE_ID, JSON_KEY_DEVICE_NAME,JSON_KEY_IP_ADDRESS, JSON_KEY_TYPE, JSON_KEY_CHANNEL,  JSON_KEY_MESSAGE,nil]];
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:postDictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *resultAsString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return resultAsString;
    
}


#pragma mark - One to One Chat Message

-(NSString *)oneToOneChatRequestMessage{
    
    
    NSDictionary * postDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:DEVICE_UUID_KEY_FORUSERDEFAULTS], [UIDevice currentDevice].name, [self getIPAddress ],[NSNumber numberWithInt:TYPE_ONE_TO_ONE_CHAT_REQUEST], nil]
                                                                forKeys:[NSArray arrayWithObjects:JSON_KEY_DEVICE_ID, JSON_KEY_DEVICE_NAME,JSON_KEY_IP_ADDRESS, JSON_KEY_TYPE,  nil]];
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:postDictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *resultAsString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return resultAsString;
}




@end
