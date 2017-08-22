# Socket
socket
- **主机地址（主机名）**
  - 网络中设备的标示
  - 不易记忆，可以用主机名
  - 本地会环地址：127.0.0.1      主机名：localhost
- **端口号**
  - 用于标示进程的逻辑地址，不同进程的标示
  - 有效端口：0~65535
  - 其中0~1024由系统使用或者保留端口，开发中不要使用1024以下的端口
- **传输协议（通讯的规则）**
  - TCP
  - UDP

0-255.0——255.0——255.0——255
4G 42亿
IPV6 2^64
IP:127.0.0.1  localhost



ping  127.0.0.1和ping ip地址有区别吗
ping ip的时候首先去ping的是路由器

苹果自带了一个Apache服务

**常见的网络协议**
![网络协议.png](http://upload-images.jianshu.io/upload_images/1718623-55ebcac2ae13856a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**OSI网络模型-数据传输层**
![网络模型.png](http://upload-images.jianshu.io/upload_images/1718623-772af8eb699eae72.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**网络参考模型**
![网络参考模型.png](http://upload-images.jianshu.io/upload_images/1718623-2df38757d06f6f71.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

----
- **UDP（用户数据报协议）短信**
  - 只管发送，不确认对方是否接收到
  - 将数据及**源和目的**封装成数据包中，不需要建立连接
   - 每个数据报的大小限制在64k之内
   - 因为无需连接，因此是不可靠协议
   - 不需要建立连接，速度快
   - 应用场景：网络流媒体/游戏
- **TCP（传输控制协议）**
   - 建立连接,形成传输数据的通道
   - 在连接中进行大数据传输（数据大小不受限制）
   - 通过三次握手完成连接，是**可靠协议，安全送达**
   - 必须建立连接，效率会稍低
----
#Socket （套接字层、插座——AT&T）
- Socket就是为网络服务提供的一种机制
   - 在Unix中，网络既是Socket，并不局限在TCP/UDP
   - Socket可以用于自定义协议
- 通信的两端都是Socket
- 网络通信其实就是Socket间的通信
- 数据在两个Socket间通过IO传输
- Socket开始是纯C语言的，是跨平台的

#Socket开发——Netcat
- nc -lk 12345
   - 始终监听本地计算机12345端口的数据
- Netcat
   - 是终端下用于调试和检查网络的工具包
   - 可用于创建TCP/IP连接
