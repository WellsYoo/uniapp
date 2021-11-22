//
//  MTP2PDataProtocol.h
//  MTLANFileTransferSDK_Dev
//
//  Created by suxinde on 2016/10/20.
//  Copyright © 2016年 com.meitu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  通信数据包结构如下：
 
    +--------------------------------------------+
    | 协议头部（5个字节） |          数据域          |
    +--------------------------------------------+
 
    协议头部的格式为如下：
    +-------------------------------------------------------------------------------+
    | identifier (协议头部标识符，1个Byte) | packetDataFieldLength （数据域长度，4个Byte）|
    +-------------------------------------------------------------------------------+
    协议头部由 1个Byte长度的 `标识符` 和 4个Byte长度的`数据域长度值` 构成。
 
 
    通信数据包通过协议头的 协议头部标识符 区分为两种格式： 消息类数据包 和 分片数据包，两种格式的 数据域 格式不同。
 
    1. 消息类数据包的 数据域 格式如下
 
    +-----------------------------------+
    |            消息JSON封装            |
    +-----------------------------------+
 
    2. 分片数据包的 数据域 格式如戏
    
    +-------------------------------------------------------------------------------+
    |                 分片数据            |      分片数据的CRC32校验信息（4个Byte）      |
    +-------------------------------------------------------------------------------+
 
 */


#pragma mark - MTTransferDataProtocol Consts

/**
 *  协议头默认5个字节
 */
extern const NSInteger kMTP2PDataProtocolHeaderLength;

/**
 *  不带尾部CRC32校验值的数据切片长度， 默认(512KB)
 */
extern const NSInteger kMTP2PDataProtocolDataChunkLength;

/**
 *  数据切片尾部CRC32校验数据长度默认(4个字节)
 */
extern const NSInteger kMTP2PDataProtocolDataChunkCrc32TailLength;

extern const NSInteger kMTSocketProtocolDataSliceTailLength;

#pragma mark - Protocol Header Identifier Consts

/**
 *  消息型标识符
 */
extern const Byte kMTP2PDataProtocolHeaderMsgIdentider;

/**
 *  数据型标识符
 */
extern const Byte kMTP2PDataProtocolHeaderDataIdentider;

/**
 *  主动断开连接标识符
 */
extern const Byte kMTP2PDataProtocolHeaderCloseConnectionIdentifier;
