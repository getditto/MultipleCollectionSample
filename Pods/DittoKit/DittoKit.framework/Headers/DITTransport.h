//
//  DittoTransport.h
//  DittoKit
//
//  Created by Hamilton Chapman on 22/01/2020.
//  Copyright © 2020 Ditto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DITTransportBluetooth;
@class DITTransportWiFi;
@class DITTransportAWDL;
@class DITTransportServer;

/**
 The types of transport that can be used by DittoKit to communicate with other devices.
*/
typedef NS_ENUM(NSUInteger, DITTransportType) {
    DITTransportTypeBluetooth = 1 << 0,
    DITTransportTypeWiFi = 1 << 1,
    DITTransportTypeAWDL = 1 << 2,
    DITTransportTypeServer = 1 << 3,
};

NS_ASSUME_NONNULL_BEGIN

/**
 An abstract class that is used to represent any of the transports that Ditto can use.
 */
@interface DITTransport : NSObject

/**
 The type of the transport.
 */
@property (nonatomic, readonly) DITTransportType type;

/**
 Creates an instance of the Bluetooth transport identifier.

 @return An instance of the Bluetooth transport identifier.
 */
+ (DITTransportBluetooth *)Bluetooth;

/**
 Creates an instance of the WiFi transport identifier.

 @return An instance of the WiFi transport identifier.
*/
+ (DITTransportBluetooth *)WiFi;

/**
 Creates an instance of the AWDL transport identifier.

 @return An instance of the AWDL transport identifier.
*/
+ (DITTransportBluetooth *)AWDL;

/**
 Creates an instance of the Server transport identifier, with the provided server address.

 @param serverAddress The address of the server to connect to.

 @return An instance of the Server transport identifier.
*/
+ (DITTransportBluetooth *)ServerWithAddress:(NSString *)serverAddress;

@end

/**
 Used in `start` and `stop` calls on the `DITDittoKit` object to start or stop using Bluetooth as a
 transport.
 */
@interface DITTransportBluetooth : DITTransport
@end

/**
 Used in `start` and `stop` calls on the `DITDittoKit` object to start or stop using WiFi as a
 transport.
*/
@interface DITTransportWiFi : DITTransport
@end

/**
 Used in `start` and `stop` calls on the `DITDittoKit` object to start or stop using AWDL as a
 transport.
*/
@interface DITTransportAWDL : DITTransport
@end

/**
 Used in `start` and `stop` calls on the `DITDittoKit` object to start or stop using a server as a
 transport.
*/
@interface DITTransportServer : DITTransport

/**
 The address of the server to connect to.
*/
@property (nonatomic, readonly) NSString *serverAddress;

@end

NS_ASSUME_NONNULL_END
