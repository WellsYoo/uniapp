//
//  MTP2PDataProtocol.m
//  MTLANFileTransferSDK_Dev
//
//  Created by suxinde on 2016/10/20.
//  Copyright © 2016年 com.meitu. All rights reserved.
//

#import "MTTransferDataProtocol.h"

#pragma mark - MTP2PDataProtocol Consts

/**
 *  协议头默认5个字节
 */
const NSInteger kMTP2PDataProtocolHeaderLength = 5;

/**
 *  不带尾部CRC32校验值的数据切片长度， 默认(512KB)
 */
const NSInteger kMTP2PDataProtocolDataChunkLength = (524288); // (512 * 1024)

/**
 *  数据切片尾部CRC32校验数据长度默认(4个字节)
 */
const NSInteger kMTP2PDataProtocolDataChunkCrc32TailLength = (4);

/**
 *  数据切片尾部MD5校验数据长度默认(16Byte)
 */
const NSInteger kMTSocketProtocolDataSliceTailLength = (16); // (16)


#pragma mark - Protocol Header Identifier Consts

/**
 *  消息型标识符
 */
const Byte kMTP2PDataProtocolHeaderMsgIdentider = 'm';

/**
 *  数据型标识符
 */
const Byte kMTP2PDataProtocolHeaderDataIdentider = 'd';

/**
 *  主动断开连接标识符
 */
const Byte kMTP2PDataProtocolHeaderCloseConnectionIdentifier = 'c';
