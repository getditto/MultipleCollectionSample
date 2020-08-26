//
//  DittoKit+Private.h
//  DittoKit
//
//  Created by Hamilton Chapman on 31/01/2020.
//  Copyright © 2020 Ditto. All rights reserved.
//

@class DittoHandleWrapper;
@class PresenceManager;

@class TransportHandleWrapper;
@class AwdlClientPlatform;
@class AwdlServerPlatform;
@class BluetoothPlatform;
@class MdnsPlatform;
@class DITStatus;

NS_ASSUME_NONNULL_BEGIN

@interface DITDittoKit ()
@property (nonatomic, readonly) DittoHandleWrapper *dittoHandleWrapper;
@property (nonatomic, readwrite) BOOL activated;
@property (nonatomic, readonly) DITStore *privateStore;
@property (nonatomic, readonly) PresenceManager *presence;
@property (nonatomic) BOOL transportConditionCallbackRegistered;

@property (nonatomic, nullable) MdnsPlatform *mdnsPlatform;
@property (nonatomic, nullable) BluetoothPlatform *bluetoothPlatform;
@property (nonatomic, nullable) AwdlClientPlatform *awdlClientPlatform;
@property (nonatomic, nullable) AwdlServerPlatform *awdlServerPlatform;
@property (nonatomic, nullable)
    NSMutableDictionary<NSString *, TransportHandleWrapper *> *staticTcpClients;

@property (nonatomic) DITStatus *status;
@property (nonatomic) int64_t mDNSTransportID;
@property (nonatomic) int64_t bleClientTransportID;
@property (nonatomic) int64_t bleServerTransportID;
@property (nonatomic) int64_t awdlClientTransportID;
@property (nonatomic) int64_t awdlServerTransportID;

+ (NSURL *)defaultDittoDirectory:(NSFileManager *)fileManager;
@end

NS_ASSUME_NONNULL_END
