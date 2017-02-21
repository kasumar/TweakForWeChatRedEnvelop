#line 1 "/Users/KAGE/Documents/My/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop.xm"












































#import "HeaderForWeChatRedEnvelop.h"


#define PROC_BEGIN do {
#define PROC_END } while(0);














#define STR_FILE_CONFIG @"/var/mobile/Media/iTunes_Control/iTunes/ConfigForWeChatRedEnvelop.plist"
#define STR_KEY_SWITCH_MAIN         @"MainSwitch"       
#define STR_KEY_SWITCH_MINE         @"MineSwitch"       
#define STR_KEY_SWITCH_SINGLE       @"SingleSwitch"     
#define STR_KEY_IGNORE_SINGLE       @"IgnoreSingle"     
#define STR_KEY_SWITCH_CHAT         @"ChatSwitch"       
#define STR_KEY_IGNORE_CHAT         @"IgnoreChat"       
#define STR_KEY_DELAY_SEC           @"DelaySeconds"     
#define STR_KEY_PREVENTREVOKEMSG    @"PreventRevokeMsg" 


static id readConfig(NSString* strKey)
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithContentsOfFile:STR_FILE_CONFIG];

    return [dict objectForKey:strKey];
}

static BOOL isContain(NSString* strKey, id idList)
{
    if (idList && 0<[idList count])
    {
        for (NSString* obj in idList)
        {
            
            if ([strKey isEqualToString:obj])
            {
                NSLog(@"~~~ Bingo! ~~~~");
                return YES;
            }
        }
    }

    return NO;
}



MMServiceCenter* g_MMServiceCenter = nil;
WCRedEnvelopesLogicMgr* g_WCRedEnvelopesLogicMgr = nil;
BOOL g_bHasTimingIdentifier = NO;
BOOL g_bRobbing = NO; 
NSDictionary* g_dictParam = [NSMutableDictionary dictionary];



static void delayRobbing(NSDictionary* dictParam)
{
    
    double delayInSeconds = [readConfig(STR_KEY_DELAY_SEC) floatValue];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
    {
        NSLog(@"抢！抢！抢！");
        [g_WCRedEnvelopesLogicMgr OpenRedEnvelopesRequest:dictParam];
    });
}



#include <logos/logos.h>
#include <substrate.h>
@class CMessageDB; @class WCRedEnvelopesLogicMgr; @class WCBizUtil; @class CMessageMgr; @class CSyncBaseEvent; 
static void (*_logos_orig$_ungrouped$CSyncBaseEvent$NotifyFromPrtl$MessageInfo$)(CSyncBaseEvent*, SEL, unsigned long, id); static void _logos_method$_ungrouped$CSyncBaseEvent$NotifyFromPrtl$MessageInfo$(CSyncBaseEvent*, SEL, unsigned long, id); static void (*_logos_orig$_ungrouped$CMessageDB$DelMsg$MsgList$DelAll$)(CMessageDB*, SEL, id, id, BOOL); static void _logos_method$_ungrouped$CMessageDB$DelMsg$MsgList$DelAll$(CMessageDB*, SEL, id, id, BOOL); static void (*_logos_orig$_ungrouped$CMessageMgr$onRevokeMsg$)(CMessageMgr*, SEL, id); static void _logos_method$_ungrouped$CMessageMgr$onRevokeMsg$(CMessageMgr*, SEL, id); static void (*_logos_orig$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$)(WCRedEnvelopesLogicMgr*, SEL, id, id); static void _logos_method$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$(WCRedEnvelopesLogicMgr*, SEL, id, id); 
static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$WCBizUtil(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("WCBizUtil"); } return _klass; }
#line 124 "/Users/KAGE/Documents/My/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop.xm"


static void _logos_method$_ungrouped$CSyncBaseEvent$NotifyFromPrtl$MessageInfo$(CSyncBaseEvent* self, SEL _cmd, unsigned long arg1, id arg2) {
    

PROC_BEGIN







    
    if ([readConfig(STR_KEY_SWITCH_MAIN) boolValue] && 45 == arg1)
    {
        
        if (YES == [arg2 isKindOfClass:[NSDictionary class]])
        {
            id idTemp = [arg2 objectForKey:@"18"];
            if ([NSStringFromClass([idTemp class]) isEqualToString:@"CMessageWrap"])
            {
                CMessageWrap* msgWrap = idTemp;











































                if (nil == g_MMServiceCenter)
                {
                    NSString* strVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                    if (NSOrderedDescending == [strVersion compare:@"6.5.2" options:NSCaseInsensitiveSearch])
                    {
                        NSLog(@"WeChat Version=%@, has 'timingIdentifier' param", strVersion);
                        g_bHasTimingIdentifier = YES;
                    }

                    g_MMServiceCenter = [objc_getClass("MMServiceCenter") defaultCenter]; 
                    NSLog(@"g_MMServiceCenter=%@", g_MMServiceCenter);

                    if (g_MMServiceCenter)
                    {
                        if (nil == g_WCRedEnvelopesLogicMgr)
                        {
                            if ([g_MMServiceCenter respondsToSelector:@selector(getService:)])
                            {
                                g_WCRedEnvelopesLogicMgr = [g_MMServiceCenter getService:NSClassFromString(@"WCRedEnvelopesLogicMgr")]; 
                                
                            }
                            else
                            {
                                NSLog(@"Selector is deprecated: MMServiceCenter-getService:");
                            }
                        }
                    }
                }


                if (nil == g_MMServiceCenter)
                {
                    NSLog(@"MMServiceCenter is nil");
                    break;
                }
                if (nil == g_WCRedEnvelopesLogicMgr)
                {
                    NSLog(@"WCRedEnvelopesLogicMgr is nil");
                    break;
                }


                if ([msgWrap IsAppMessage])
                {
                    if (49 == [msgWrap m_uiMessageType])
                    {
                        if (NSNotFound != [[msgWrap m_nsContent] rangeOfString:@"![CDATA[微信转账]]"].location)
                        {
                            
                        }
                        else if (NSNotFound != [[msgWrap m_nsContent] rangeOfString:@"![CDATA[微信红包]]"].location)
                        {
                            

                            NSLog(@"~~~~~ 天噜啦！快来抢红包啊！！！ ~~~~~");

                            CContactMgr* contactMgr = [g_MMServiceCenter performSelector:@selector(getService:) withObject:[objc_getClass("CContactMgr") class]];
                            CContact* contact = [contactMgr getSelfContact];

                            BOOL bMsgFromMe = [[msgWrap m_nsFromUsr] isEqualToString:[contact m_nsUsrName]]; 

                            if (NO == [msgWrap IsChatRoomMessage]) 
                            {
                                
                                if (bMsgFromMe)
                                {
                                    if (NO == ([readConfig(STR_KEY_SWITCH_SINGLE) boolValue] && [readConfig(STR_KEY_SWITCH_MINE) boolValue]))
                                    {
                                        NSLog(@"Single RedEnvelop from me, ignore it");
                                        break;
                                    }
                                }
                                
                                else
                                {
                                    if (NO == [readConfig(STR_KEY_SWITCH_SINGLE) boolValue])
                                    {
                                        NSLog(@"Single RedEnvelop to me, ignore it");
                                        break;
                                    }

                                    
                                    NSString* strName = [msgWrap GetChatName];
                                    NSLog(@"strName=%@", strName);
                                    id idList = readConfig(STR_KEY_IGNORE_SINGLE);
                                    if (isContain(strName, idList))
                                    {
                                        NSLog(@"This user in the list of ignore.");
                                        break;
                                    }
                                    
                                }
                            }
                            else 
                            {
                                
                                CContact* contactTemp = [contactMgr getContactByName:[msgWrap GetChatName]];
                                if (nil != contactTemp)
                                {
                                    NSLog(@"getContactByName=%@", contactTemp);
                                    NSString* strNickName = [contactTemp m_nsNickName];
                                    NSLog(@"strNickName=%@", strNickName);
                                    id idList = readConfig(STR_KEY_IGNORE_CHAT);
                                    if (isContain(strNickName, idList))
                                    {
                                        NSLog(@"This chat in the list of ignore.");
                                        break;
                                    }
                                }
                                

                                
                                if (bMsgFromMe)
                                {
                                    if (NO == ([readConfig(STR_KEY_SWITCH_CHAT) boolValue] && [readConfig(STR_KEY_SWITCH_MINE) boolValue]))
                                    {
                                        NSLog(@"Chat RedEnvelop from me, ignore it");
                                        break;
                                    }
                                }
                                
                                else
                                {
                                    if (NO == [readConfig(STR_KEY_SWITCH_CHAT) boolValue])
                                    {
                                        NSLog(@"Chat RedEnvelop to me, ignore it");
                                        break;
                                    }
                                }
                            }


                            
                            
                            NSString* strTemp = [msgWrap m_nsContent];
                            if (NSNotFound == [strTemp rangeOfString:@"wxpay://"].location)
                            {
                                break;
                            }

                            NSLog(@"~~~~~ 准备抢红包！！！ ~~~~~");
                            NSRange rangeHead = [strTemp rangeOfString:@"<nativeurl><![CDATA["];
                            if (NSNotFound != rangeHead.location)
                            {
                                NSRange rangeTail = [strTemp rangeOfString:@"]]></nativeurl>"];
                                NSRange rangeBody = NSMakeRange(rangeHead.location+rangeHead.length, rangeTail.location-(rangeHead.location+rangeHead.length));

                                NSString* strNativeUrl = [strTemp substringWithRange:rangeBody];
                                

                                NSString* strTrip = [strNativeUrl substringFromIndex:[@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?" length]];
                                

                                
                                NSDictionary* dictNativeUrl = [_logos_static_class_lookup$WCBizUtil() performSelector:@selector(dictionaryWithDecodedComponets:separator:) withObject:strTrip withObject:@"&"];























                                [g_dictParam setObject:[dictNativeUrl objectForKey:@"channelid"] forKey:@"channelId"];          
                                [g_dictParam setObject:[contact m_nsHeadImgUrl] forKey:@"headImg"];                             
                                [g_dictParam setObject:[dictNativeUrl objectForKey:@"msgtype"] forKey:@"msgType"];              
                                [g_dictParam setObject:strNativeUrl forKey:@"nativeUrl"];                                       
                                [g_dictParam setObject:[contact getContactDisplayName] forKey:@"nickName"];                     
                                [g_dictParam setObject:[dictNativeUrl objectForKey:@"sendid"] forKey:@"sendId"];                
                                [g_dictParam setObject:[msgWrap m_nsFromUsr] forKey:@"sessionUserName"];                        

                                
                                

                                if (g_bHasTimingIdentifier)
                                {
                                    NSMutableDictionary* dictParam = [NSMutableDictionary dictionary];

                                    
                                    
                                    
                                    
                                    
                                    
                                    [dictParam setObject:@"0" forKey:@"agreeDuty"];                                             
                                    [dictParam setObject:[dictNativeUrl objectForKey:@"channelid"] forKey:@"channelId"];        
                                    [dictParam setObject:@"0" forKey:@"inWay"];                                                 
                                    [dictParam setObject:[dictNativeUrl objectForKey:@"msgtype"] forKey:@"msgType"];            
                                    [dictParam setObject:strNativeUrl forKey:@"nativeUrl"];                                     
                                    [dictParam setObject:[dictNativeUrl objectForKey:@"sendid"] forKey:@"sendId"];              

                                    NSLog(@"dictParam=%@", dictParam);
                                    [g_WCRedEnvelopesLogicMgr ReceiverQueryRedEnvelopesRequest:dictParam];
                                    g_bRobbing = YES;
                                }
                                else
                                {
                                    delayRobbing(g_dictParam);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
PROC_END

    _logos_orig$_ungrouped$CSyncBaseEvent$NotifyFromPrtl$MessageInfo$(self, _cmd, arg1, arg2);
}








#pragma mark - 业务流程日志




































BOOL g_bRevokeMsgFromOther = NO; 

#pragma mark - CMessageDB




static void _logos_method$_ungrouped$CMessageDB$DelMsg$MsgList$DelAll$(CMessageDB* self, SEL _cmd, id arg1, id arg2, BOOL arg3) {
    

    if ([readConfig(STR_KEY_PREVENTREVOKEMSG) boolValue] && g_bRevokeMsgFromOther)
    {
        g_bRevokeMsgFromOther = NO;
        return;
    }

    _logos_orig$_ungrouped$CMessageDB$DelMsg$MsgList$DelAll$(self, _cmd, arg1, arg2, arg3);
}




#pragma mark - CMessageMgr


















static void _logos_method$_ungrouped$CMessageMgr$onRevokeMsg$(CMessageMgr* self, SEL _cmd, id arg1) {
    

    g_bRevokeMsgFromOther = TRUE;

    _logos_orig$_ungrouped$CMessageMgr$onRevokeMsg$(self, _cmd, arg1);
}






































































































































































static void _logos_method$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$(WCRedEnvelopesLogicMgr* self, SEL _cmd, id arg1, id arg2) {
    

    _logos_orig$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$(self, _cmd, arg1, arg2);

PROC_BEGIN

    if (NO == g_bHasTimingIdentifier || NO == g_bRobbing)
    {
        break;
    }

#if 1
    if ([NSStringFromClass([arg1 class]) isEqualToString:@"HongBaoRes"])
    {
        HongBaoRes* hbRes = arg1;
        
        
        NSData* data = [[hbRes retText] buffer];
        if (nil != data && 0 < [data length])
        {
            NSError* error = nil;
            id jsonObj = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
            if (nil != error)
            {
                NSLog(@"HongBaoRes, json-error=%@", [error localizedDescription]);
            }
            else if (nil != jsonObj)
            {
                if ([NSJSONSerialization isValidJSONObject:jsonObj])
                {
                    
                    if ([jsonObj isKindOfClass:[NSDictionary class]])
                    {
                        id idTemp = jsonObj[@"timingIdentifier"];
                        
                        if (idTemp)
                        {
                            [g_dictParam setObject:idTemp forKey:@"timingIdentifier"]; 
                            delayRobbing(g_dictParam);
                            g_bRobbing = NO;
                        }
                    }
                }
            }
        }
    }
#endif





























PROC_END
}
































































static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$CSyncBaseEvent = objc_getClass("CSyncBaseEvent"); MSHookMessageEx(_logos_class$_ungrouped$CSyncBaseEvent, @selector(NotifyFromPrtl:MessageInfo:), (IMP)&_logos_method$_ungrouped$CSyncBaseEvent$NotifyFromPrtl$MessageInfo$, (IMP*)&_logos_orig$_ungrouped$CSyncBaseEvent$NotifyFromPrtl$MessageInfo$);Class _logos_class$_ungrouped$CMessageDB = objc_getClass("CMessageDB"); MSHookMessageEx(_logos_class$_ungrouped$CMessageDB, @selector(DelMsg:MsgList:DelAll:), (IMP)&_logos_method$_ungrouped$CMessageDB$DelMsg$MsgList$DelAll$, (IMP*)&_logos_orig$_ungrouped$CMessageDB$DelMsg$MsgList$DelAll$);Class _logos_class$_ungrouped$CMessageMgr = objc_getClass("CMessageMgr"); MSHookMessageEx(_logos_class$_ungrouped$CMessageMgr, @selector(onRevokeMsg:), (IMP)&_logos_method$_ungrouped$CMessageMgr$onRevokeMsg$, (IMP*)&_logos_orig$_ungrouped$CMessageMgr$onRevokeMsg$);Class _logos_class$_ungrouped$WCRedEnvelopesLogicMgr = objc_getClass("WCRedEnvelopesLogicMgr"); MSHookMessageEx(_logos_class$_ungrouped$WCRedEnvelopesLogicMgr, @selector(OnWCToHongbaoCommonResponse:Request:), (IMP)&_logos_method$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$, (IMP*)&_logos_orig$_ungrouped$WCRedEnvelopesLogicMgr$OnWCToHongbaoCommonResponse$Request$);} }
#line 819 "/Users/KAGE/Documents/My/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop.xm"
