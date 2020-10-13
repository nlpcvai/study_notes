# youtube-dl usage

``` shell
# To download the best quality audio and video and merge them:
youtube-dl -f bestvideo+bestaudio <url>
# To download the best quality mp4 format
http_proxy=http://127.0.0.1:3213 https_proxy=http://127.0.0.1:3213 youtube-dl -f best[ext=mp4] --yes-playlist https://www.youtube.com/watch?v=Fo-3MtrXr3E&list=PL6S9AqLQkFpongEA75M15_BlQBC9rTdd8

http_proxy=http://127.0.0.1:3213 https_proxy=http://127.0.0.1:3213 youtube-dl -f best[ext=mp4] https://www.youtube.com/watch?v=EjPWklezNrU&list=PL6S9AqLQkFpongEA75M15_BlQBC9rTdd8&index=22

youtube-dl -i -f mp4 --yes-playlist 'https://www.youtube.com/watch?v=7Vy8970q0Xc&list=PLwJ2VKmefmxpUJEGB1ff6yUZ5Zd7Gegn2'

```

This is your benefits schedule. 

# Downie usage

首先，运行 Downie，点击菜单栏「浏览器 > 打开登陆地址…」，在弹出的窗口中输入哔哩哔哩的网址链接并点击「前往」，Downie 就会打开内置浏览器并跳转至哔哩哔哩主页，然后按正常流程登录账号即可。

登录哔哩哔哩账号之后，可以直接将需要下载的 4K 视频的链接地址粘贴至 Downie 主界面，软件就会自动解析并创建下载任务。此外，Downie 4 新增的 Cookie 功能能够保存你的账号登陆状态，让你在后续再次下载时无需重复登陆账号这一操作，更加省时省力。

对于一些 Downie 无法成功解析的视频链接，不妨尝试一下 Downie 的「用户自定义视频提取」功能。运行 Downie，点击菜单栏的「浏览器 > 用户自定义视频提取」，在弹出的浏览器窗口中粘贴链接地址，并播放视频，Downie 就可以自动抓取到流媒体。然后，在右侧的下载栏中选取视频流，点击「添加」就会开始创建下载任务。这个功能不仅可以抓取流媒体，还可以用于抓取网页的图片元素，针对一些无法通过右键保存的图片非常方便，既支持自由选择也可以一键添加全部下载。

