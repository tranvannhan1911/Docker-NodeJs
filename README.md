# Docker với NodeJs

1. Các khái niệm
2. Cài đặt
    1. Dockerfile
        
        ```bash
        # sử dụng môi trường node
        FROM node:latest
        
        # tạo một thư mục app trong image và cd đến nó
        WORKDIR /app
        
        # copy toàn bộ vào thư mục /app trong image
        COPY . .
        
        # Chỉ chạy 1 lần khi build
        RUN npm install
        
        # câu lệnh mặc định khi 1 container được khởi tạo từ image này
        CMD ["npm", "start"]
        ```
        
    2. build image
        
        ```bash
        $ docker build -t learning-docker/docker-node:v1 .
        ```
        
        - Để build Docker image ta dùng command **docker build...*
        - Option **t** để chỉ là đặt tên Image. Ở đây tên image là **learning-docker/**docker-node và gán cho nó tag là **v1**, ý chỉ đây là phiên bản số 1. Nếu không gán tag thì mặc định sẽ được để là **latest**.
        - Cuối cùng mình có 1 dấu "chấm" ý bảo là Docker hãy build Image với **context** (bối cảnh) ở folder hiện tại. Và Docker sẽ tìm ở folder hiện tại Dockerfile và build.
    3. docker-compose.yml
        
        ```bash
        version: "3.7"
        
        services:
          app:
            image: learning-docker/docker-node:v1
            # mapping port từ hệ điều hành gốc vào port trong container
            ports:
              - "3001:3000"
            # khởi động lại trừ khi bị dừng
            restart: unless-stopped
        ```
        
    4. Tạo container
        
        ```bash
        $ docker-compose up
        
        $ docker-compose down # dừng các container đang chạy
        $ docker-compose up # khởi động lại
        ```
        
    5. Cmd trong container
        
        ```bash
        # open shell
        $ docker-compose exec <ten-app> sh
        
        # run a cmd in docker container
        $ docker-compose exec <ten-app> <cmd>
        ```
        
        - Có thể sử dụng shell bên trong container
    6. Cách xem các images
        
        ```bash
        $ docker images
        ```
        
    7. Sử dụng alpine làm hệ điều hành
        
        ```bash
        # sử dụng môi trường node và HDH alpine
        FROM node:17-alpine
        ```
        
3. Các câu lệnh khác
    1. Copy nhiều file
        
        ```bash
        COPY app.js .  # Copy app.js ở folder hiện tại vào đường dẫn ta set ở WORKDIR trong Image
        COPY app.js /abc/app.js   ## Kết quả tương tự, ở đây ta nói rõ ràng hơn (nếu ta muốn copy tới một chỗ nào khác không phải WORKDIR)
            
        # Copy nhiều file
        COPY app.js package.json package-lock.json .
        # Ở trên ta các bạn có thể copy bao nhiêu file cũng được, phần tử cuối cùng (dấu "chấm") là đích ta muốn copy tới trong Image
        ```
        
    2. ADD để copy file
        - Có thể copy từ máy vào image
        - Có thể copy từ một địa chỉ URL vào trong Image
        - Cũng có thể giải nén một file và copy vào trong Image
    3. ENTRYPOINT
        - Chạy 1 file sh để cấu hình trước khi khởi chạy CMD
        
        ```bash
        ENTRYPOINT ["sh", "/var/www/html/.docker/docker-entrypoint.sh"]
        
        CMD supervisord -n -c /etc/supervisord.conf
        ```
        
    4. Chạy container trong background
        
        ```bash
        $ docker-compose up -d
        ```
        
    5. Xem logs
        
        ```bash
        $ docker-compose logs
        
        # check log realtime
        $ docker-compose logs -f
        ```
        
4. Tài liệu tham khảo
    1. [https://viblo.asia/p/dockerize-ung-dung-nodejs-RnB5pxEG5PG](https://viblo.asia/p/dockerize-ung-dung-nodejs-RnB5pxEG5PG)