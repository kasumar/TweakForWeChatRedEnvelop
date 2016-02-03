
// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos
/*
#error iOSOpenDev post-project creation from template requirements (remove these lines after completed) -- \
	Link to libsubstrate.dylib: \
	(1) go to TARGETS > Build Phases > Link Binary With Libraries and add /opt/iOSOpenDev/lib/libsubstrate.dylib \
	(2) remove these lines from *.xm files (not *.mm files as they're automatically generated from *.xm files)

%hook ClassName

+ (id)sharedInstance
{
	%log;

	return %orig;
}

- (void)messageWithNoReturnAndOneArgument:(id)originalArgument
{
	%log;

	%orig(originalArgument);
	
	// or, for exmaple, you could use a custom value instead of the original argument: %orig(customValue);
}

- (id)messageWithReturnAndNoArguments
{
	%log;

	id originalReturnOfMessage = %orig;
	
	// for example, you could modify the original return value before returning it: [SomeOtherClass doSomethingToThisObject:originalReturnOfMessage];

	return originalReturnOfMessage;
}

%end
*/



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#import "HeaderForWeChatRedEnvelop.h"


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define STR_FILE_CONFIG @"/var/mobile/Media/iTunes_Control/iTunes/ConfigForWeChatRedEnvelop.plist"
#define STR_KEY_SWITCH_MAIN  @"MainSwitch"      //总开关
#define STR_KEY_SWITCH_CHAT  @"ChatSwitch"      //自己发出的群红包
#define STR_KEY_DELAY_SEC    @"DelaySeconds"    //延时时长

static id readConfig(NSString* strKey)
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithContentsOfFile:STR_FILE_CONFIG];

    return [dict objectForKey:strKey];
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
MMServiceCenter* g_MMServiceCenter = nil;
WCRedEnvelopesLogicMgr* g_WCRedEnvelopesLogicMgr = nil;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%hook CSyncBaseEvent
- (void)NotifyFromPrtl:(unsigned long)arg1 MessageInfo:(id)arg2
{
    //NSLog(@"[### CSyncBaseEvent-NotifyFromPrtl ###] arg1=%lu, arg2=%@", arg1, arg2);

#if 0
    id idValue = readConfig(STR_KEY_SWITCH_MAIN);
    NSLog(@"[### %@=%d[class=%@]", STR_KEY_SWITCH_MAIN, [idValue boolValue], [idValue class]);
    idValue = readConfig(STR_KEY_DELAY_SEC);
    NSLog(@"[### %@=%.2f[class=%@]", STR_KEY_DELAY_SEC, [idValue floatValue], [idValue class]);
#endif

    //判断是否为红包消息
    if ([readConfig(STR_KEY_SWITCH_MAIN) boolValue] && 45 == arg1)
    {
        //判断类型是否为NSDictionary
        if (YES == [arg2 isKindOfClass:[NSDictionary class]])
        {
            id idTemp = [arg2 objectForKey:@"18"];
            if ([NSStringFromClass([idTemp class]) isEqualToString:@"CMessageWrap"])
            {
                CMessageWrap* msgWrap = idTemp;

#if 0
                NSLog(@"111111111111111111111111111111111111111111111111");
                NSLog(@"m_uiEmojiStatFlag:%lu", [msgWrap m_uiEmojiStatFlag]);
                NSLog(@"m_uiSendTime:%lu", [msgWrap m_uiSendTime]);

                NSLog(@"m_nsRealChatUsr:%@", [msgWrap m_nsRealChatUsr]);
                NSLog(@"m_nsMsgSource:%@", [msgWrap m_nsMsgSource]);
                NSLog(@"m_nsPushContent:%@", [msgWrap m_nsPushContent]);
                NSLog(@"m_uiCreateTime:%lu", [msgWrap m_uiCreateTime]);
                NSLog(@"m_uiImgStatus:%lu", [msgWrap m_uiImgStatus]);
                NSLog(@"m_uiStatus:%lu", [msgWrap m_uiStatus]);
                NSLog(@"m_nsContent:%@", [msgWrap m_nsContent]);
                NSLog(@"m_uiMessageType:%lu", [msgWrap m_uiMessageType]);
                NSLog(@"m_nsToUsr:%@", [msgWrap m_nsToUsr]);
                NSLog(@"m_nsFromUsr:%@", [msgWrap m_nsFromUsr]);
                NSLog(@"m_n64MesSvrID:%lld", [msgWrap m_n64MesSvrID]);
                NSLog(@"m_uiMesLocalID:%lu", [msgWrap m_uiMesLocalID]);
                NSLog(@"222222222222222222222222222222222222222222222222");
                NSLog(@"isSentOK:%d", [msgWrap isSentOK]);
                NSLog(@"IsAtMe:%d", [msgWrap IsAtMe]);
                NSLog(@"keyDescription:%@", [msgWrap keyDescription]);
                NSLog(@"IsNeedChatExt:%d", [msgWrap IsNeedChatExt]);
                NSLog(@"GetDisplayContent:%@", [msgWrap GetDisplayContent]);
                NSLog(@"GetMsgClientMsgID:%@", [msgWrap GetMsgClientMsgID]);
                //- (BOOL)IsSameMsgWithFullCheck:(id)arg1;
                //- (BOOL)IsSameMsg:(id)arg1;
                NSLog(@"IsSendBySendMsg:%d", [msgWrap IsSendBySendMsg]);
                NSLog(@"IsAppMessage:%d", [msgWrap IsAppMessage]);
                NSLog(@"IsShortMovieMsg:%d", [msgWrap IsShortMovieMsg]);
                NSLog(@"IsVideoMsg:%d", [msgWrap IsVideoMsg]);
                NSLog(@"IsImgMsg:%d", [msgWrap IsImgMsg]);
                NSLog(@"IsChatRoomMessage:%d", [msgWrap IsChatRoomMessage]);
                NSLog(@"IsMassSendMessage:%d", [msgWrap IsMassSendMessage]);
                NSLog(@"IsBottleMessage:%d", [msgWrap IsBottleMessage]);
                NSLog(@"IsQQMessage:%d", [msgWrap IsQQMessage]);
                NSLog(@"IsSxMessage:%d", [msgWrap IsSxMessage]);
                NSLog(@"GetChatName:%@", [msgWrap GetChatName]);
                NSLog(@"333333333333333333333333333333333333333333333333");
#endif

                if ([msgWrap IsAppMessage])
                {
                    if (49 == [msgWrap m_uiMessageType])
                    {
                        if (NSNotFound != [[msgWrap m_nsContent] rangeOfString:@"![CDATA[微信转账]]"].location)
                        {
                            //NSLog(@"### App消息-转账 ###");
                        }
                        else if (NSNotFound != [[msgWrap m_nsContent] rangeOfString:@"![CDATA[微信红包]]"].location)
                        {
                            //NSLog(@"### App消息-红包 ###");

                            NSLog(@"~~~~~ 天噜啦！快来抢红包啊！！！ ~~~~~");

                            //<nativeurl><![CDATA[wxpay://c2cbizmessagehandler/hongbao/receivehongbao?msgtype=囧&channelid=囧&sendid=囧&sendusername=囧&ver=囧&sign=囧]]></nativeurl>
                            //截取 "wxpay://c2cbizmessagehandler/hongbao/receivehongbao?" 和 "]]></nativeurl>" 之间的内容
                            NSString* strTemp = [msgWrap m_nsContent];
                            NSRange rangeHead = [strTemp rangeOfString:@"<nativeurl><![CDATA["];
                            if (NSNotFound != rangeHead.location)
                            {
                                NSRange rangeTail = [strTemp rangeOfString:@"]]></nativeurl>"];
                                NSRange rangeBody = NSMakeRange(rangeHead.location+rangeHead.length, rangeTail.location-(rangeHead.location+rangeHead.length));

                                NSString* strNativeUrl = [strTemp substringWithRange:rangeBody];
                                //NSLog(@"strNativeUrl[len=%d]=%@", [strNativeUrl length], strNativeUrl);

                                NSRange rangeHead = [strTemp rangeOfString:@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?"];
                                if (NSNotFound != rangeHead.location)
                                {
                                    NSRange rangeTail = [strTemp rangeOfString:@"]]></nativeurl>"];
                                    NSRange rangeBody = NSMakeRange(rangeHead.location+rangeHead.length, rangeTail.location-(rangeHead.location+rangeHead.length));

                                    NSString* strTrip = [strTemp substringWithRange:rangeBody];
                                    //NSLog(@"strTrip[len=%d]=%@", [strTrip length], strTrip);

                                    if (nil == g_MMServiceCenter)
                                    {
                                        g_MMServiceCenter = [objc_getClass("MMServiceCenter") defaultCenter];//getclass method-1: objc_getClass
                                        //NSLog(@"g_MMServiceCenter=%@", g_MMServiceCenter);
                                    }

                                    if (g_MMServiceCenter)
                                    {
                                        //NSLog(@"g_MMServiceCenter=%@", g_MMServiceCenter);
                                        if (nil == g_WCRedEnvelopesLogicMgr)
                                        {
                                            //if ([g_MMServiceCenter respondsToSelector:@selector(getService:)])
                                            //{
                                                g_WCRedEnvelopesLogicMgr = [g_MMServiceCenter getService:NSClassFromString(@"WCRedEnvelopesLogicMgr")];//getclass method-2: NSClassFromString
                                                //NSLog(@"g_WCRedEnvelopesLogicMgr=%@", g_WCRedEnvelopesLogicMgr);
                                            //}
                                        }

                                        if (g_WCRedEnvelopesLogicMgr)
                                        {
                                            //NSLog(@"g_WCRedEnvelopesLogicMgr=%@", g_WCRedEnvelopesLogicMgr);

                                            CContactMgr* contactMgr = [g_MMServiceCenter performSelector:@selector(getService:) withObject:[objc_getClass("CContactMgr") class]];
                                            CContact* contact = [contactMgr getSelfContact];

                                            BOOL bMsgFromMe = [[msgWrap m_nsFromUsr] isEqualToString:[contact m_nsUsrName]];//是否为自己发出的消息
                                            //当自己给某单个人发红包（即非群红包）时，不抢自己发出的红包
                                            if (NO == [msgWrap IsChatRoomMessage] && bMsgFromMe)
                                            {
                                                NSLog(@"1 to 1 redEnvelop from me, ignore it");
                                            }
                                            else
                                            {
                                                //自己发出的群红包
                                                if ([msgWrap IsChatRoomMessage] && bMsgFromMe && NO == [readConfig(STR_KEY_SWITCH_CHAT) boolValue])
                                                {
                                                    NSLog(@"1 to N redEnvelop from me, ignore it");
                                                }

                                                NSDictionary* dictNativeUrl = [%c(WCBizUtil) performSelector:@selector(dictionaryWithDecodedComponets:separator:) withObject:strTrip withObject:@"&"];
#if 0
                                                NSLog(@"dictNativeUrl=%@", dictNativeUrl);

                                                NSLog(@"[contact m_nsHeadImgUrl]:%@", [contact m_nsHeadImgUrl]);
                                                NSLog(@"[contact m_nsUsrName]:%@", [contact m_nsUsrName]);
                                                NSLog(@"[contact m_nsNickName]:%@", [contact m_nsNickName]);
                                                NSLog(@"[contact getContactDisplayUsrName]:%@", [contact getContactDisplayUsrName]);
                                                NSLog(@"[contact getContactDisplayName]:%@", [contact getContactDisplayName]);
#endif
                                                NSMutableDictionary* dictParam = [NSMutableDictionary dictionary];
                                                [dictParam setObject:[dictNativeUrl objectForKey:@"channelid"] forKey:@"channelId"];            //channelId
                                                [dictParam setObject:[contact m_nsHeadImgUrl] forKey:@"headImg"];                               //headImg
                                                [dictParam setObject:[dictNativeUrl objectForKey:@"msgtype"] forKey:@"msgType"];                //msgType
                                                [dictParam setObject:strNativeUrl forKey:@"nativeUrl"];                                         //nativeUrl
                                                [dictParam setObject:[contact getContactDisplayName] forKey:@"nickName"];                       //nickName
                                                [dictParam setObject:[dictNativeUrl objectForKey:@"sendid"] forKey:@"sendId"];                  //sendId
                                                [dictParam setObject:[dictNativeUrl objectForKey:@"sendusername"] forKey:@"sessionUserName"];   //sessionUserName
                                                //NSLog(@"dictParam=%@", dictParam);

                                                //N秒后开抢
                                                double delayInSeconds = [readConfig(STR_KEY_DELAY_SEC) floatValue];
                                                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                                                dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                                                               {
                                                                   //NSLog(@"抢！抢！抢！");
                                                                   [g_WCRedEnvelopesLogicMgr OpenRedEnvelopesRequest:dictParam];
                                                               });
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    %orig;
}
%end


