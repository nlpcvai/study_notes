# VS Code debug C

Vscode vim 模式下持续按键无法移动光标

打开终端，输入以下命令：

```shell
# To disable the Apple press and hold for VSCode only
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

然后重启 **Vscode**。

想重新恢复的话可以这样：

```shell
# To re-enable, run this command in a terminal
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool true
```

重启 **Vscode**。

#### vscode vim key mapping

`"vim.insertModeKeyBindings": [{"before": ["j", "k"], "after": ["<ESC>"]}]`

Vscode error tip:

**The preLaunchTask 'gcc build active file' terminated with exit code 1.**

# gdb

```shell
sudo gdb menu
layout next
break main
run

```



opengl

``` shell

Error: Undefined symbols for architecture x86_64:
  "_glBegin", referenced from:
      Render() in test.cpp.o
Solution: 
find_package(OpenGL REQUIRED)
find_package(glfw3 REQUIRED)
set( CMAKE_CXX_FLAGS "-std=c++11" 
target_link_libraries(glprj glfw)
target_link_libraries(glprj OpenGL::GL)
```

mac VS code cmake OpenGL environment configration

``` shell
brew install glew
https://github.com/glfw/glfw.git
mkdir build
cd build
cmake ..
make 
make install


```

CMakeLists.txt

``` shell
cmake_minimum_required(VERSION 3.9)

project(glprj)

include_directories(/usr/local/include)
find_package(OpenGL REQUIRED)
find_package(glfw3 REQUIRED)
set( CMAKE_CXX_FLAGS "-std=c++11" )
link_directories(/usr/local/lib)

add_executable(glprj test.cpp)
target_link_libraries(glprj glfw)
target_link_libraries(glprj OpenGL::GL)
```

``` shell
Undefined symbols for architecture x86_64:
  "_glewInit", referenced from:
      _main in test.cpp.o
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make[2]: *** [glprj] Error 1
make[1]: *** [CMakeFiles/glprj.dir/all] Error 2
make: *** [all] Error 2

```

Solution: detete glewInit function.

``` shell
cmake  --build ./build --config Debug --target all -- -j 4
Error: could not load cache
Solution: 
step 1: cmake ..
step 2: cmake  --build . --config Debug --target all -- -j 4
no debug adapter
```

#### Shortcuts

``` shell
# Navigation history
Navigate entire history: Ctrl+Tab
Navigate back: Alt+Left
Navigate forward: Alt+Right

# Go to Definition
Select a symbol then type F12. Alternatively, you can use the context menu or Ctrl+click (Cmd+click on macOS).

# Go to References
Select a symbol then type Shift+F12. Alternatively, you can use the context menu.
```



