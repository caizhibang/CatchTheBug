optionsScreen = gideros.class(Sprite)

function optionsScreen:init()
	local menu = Shape.new()
	menu:setFillStyle(Shape.SOLID, 0xffffff, 0.5)   
	menu:beginPath(Shape.NON_ZERO)
	menu:moveTo(application:getContentWidth()/5, application:getContentHeight()/16)
	menu:lineTo((application:getContentWidth()/5)*4, application:getContentHeight()/16)
	menu:lineTo((application:getContentWidth()/5)*4, application:getContentHeight()-(application:getContentHeight()/16))
	menu:lineTo(application:getContentWidth()/5, application:getContentHeight()-(application:getContentHeight()/16))
	menu:lineTo(application:getContentWidth()/5, application:getContentHeight()/16)
	menu:endPath()
	self:addChild(menu)

	optionsScreen:addMusicButton(menu)
	optionsScreen:addSoundsButton(menu)
	optionsScreen:addBackButton(menu)
end

function optionsScreen:addMusicButton(menu)

	local musicOnButton = menuButtons.musicon(menu)
	local musicOffButton = menuButtons.musicoff(menu)
	
	musicOnButton:addEventListener("click", 
		function()
			menu:removeChild(musicOnButton)
			menu:addChild(musicOffButton)
			sound.music.off()
		end
	)
	musicOffButton:addEventListener("click", 
		function()
			menu:removeChild(musicOffButton)
			menu:addChild(musicOnButton)
			sound.music.on()
		end
	)
	
	if sets.sound.music then
		menu:addChild(musicOnButton)
	else
		menu:addChild(musicOffButton)
	end
end

function optionsScreen:addSoundsButton(menu)

	local soundsOnButton = menuButtons.soundson(menu)
	local soundsOffButton = menuButtons.soundsoff(menu)
	
	soundsOnButton:addEventListener("click", 
		function()
			menu:removeChild(soundsOnButton)
			menu:addChild(soundsOffButton)
			sound.effects.off()
		end
	)
	
	soundsOffButton:addEventListener("click", 
		function()
			menu:removeChild(soundsOffButton)
			menu:addChild(soundsOnButton)
			sound.effects.on()
		end
	)
	
	if sets.sound.effects then
		menu:addChild(soundsOnButton)
	else
		menu:addChild(soundsOffButton)
	end
end

function optionsScreen:addBackButton(menu)

	local backButton = menuButtons.back(menu)
	menu:addChild(backButton)
	backButton:addEventListener("click", 
		function()	
			sceneManager:changeScene("mainScreen", 1, transition, easing.outBack) 
		end
	)	
end


