mainScreen = gideros.class(Sprite)

function mainScreen:init()

	local startButton = Button.new(bitmaps.startup, bitmaps.startdown)
	startButton:setPosition((application:getContentWidth()-startButton:getWidth())/2, ((application:getContentHeight()-startButton:getHeight())/2)-(startButton:getHeight()+20))
	self:addChild(startButton)

	startButton:addEventListener("click", 
		function()
			sceneManager:changeScene("gameScreen", 1, transition, easing.outBack) 
		end
	)

local optionsButton = Button.new(bitmaps.optionsup, bitmaps.optionsdown)
	optionsButton:setPosition((application:getContentWidth()-optionsButton:getWidth())/2, ((application:getContentHeight()-optionsButton:getHeight())/2))
	self:addChild(optionsButton)

	optionsButton:addEventListener("click", 
		function()	
			sceneManager:changeScene("optionsScreen", 1, transition, easing.outBack) 
		end
	)
end