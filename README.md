# TweakForWeChatRedEnvelop

iOS自动抢红包插件 for 微信

安装方法1:
将Packages目录下的deb文件拷贝到手机上, 通过dpkg安装

安装方法2:
将QiangHongBaoByKAGE目录下的文件安装到指定位置, 详情参见ReadMe.txt

---------------------------------------------------------------------------------------
配置文件路径: "/var/mobile/Media/iTunes_Control/iTunes/ConfigForWeChatRedEnvelop.plist"
包含6个设置项(手机端可用iFile的属性表编辑器直接修改):

1. MainSwitch, 总开关

2. MineSwitch, 自己发出的红包(群红包第一次发出时, 自己是收不到红包消息的, 只有"继续发送此红包"才会收到消息)

3. SingleSwitch, 单人(非群)红包

4. ChatSwitch, 群红包

5. DelaySeconds, 延时时长(单位: 秒)

6. PreventRevokeMsg, 禁止撤回消息(会收到 '"xx"撤回了一条消息' 的系统提示，但是已经收到的内容不会被删除，也就是说系统提示的上一条就是对方撤销的内容)


注:

1、非前台状态下, 请关闭群聊的“消息免打扰”

2、本人只在 6.1.3、8.1.2、8.4 这3个版本上测试过, 不保证其他版本也能正常使用
