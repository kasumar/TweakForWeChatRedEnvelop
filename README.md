# TweakForWeChatRedEnvelop

iOS自动抢红包插件 for 微信

安装方法1：
将Packages目录下的deb文件拷贝到手机上，通过dpkg安装

安装方法2：
将QiangHongBaoByKAGE目录下的文件安装到指定位置，详情参见ReadMe.txt

---------------------------------------------------------------------------------------
配置文件路径："/var/mobile/Media/iTunes_Control/iTunes/ConfigForWeChatRedEnvelop.plist"
包含3个设置项（手机端可用iFile的属性表编辑器直接修改）：
1、MainSwitch，总开关
2、ChatSwitch，是否抢自己发出的群红包
3、DelaySeconds，延时时长（单位：秒）

注：
1、非前台状态下，请关闭群聊的“消息免打扰”
2、本人只在 6.1.3、8.1.2、8.4 这3个版本上测试过，不保证其他版本也能正常使用
