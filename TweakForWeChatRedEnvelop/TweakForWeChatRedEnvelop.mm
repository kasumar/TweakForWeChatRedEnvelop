#line 1 "/Users/lbh/Documents/My/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop.xm"












































#import "HeaderForWeChatRedEnvelop.h"














#define STR_FILE_CONFIG @"/var/mobile/Media/iTunes_Control/iTunes/ConfigForWeChatRedEnvelop.plist"
#define STR_KEY_SWITCH_MAIN         @"MainSwitch"       
#define STR_KEY_SWITCH_MINE         @"MineSwitch"       
#define STR_KEY_SWITCH_SINGLE       @"SingleSwitch"     
#define STR_KEY_SWITCH_CHAT         @"ChatSwitch"       
#define STR_KEY_DELAY_SEC           @"DelaySeconds"     
#define STR_KEY_PREVENTREVOKEMSG    @"PreventRevokeMsg" 


static id readConfig(NSString* strKey)
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithContentsOfFile:STR_FILE_CONFIG];

    return [dict objectForKey:strKey];
}



MMServiceCenter* g_MMServiceCenter = nil;
WCRedEnvelopesLogicMgr* g_WCRedEnvelopesLogicMgr = nil;



#include <logos/logos.h>
#include <substrate.h>
@class CMessageDB; @class WCBizUtil; @class CMessageMgr; @class CSyncBaseEvent; 
static void (*_logos_orig$_ungrouped$CSyncBaseEvent$NotifyFromPrtl$MessageInfo$)(CSyncBaseEvent*, SEL, unsigned long, id); static void _logos_method$_ungrouped$CSyncBaseEvent$NotifyFromPrtl$MessageInfo$(CSyncBaseEvent*, SEL, unsigned long, id); static void (*_logos_orig$_ungrouped$CMessageDB$DelMsg$MsgList$DelAll$)(CMessageDB*, SEL, id, id, BOOL); static void _logos_method$_ungrouped$CMessageDB$DelMsg$MsgList$DelAll$(CMessageDB*, SEL, id, id, BOOL); static void (*_logos_orig$_ungrouped$CMessageMgr$onRevokeMsg$)(CMessageMgr*, SEL, id); static void _logos_method$_ungrouped$CMessageMgr$onRevokeMsg$(CMessageMgr*, SEL, id); 
static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$WCBizUtil(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("WCBizUtil"); } return _klass; }
#line 83 "/Users/lbh/Documents/My/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop.xm"


static void _logos_method$_ungrouped$CSyncBaseEvent$NotifyFromPrtl$MessageInfo$(CSyncBaseEvent* self, SEL _cmd, unsigned long arg1, id arg2) {
    








    
    if ([readConfig(STR_KEY_SWITCH_MAIN) boolValue] && 45 == arg1)
    {
        
        if (YES == [arg2 isKindOfClass:[NSDictionary class]])
        {
            id idTemp = [arg2 objectForKey:@"18"];
            if ([NSStringFromClass([idTemp class]) isEqualToString:@"CMessageWrap"])
            {
                CMessageWrap* msgWrap = idTemp;









































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

                            
                            
                            NSString* strTemp = [msgWrap m_nsContent];
                            NSRange rangeHead = [strTemp rangeOfString:@"<nativeurl><![CDATA["];
                            if (NSNotFound != rangeHead.location)
                            {
                                NSRange rangeTail = [strTemp rangeOfString:@"]]></nativeurl>"];
                                NSRange rangeBody = NSMakeRange(rangeHead.location+rangeHead.length, rangeTail.location-(rangeHead.location+rangeHead.length));

                                NSString* strNativeUrl = [strTemp substringWithRange:rangeBody];
                                

                                NSRange rangeHead = [strTemp rangeOfString:@"wxpay://c2cbizmessagehandler/hongbao/receivehongbao?"];
                                if (NSNotFound != rangeHead.location)
                                {
                                    NSRange rangeTail = [strTemp rangeOfString:@"]]></nativeurl>"];
                                    NSRange rangeBody = NSMakeRange(rangeHead.location+rangeHead.length, rangeTail.location-(rangeHead.location+rangeHead.length));

                                    NSString* strTrip = [strTemp substringWithRange:rangeBody];
                                    

                                    if (nil == g_MMServiceCenter)
                                    {
                                        g_MMServiceCenter = [objc_getClass("MMServiceCenter") defaultCenter]; 
                                        
                                    }

                                    if (g_MMServiceCenter)
                                    {
                                        
                                        if (nil == g_WCRedEnvelopesLogicMgr)
                                        {
                                            
                                            
                                                g_WCRedEnvelopesLogicMgr = [g_MMServiceCenter getService:NSClassFromString(@"WCRedEnvelopesLogicMgr")]; 
                                                
                                            
                                        }

                                        if (g_WCRedEnvelopesLogicMgr)
                                        {
                                            

                                            CContactMgr* contactMgr = [g_MMServiceCenter performSelector:@selector(getService:) withObject:[objc_getClass("CContactMgr") class]];
                                            CContact* contact = [contactMgr getSelfContact];

                                            BOOL bMsgFromMe = [[msgWrap m_nsFromUsr] isEqualToString:[contact m_nsUsrName]]; 
                                            BOOL bOpenRedEnvelopes = NO; 

                                            if (NO == [msgWrap IsChatRoomMessage]) 
                                            {
                                                
                                                if (bMsgFromMe)
                                                {
                                                    if ([readConfig(STR_KEY_SWITCH_SINGLE) boolValue] && [readConfig(STR_KEY_SWITCH_MINE) boolValue])
                                                    {
                                                        bOpenRedEnvelopes = YES;
                                                    }
                                                    else
                                                    {
                                                        NSLog(@"Single RedEnvelop from me, ignore it");
                                                    }
                                                }
                                                
                                                else
                                                {
                                                    if ([readConfig(STR_KEY_SWITCH_SINGLE) boolValue])
                                                    {
                                                        bOpenRedEnvelopes = YES;
                                                    }
                                                    else
                                                    {
                                                        NSLog(@"Single RedEnvelop to me, ignore it");
                                                    }
                                                }
                                            }
                                            else 
                                            {
                                                
                                                if (bMsgFromMe)
                                                {
                                                    if ([readConfig(STR_KEY_SWITCH_CHAT) boolValue] && [readConfig(STR_KEY_SWITCH_MINE) boolValue])
                                                    {
                                                        bOpenRedEnvelopes = YES;
                                                    }
                                                    else
                                                    {
                                                        NSLog(@"Chat RedEnvelop from me, ignore it");
                                                    }
                                                }
                                                
                                                else
                                                {
                                                    if ([readConfig(STR_KEY_SWITCH_CHAT) boolValue])
                                                    {
                                                        bOpenRedEnvelopes = YES;
                                                    }
                                                    else
                                                    {
                                                        NSLog(@"Chat RedEnvelop to me, ignore it");
                                                    }
                                                }
                                            }

                                            
                                            if (bOpenRedEnvelopes)
                                            {
                                                NSDictionary* dictNativeUrl = [_logos_static_class_lookup$WCBizUtil() performSelector:@selector(dictionaryWithDecodedComponets:separator:) withObject:strTrip withObject:@"&"];









                                                NSMutableDictionary* dictParam = [NSMutableDictionary dictionary];
                                                [dictParam setObject:[dictNativeUrl objectForKey:@"channelid"] forKey:@"channelId"];            
                                                [dictParam setObject:[contact m_nsHeadImgUrl] forKey:@"headImg"];                               
                                                [dictParam setObject:[dictNativeUrl objectForKey:@"msgtype"] forKey:@"msgType"];                
                                                [dictParam setObject:strNativeUrl forKey:@"nativeUrl"];                                         
                                                [dictParam setObject:[contact getContactDisplayName] forKey:@"nickName"];                       
                                                [dictParam setObject:[dictNativeUrl objectForKey:@"sendid"] forKey:@"sendId"];                  
                                                [dictParam setObject:[msgWrap m_nsFromUsr] forKey:@"sessionUserName"];                          
                                                

                                                
                                                double delayInSeconds = [readConfig(STR_KEY_DELAY_SEC) floatValue];
                                                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                                                dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                                                               {
                                                                   
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











































































































static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$CSyncBaseEvent = objc_getClass("CSyncBaseEvent"); MSHookMessageEx(_logos_class$_ungrouped$CSyncBaseEvent, @selector(NotifyFromPrtl:MessageInfo:), (IMP)&_logos_method$_ungrouped$CSyncBaseEvent$NotifyFromPrtl$MessageInfo$, (IMP*)&_logos_orig$_ungrouped$CSyncBaseEvent$NotifyFromPrtl$MessageInfo$);Class _logos_class$_ungrouped$CMessageDB = objc_getClass("CMessageDB"); MSHookMessageEx(_logos_class$_ungrouped$CMessageDB, @selector(DelMsg:MsgList:DelAll:), (IMP)&_logos_method$_ungrouped$CMessageDB$DelMsg$MsgList$DelAll$, (IMP*)&_logos_orig$_ungrouped$CMessageDB$DelMsg$MsgList$DelAll$);Class _logos_class$_ungrouped$CMessageMgr = objc_getClass("CMessageMgr"); MSHookMessageEx(_logos_class$_ungrouped$CMessageMgr, @selector(onRevokeMsg:), (IMP)&_logos_method$_ungrouped$CMessageMgr$onRevokeMsg$, (IMP*)&_logos_orig$_ungrouped$CMessageMgr$onRevokeMsg$);} }
#line 495 "/Users/lbh/Documents/My/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop/TweakForWeChatRedEnvelop.xm"
