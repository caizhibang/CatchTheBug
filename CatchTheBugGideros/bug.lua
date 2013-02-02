Bug = Core.class(Sprite)

local isInactive = false

function Bug:init()
	self:addChild(Bitmap.new(textures.bug))
	
	self:setPosition(540, math.random(260))

	self.speedy = math.random(-500, 500) / 1000
	self.speedx = math.random(2000, 4000) / 1000

	self:addEventListener(Event.ENTER_FRAME, onEnterFrame, self)
	self:addEventListener(Event.MOUSE_DOWN, onMouseDown, self)
	
	gameScreen:addToTable(Bug)
end

function Bug:setInactive()
	isInactive = true
end

function onEnterFrame(self, event)
	
	if (isInactive) then
		self:removeEventListener(Event.ENTER_FRAME, onEnterFrame, self)
		self:removeEventListener(Event.MOUSE_DOWN, onMouseDown, self)
	end
	
	local x,y = self:getPosition()
	local xOld, yOld = x, y
	
	x = x - self.speedx
	y = y + self.speedy
		
	if x < -100 then 
		self.speedy = math.random(-500, 500) / 1000
		self.speedx = math.random(2000, 4000) / 1000
		x = 540
		y = math.random(260)
		
		if not (xOld == -99999 and yOld == -99999) then
			gameScreen.decreaseLive()
			sound.play("miss")
		end
	end

	self:setPosition(x, y)
end

function onMouseDown(self, event)
	if self:hitTestPoint(event.x, event.y) then
		self:setPosition(-99999, -99999)
		sound.play("hit")
		event:stopPropagation()
	end
end
