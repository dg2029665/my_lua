local AppleFactory = class("AppleFactory")
function AppleFactory:ctor(bound,node)

 self.Bound = bound
 self.node = node
 math.randomseed(os.time())
 self:Generate()
end


local function getPos(bound)
	return math.random(-bound,bound)
end


function AppleFactory:Generate()
	if self.appleSprite ~= nil then
       self.node:removeChild(self.appleSprite) 
    end

	local sp = cc.Sprite:create("apple.png")
    local genBoundLimit = self.Bound-1

	local x,y = getPos(genBoundLimit), getPos(genBoundLimit)
    local finalX,finalY = Grid2Pos(x,y)

	sp:setPosition(finalX,finalY)
	self.node:addChild(sp)



	self.appleX = x
	self.appleY = y

    self.appleSprite = sp

end

function AppleFactory:CheckCollide(x,y)
	if x == self.appleX and self.appleY then
    return true
end
    return false

end


function AppleFactory:Reset()
	self.node:removeChild(self.appleSprite)

end








return AppleFactory
