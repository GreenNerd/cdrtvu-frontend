### 环境要求
`node`, `npm`, `gulp`, `coffee`, `sass`

### 使用
* 安装好依赖
```
npm install
```
* 启动gulp任务
```
gulp
```
* 启动服务器 **(需要新开一个命令行)**
```
coffee server/server.coffee
```
* 使用
服务器启动后打开浏览器输入`localhost:4000`即可

### 写在最后
* 编译好的文件放在src_target内
* gulp内关于scss和jade的编译有些参数不能使用，造成编译出的代码不好看，如有需要，请使用相应的命令自行编译。
