# 1. builder, 给构建阶段命名
# basic image
FROM node:16-alpine as builder
# do some change
WORKDIR '/app'
COPY package.json .
RUN npm install
# 不会再变更代码所以直接复制
COPY . .
# 进行build为之后运行在nginx做准备
RUN npm run build

# 2. nginx
FROM nginx
# 从上面的构建阶段builder复制文件,仅复制最终的构建的项目
COPY --from=builder /app/build /usr/share/nginx/html
