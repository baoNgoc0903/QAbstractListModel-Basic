/* CLIENT */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
void error(const char* msg){
    perror(msg);
    exit(1);
}
int main (){
    printf("this is client\n");
    int n; // for check read write
    int sockfd; // định danh
    struct sockaddr_in ser_addr; // description ip internet adress, gồm port, ip adress, address family
    char buffer[255];
    time_t ticks;

    // reset tất cả về null
    memset(&ser_addr, 0, sizeof (ser_addr));
    memset(buffer, 0, sizeof (buffer));

    //create ra 1 cái socket
    if((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0){
        error("socket fail");
    }

    // chuẩn cái port và ip address của server
    ser_addr.sin_family = AF_INET;
    ser_addr.sin_addr.s_addr = inet_addr("192.168.220.129"); // ifconfig in linux
    ser_addr.sin_port = htons(9398); // hardcode cái port, nhưng k nên, nên dùng hàm create ra 1 port trống

    socklen_t ser = sizeof(ser_addr);
    if(connect(sockfd, (struct sockaddr*)&ser_addr, ser) ==-1){
        error("connect fail");
    }

    while(1){
        //read đọc byte từ sockfd ra buffer, độ dài byte 255
        memset(buffer,0,255);
        printf("client: ");
        fgets(buffer,255, stdin);
        if((n = write(sockfd, buffer, strlen(buffer))) <0){
            error("write fail");
        }
        memset(buffer,0,255);
        if((n = read(sockfd, buffer, 255)) < 0){
            error("read fail");
        }
        printf("serve: %s", buffer);
        int i = strncmp("bye", buffer, 3);
        if(i==0){
            break;
        }

        fflush(stdin);
    }

    close(sockfd);
    return 0;
}
