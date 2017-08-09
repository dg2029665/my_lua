local TitleScene = class("TitleScene",function()
return display.newScene("TitleScene")
end)

local function createStaticButton(node,imageName,x,y,callback)
 cc.ui.UIPushButton.new({normal= imageName,pressed =imageName})
 :onButtonClicked(callback)
 :pos(x,y)   
 :addTo(node) 
end  

function TitleScene:onEnter()
display.newSprite("bg.jpg")
:pos(display.cx,display.cy)
:addTo(self)

 createStaticButton(self,"btn_start.png",display.cx,display.cy/2,function()
print("start")
local s = require("app.scenes.MainScene").new()
display.replaceScene(s,"fade",0.6,display.COLOR_BLACK)
end)

 createStaticButton(self,"btn_option.png",display.cx -200,display.bottom +80,function()
print("option")
end)

createStaticButton(self,"btn_question.png",display.cx,display.bottom +80,function()
print("question")
end)

createStaticButton(self,"btn_exit.png",display.cx +200,display.bottom +80,function()
print("exit")
end)

 end 
 

return TitleScene 



 
 
 
 
 
 
 
 
 
 