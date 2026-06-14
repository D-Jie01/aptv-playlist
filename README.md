# APTV 直播源

供 APTV 使用的重庆联通 M3U 直播源。

## 订阅地址

- 主线路：`https://raw.githubusercontent.com/D-Jie01/aptv-playlist/main/cqcu-unicast.m3u`
- 备用线路：`https://raw.githubusercontent.com/D-Jie01/aptv-playlist/main/cqcu-unicast-alternative.m3u`
- 4K 频道：`https://raw.githubusercontent.com/D-Jie01/aptv-playlist/main/cqcu-%E5%8D%AB%E8%A7%864K.m3u`

修改对应的 M3U 文件并提交后，在 APTV 中刷新订阅即可获取最新版。

主线路中的 `世界杯专用` 分组由 GitHub Actions 每 30 分钟从上游订阅自动更新。其他频道仍可直接编辑；请不要手工修改两个“世界杯自动更新”标记之间的内容。

> 仓库为公开仓库。请勿在文件中提交真实密码、访问令牌或其他敏感信息。
