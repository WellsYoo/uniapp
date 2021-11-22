//
//  GCDAsyncSocket+Read.h
//  iOSTCPClient
//
//  Created by suxinde on 2017/8/6.
//  Copyright © 2017年 com.meitu. All rights reserved.
//

#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface GCDAsyncSocket (Read)

- (void)readProtocolHeaderWithTimeOutForTag:(int)tag;

@end
