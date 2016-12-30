# TweakForWeChatRedEnvelop

iOS自动抢红包插件 for 微信（6.2.0 ~ 6.5.2，更老的版本我没试过，应该也支持吧）

支持系统：iOS 6.x ~ 9.3.3


安装方法1:
将Packages目录下的deb文件拷贝到手机上, 通过dpkg安装

安装方法2:
将QiangHongBaoByKAGE目录下的文件安装到指定位置, 详情参见ReadMe.txt

---------------------------------------------------------------------------------------
配置文件路径: "/var/mobile/Media/iTunes_Control/iTunes/ConfigForWeChatRedEnvelop.plist"
包含6个设置项(手机端可用iFile的属性表编辑器直接修改):

1. MainSwitch, 总开关

2. MineSwitch, 自己发出的红包(群红包第一次发出时, 自己是收不到红包消息的, 只有"继续发送此红包"才会收到消息)

3. SingleSwitch, 单人(非群)红包开关，IgnoreSingle下的用户将被忽略

4. IgnoreSingle, 忽略列表-用户，填写用户的“微信号”（注意，不是名字）

5. ChatSwitch, 群红包开关，IgnoreChat下的群将被忽略

6. IgnoreChat, 忽略列表-群聊，填写群的“群聊名称”（注意，必须完整填写）

7. DelaySeconds, 延时时长(单位: 秒)

8. PreventRevokeMsg, 禁止撤回消息(会收到 '"xx"撤回了一条消息' 的系统提示，但是已经收到的内容不会被删除，也就是说系统提示的上一条就是对方撤销的内容)

---------------------------------------------------------------------------------------
注:

1、非前台状态下, 请关闭群聊的“消息免打扰”

2、通过Cydia安装Watchdog，可以设置微信常驻后台运行
