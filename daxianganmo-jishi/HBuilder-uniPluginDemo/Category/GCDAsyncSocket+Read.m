//
//  GCDAsyncSocket+Read.m
//  iOSTCPClient
//
//  Created by suxinde on 2017/8/6.
//  Copyright © 2017年 com.meitu. All rights reserved.
//

#import "GCDAsyncSocket+Read.h"
#import "MTTransferDataProtocol.h"

@implementation GCDAsyncSocket (Read)

- (void)readProtocolHeaderWithTimeOutForTag:(int)tag {
    [self readDataToLength:kMTP2PDataProtocolHeaderLength withTimeout:-1 tag:tag];
}

@end
