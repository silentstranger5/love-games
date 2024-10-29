# Simple Games Made With LÖVE

This repository contains some simple games made with [LOVE](https://love2d.org/) framework.

Here is a list of games:

- Asteroid
- Breakout
- Pong
- Invaders
- Snake
- Spaceship

# How to play

## Dependencies

- [Lua](https://www.lua.org/)
- [Love](https://love2d.org/)

## Instructions

After you have installed Lua and Love, and configured them properly (i.e., you might need to move files to 
programs directory and add them to the `PATH` variable), the rest is fairly straightforward:

```
git clone https://github.com/silentstranger5/love-games/
cd love-games
love pong
```

## Package as executable file

You may also want to package games as executables on your system. For specific instructions, look 
[here](https://love2d.org/wiki/Game_Distribution). Note that some details may be incomplete or outdated. 
Here are some details for Windows instructions.

Page provided above specifies GUI method for archive compression. Note that there is a command-line tool 
for that purpose. `compress-archive` is available on powershell, 
look [here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/compress-archive?view=powershell-7.4) 
for details.

Note that `love` executable may not be available from other commands, even if properly configured on `PATH`. 
You may need to specify full path, like `C:\Program Files\LOVE\love.exe`.

Also notice that PowerShell command syntax is obsolete. Instead of `-Encoding Byte` you have to use 
`-AsByteStream`.

Thus, if you want to create an executable file on windows machine, here is a list of powershell commands 
to create pong executable (assuming you are located at directory of this repository):

```
compress-archive .\pong\* pong.zip
move-item pong.zip pong.love
get-content $env:programfiles\love\love.exe,pong.love -asbytestream | set-content pong.exe -asbytestream
```
