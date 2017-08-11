//
//  ViewController.m
//  socket
//
//  Created by lyy on 2017/8/11.
//  Copyright © 2017年 LVY. All rights reserved.
//  Socket网络连接底层
// 首先需要在终端：nc -lk 12345

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface ViewController ()
@property(nonatomic, assign)int clinetSocket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self doConnection];
    
    //HTTP协议 是客户端和服务器之间的约定
    NSString *request = @"GET / HTTP/1.1\n"
                         "Host: localhost\n\n";
    
    
    [self sendWithStr:request];
    
    
}
- (void)doConnection{
    //1.创建
    /**
     参数
     
     demain:   协议域，AF_INET->IPV4
     type:     Socket 类型 SOCK_STREAM/SOCK_DGRAM
     protocal: IPPROTO_TCP,如果是0，会自动根据第二个参数，选择合适的协议
     */
    self.clinetSocket = socket(AF_INET, SOCK_STREAM, 0);
    //2.连接
    /**
     参数
     1》客户端socket
     2》指向数据结构sockaddr的指针，其中包括目的端口和IP地址
     3》结构体数据长度
     返回值
     0成功/其他  错误代号
     */
    struct sockaddr_in severAddr;
    //协议域 IPV4
    severAddr.sin_family = AF_INET;
    //端口
    severAddr.sin_port  = htons(12345);
    //地址
    severAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    //在C语言开发中，经常传递一个数据的指针，还需要指定数据的长度！
    int connResult = connect(self.clinetSocket, (const struct sockaddr *)&severAddr, sizeof(severAddr));
    if (connResult == 0) {
        NSLog(@"成功");
    }else{
        NSLog(@"失败");
        return;
    }

}
//MARK: SOCKET演练
- (void)sendWithStr:(NSString *)str{
    //3.发送
    /**
     参数
     1》客户端socket
     2》发送内容地址
     3》发送内容长度
     4》发送方式标志，一般为0
     返回值
     如果成功，则返回发送的字节数，失败则返回SOCKET_ERROR
     */
    NSString *msg =str;
    size_t sendLen = send(self.clinetSocket, msg.UTF8String, strlen(msg.UTF8String), 0);
    NSLog(@"%ld",sendLen);
    
    //4.读数据
    /**
     参数
     1》客户端socket
     2》接收内容缓冲地址 提前准备
     3》接收内容缓存区长度
     4》接收方式，0表示阻塞，必须等待服务器返回数据
     返回值
     如果成功，则返回读入的字节数，失败则返回SOCKET_ERROR
     */
    uint8_t buffer[1024];//准备的空间
    
    ssize_t recvLen = recv(self.clinetSocket,buffer,sizeof(buffer),0);
    NSLog(@"接收到了%ld个字节",recvLen);
    //获取服务器返回的数据
    NSData *data = [NSData dataWithBytes:buffer length:recvLen];
    //str
    NSString *str1 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str1);

    //关闭
    close(self.clinetSocket);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
