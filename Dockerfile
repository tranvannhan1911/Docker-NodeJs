# sử dụng môi trường node
FROM node:17-alpine

# tạo một thư mục app trong image và cd đến nó
WORKDIR /app

# copy toàn bộ vào thư mục /app trong image
COPY . .

# Chỉ chạy 1 lần khi build
RUN npm install

# câu lệnh mặc định khi 1 container được khởi tạo từ image này
CMD ["npm", "start"]