/* SERVER */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <time.h>
void error(const char* msg){
    perror(msg);
    exit(1);
}

int main (){
    printf("this is server\n");
    int opt = 1;
    // sockfd chuyên để listen, còn newsockfd là chuyển để connect đến 1 client, nhiều client thì cần nhiều newsockfd
    int sockfd, newsockfd, n;

    // ser_addr là đại chỉ của bản thân server, cli_addr là ở chỗ accept(), hoặc dùng của thằng ser_addr cũng được
    struct sockaddr_in ser_addr, cli_addr;
    char buffer[255];
    time_t ticks;

    memset(buffer, 0, 255);
    memset(&ser_addr, 0, sizeof(ser_addr));
    memset(&cli_addr, 0, sizeof(cli_addr));

    //create socket to lister
    if((sockfd = socket(AF_INET, SOCK_STREAM, 0)) <0){
        error("socket fail");
    }

    //cho phép nhiều máy chủ cùng liên kết với 1 port, và phải ngăn chặn việc thằng này cướp quyền điều khiển của thằng khác
    if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, (char*)&opt, sizeof(opt)) <0){
        error("setsockopt fail");
    }

    // set address for socket where listen
    ser_addr.sin_family = AF_INET;
    ser_addr.sin_addr.s_addr = inet_addr("192.168.220.129");
    ser_addr.sin_port = htons(9398); // htons chuyển đổi port sang thứ tự byte mạng

    socklen_t ser = sizeof(ser_addr);
    // gắn cái địa chỉ đó vào cái socket thì mới được
    if(bind(sockfd, (struct sockaddr*)&ser_addr, ser) <0){
        error("bind fail");
    }
    if(listen(sockfd, 9) <0){
      error("listen fail");
    }
    socklen_t cli = sizeof (cli_addr);

    /*accept sẽ block code(chặn lại ở đây đợi đến khi có thằng connect đến, paramater2 sẽ lưu thông tin của client connect đến(ip, port)
    lúc đó mình sẽ thấy cái port của client để bắn đến nó khác với cái port mình hardcode */

    /* khi mà nhiều thằng client connect đến thì mỗi 1 connect sẽ cần 1 newsockfd - 1 file description để transfer thông tin
    còn cái par2 thì k cần thay đổi*/
    if((newsockfd = accept(sockfd, (struct sockaddr*)&cli_addr, &cli)) < 0){
        error("accept fail");
    }
    printf("New connection , socket fd is %d , ip is : %s , port : %d \n" , newsockfd , inet_ntoa(cli_addr.sin_addr) , ntohs
          (cli_addr.sin_port));
    while(1){
        /* ví dụ nếu đặt accept ở đây, sẽ xảy ra vấn đề là cứ sau 1 lần lặp while, nó lại yêu cầu phải có
        1 thằng client connect đến nó */
        memset(buffer, 0, 255); // reset buffer

        //read nos sex block code để đợi thằng write xong
        if((n = read(newsockfd, buffer, 255)) < 0){
            error("read fail");
        }
        printf("client: %s", buffer);
        memset(buffer, 0, 255);
        printf("serve: ");
        fgets(buffer, 255, stdin);

//        ticks = time(nullptr);
//        sprintf(buffer, "at %s", ctime(&ticks));
//        strcat(buffer, buffer_);

        // ghi byte from buffer to newsockfd
        if((n = write(newsockfd, buffer, strlen(buffer))) <0){
            error("write fail");
        }

        int i = strncmp("bye", buffer, 3);
        if(i==0){
            break;
        }
        fflush(stdin);
    }
    close(sockfd);
    close(newsockfd);

    return 0;
}
