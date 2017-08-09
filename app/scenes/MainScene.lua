local cGridSize = 33
local scaleRate = 1 / display.contentScaleFactor

function Grid2Pos(x,y)
  local visibleSize = cc.Director:getInstance():getVisibleSize()
  local origin = cc.Director:getInstance():getVisibleOrigin()
 
 local finalX = origin.x + visibleSize.width / 2 + x * cGridSize * scaleRate
 local finalY = origin.y + visibleSize.height / 2 + y * cGridSize * scaleRate
 
 return finalX,finalY
 
 end




local Snake = require "app.Snake"
local AppleFactory = require"app.AppleFactory"
local Fence = require "app.Fence"

local cInitLen = 3

local MainScene = class("MainScene",function()
    return display.newScene("MainScene")
end)

local cMoveSpeed = 0.3
local cBound = 7

   function MainScene:onEnter()

   	self.fence = Fence.new(cBound,self)
    
    self:Reset()
	
    self:ProcessInput()

	local tick = function()

  if self.stage == "running" then
	
	self.snake:Update()
	
	 
    local headX,headY = self.snake:GetHeadGrid()

     if self.appleFactory:CheckCollide(headX,headY)then

     	self. appleFactory:Generate()

     	self.snake:Grow()

     end


     if self.snake:CheckSelfCollide() or self.fence:CheckCollide(headX,headY)then
        self.stage = "dead"
     	self.snake:Blink(function()
     		 self:Reset()
        end)


    end

  end

end


	cc.Director:getInstance():getScheduler():scheduleScriptFunc(tick,cMoveSpeed,false)
	
   end


function MainScene:Reset()
	if self.snake~=nil then
		self.snake:kill()
	end
	
	if self.appleFactory~= nil then
	   self.appleFactory:Reset()
	end   	
 
    self.snake = Snake.new(self)
	self.appleFactory = AppleFactory.new(cBound,self)
	self.stage = "running"
    



end

local function vector2Dir(x, y)
	if math.abs(x) > math.abs(y) then
	if x < 0 then
	return "left"
	else
	   return "right"
	end
   else
	  if y > 0 then
	return "down"

	else
	  return "up"	
end
   end
end

 


function MainScene:ProcessInput()
local function onTouchBegan(touch,event)
	local location = touch:getLocation()
	local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()
    local finalX = location.x - (origin.x + visibleSize.width/2)
    local finalY = location.y - (origin.y + visibleSize.height/2)
    local dir = vector2Dir(finalX, finalY)
    self.snake:SetDir(dir)
end


	local listener = cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)
end


function MainScene:onExit()

end

return MainScene
  