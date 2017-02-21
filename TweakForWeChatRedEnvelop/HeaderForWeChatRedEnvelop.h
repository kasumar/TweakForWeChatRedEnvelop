//
//  HeaderForWeChatRedEnvelop.h
//  TweakForWeChatRedEnvelop
//
//  Created by KAGE on 16-1-19.
//
//

#ifndef TweakForWeChatRedEnvelop_HeaderForWeChatRedEnvelop_h
#define TweakForWeChatRedEnvelop_HeaderForWeChatRedEnvelop_h


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@class MMServiceCenter;
@interface MMServiceCenter : NSObject
+ (id)defaultCenter;
- (id)getService:(Class)arg1;
@end


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@class WCRedEnvelopesLogicMgr;
@interface WCRedEnvelopesLogicMgr : NSObject
- (void)OpenRedEnvelopesRequest:(id)arg1;
- (void)ReceiverQueryRedEnvelopesRequest:(id)arg1;
@end


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@class CMessageWrap;
@interface CMessageWrap : NSObject

@property(nonatomic) unsigned long m_uiEmojiStatFlag; // @synthesize m_uiEmojiStatFlag;
@property(nonatomic) unsigned long m_uiSendTime; // @synthesize m_uiSendTime;
@property(retain, nonatomic) NSString *m_nsRealChatUsr; // @synthesize m_nsRealChatUsr;
@property(retain, nonatomic) NSString *m_nsMsgSource; // @synthesize m_nsMsgSource;
@property(retain, nonatomic) NSString *m_nsPushContent; // @synthesize m_nsPushContent;
@property(nonatomic) unsigned long m_uiCreateTime; // @synthesize m_uiCreateTime;
@property(nonatomic) unsigned long m_uiImgStatus; // @synthesize m_uiImgStatus;
@property(nonatomic) unsigned long m_uiStatus; // @synthesize m_uiStatus;
@property(retain, nonatomic) NSString *m_nsContent; // @synthesize m_nsContent;
@property(nonatomic) unsigned long m_uiMessageType; // @synthesize m_uiMessageType;
@property(retain, nonatomic) NSString *m_nsToUsr; // @synthesize m_nsToUsr;
@property(retain, nonatomic) NSString *m_nsFromUsr; // @synthesize m_nsFromUsr;
@property(nonatomic) long long m_n64MesSvrID; // @synthesize m_n64MesSvrID;
@property(nonatomic) unsigned long m_uiMesLocalID; // @synthesize m_uiMesLocalID;

- (BOOL)isSentOK;
- (BOOL)IsAtMe;
- (id)keyDescription;
- (BOOL)IsNeedChatExt;
- (id)GetDisplayContent;
- (id)GetMsgClientMsgID;
- (BOOL)IsSameMsgWithFullCheck:(id)arg1;
- (BOOL)IsSameMsg:(id)arg1;
- (BOOL)IsSendBySendMsg;
- (BOOL)IsAppMessage;
- (BOOL)IsShortMovieMsg;
- (BOOL)IsVideoMsg;
- (BOOL)IsImgMsg;
- (BOOL)IsChatRoomMessage;
- (BOOL)IsMassSendMessage;
- (BOOL)IsBottleMessage;
- (BOOL)IsQQMessage;
- (BOOL)IsSxMessage;
- (id)GetChatName;
@end


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MMService : NSObject
@end

@interface CContactMgr : MMService
- (id)getSelfContact;

- (id)getContactByName:(id)arg1;
- (id)getContactByNameNotMySelf:(id)arg1; //deprecated
@end


@interface CBaseContact : NSObject
@property(retain, nonatomic) NSString *m_nsHeadImgUrl; // @synthesize m_nsHeadImgUrl;
@property(retain, nonatomic) NSString *m_nsUsrName; // @synthesize m_nsUsrName;
@property(retain, nonatomic) NSString *m_nsNickName; // @synthesize m_nsNickName;

- (id)getContactDisplayUsrName;
- (id)getContactDisplayName;
@end

@interface CContact : CBaseContact
+ (id)genChatRoomName:(id)arg1;
@end




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface PBGeneratedMessage : NSObject
- (id)baseResponse;
- (BOOL)isInitialized;
@end


@interface SKBuiltinBuffer_t : PBGeneratedMessage
{
}

//+ (CDStruct_eed1d6a8 *)fieldInfoArray;
+ (id)skBufferWithData:(id)arg1;

// Remaining properties
@property(retain, nonatomic) NSData *buffer; // @dynamic buffer;
@property(nonatomic) unsigned int iLen; // @dynamic iLen;
@end


@interface HongBaoRes : PBGeneratedMessage
{
}

//+ (CDStruct_eed1d6a8 *)fieldInfoArray;

// Remaining properties
//@property(retain, nonatomic) BaseResponse *baseResponse; // @dynamic baseResponse;
@property(nonatomic) int cgiCmdid; // @dynamic cgiCmdid;
@property(retain, nonatomic) NSString *errorMsg; // @dynamic errorMsg;
@property(nonatomic) int errorType; // @dynamic errorType;
@property(retain, nonatomic) NSString *platMsg; // @dynamic platMsg;
@property(nonatomic) int platRet; // @dynamic platRet;
@property(retain, nonatomic) SKBuiltinBuffer_t *retText; // @dynamic retText;
@end

@interface HongBaoReq : PBGeneratedMessage
{
}

//+ (CDStruct_eed1d6a8 *)fieldInfoArray;

// Remaining properties
//@property(retain, nonatomic) BaseRequest *baseRequest; // @dynamic baseRequest;
@property(nonatomic) unsigned int cgiCmd; // @dynamic cgiCmd;
@property(nonatomic) unsigned int outPutType; // @dynamic outPutType;
@property(retain, nonatomic) SKBuiltinBuffer_t *reqText; // @dynamic reqText;
@end



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@class WCPayInfoItem;
@interface WCPayInfoItem : NSObject
@property(retain, nonatomic) NSString *m_c2cNativeUrl; // @synthesize m_c2cNativeUrl;
@end



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@class WCRedEnvelopesControlData;
@interface WCRedEnvelopesControlData : NSObject
{
	CMessageWrap *m_oSelectedMessageWrap;
	NSDictionary *m_structDicRedEnvelopesBaseInfo;
}
@property(retain, nonatomic) CMessageWrap *m_oSelectedMessageWrap; // @synthesize m_oSelectedMessageWrap;
@property(retain, nonatomic) NSDictionary *m_structDicRedEnvelopesBaseInfo; // @synthesize m_structDicRedEnvelopesBaseInfo;
@end

//@class WCRedEnvelopesControlLogic;
@interface WCRedEnvelopesControlLogic : NSObject
{
    WCRedEnvelopesControlData *m_data;
}
@end

//@class WCRedEnvelopesReceiveControlLogic;
@interface WCRedEnvelopesReceiveControlLogic : WCRedEnvelopesControlLogic
- (void)WCRedEnvelopesReceiveHomeViewOpenRedEnvelopes;
@end

#endif
