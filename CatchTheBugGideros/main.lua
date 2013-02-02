stage:setOrientation(Stage.LANDSCAPE_BOTTOM)

----------------Saved Data--------------
sets = dataSaver.loadValue("sets")

if (not sets) then
	sets = {}
	sets.sound = {}
	sets.sound.effects = true
	sets.sound.music = true
	dataSaver.saveValue("sets", sets)
end
----------------Saved Data--------------

----------------Sound & Music--------------
sound = {}
sound.music = {}
sound.effects = {}

sound.theme = Sound.new("res/sound/theme.mp3")
sound.hit = Sound.new("res/sound/hit.mp3")
sound.miss = Sound.new("res/sound/miss.mp3")
sound.win = Sound.new("res/sound/win.mp3")
sound.lose = Sound.new("res/sound/lose.mp3")

sound.play = function(snd)
	if sets.sound.effects and sound[snd] then
		sound[snd]:play()
	end
end

sound.music.on = function()
	if not sound.music.channel then
		sound.music.channel = sound.theme:play(0, 1000000)
		sets.sound.music = true
		dataSaver.saveValue("sets", sets)
	end
end

sound.music.off = function()
	if sound.music.channel then
		sound.music.channel:stop()
		sound.music.channel = nil
		sets.sound.music = false
		dataSaver.saveValue("sets", sets)
	end
end

if sets.sound.music then
	sound.music.channel = sound.theme:play(0, 1000000)
end

if sets.sound.effects then
	sound.effects.channel = sound.hit:play(0, 1)
end

sound.effects.on = function()
	sets.sound.effects = true
	sound.effects.channel = sound.hit:play(0, 1)
	dataSaver.saveValue("sets", sets)
end

sound.effects.off = function()
	sets.sound.effects = false
	dataSaver.saveValue("sets", sets)
end
----------------Sound & Music--------------

----------------Bitmaps--------------
bitmaps = {}
bitmaps.startup = Bitmap.new(Texture.new("res/images/start_up.png"))
bitmaps.startdown = Bitmap.new(Texture.new("res/images/start_down.png"))
bitmaps.optionsup = Bitmap.new(Texture.new("res/images/options_up.png"))
bitmaps.optionsdown = Bitmap.new(Texture.new("res/images/options_down.png"))
----------------Bitmaps--------------

----------------Textures--------------
textures = {}
textures.bug = Texture.new("res/images/bug.png")
----------------Textures--------------

----------------Menu Buttons--------------
menuButton = function(image1, image2, container, current, all)
	local newButton = Button.new(Bitmap.new(Texture.new(image1)), Bitmap.new(Texture.new(image2)))
	local startHeight = (current-1)*(container:getHeight())/all + (((container:getHeight())/all)-newButton:getHeight())/2 + application:getContentHeight()/16
	newButton:setPosition((application:getContentWidth()-newButton:getWidth())/2, startHeight)
	return newButton;
end

menuButtons = {}
menuButtons.musicon = function(menu) return menuButton("res/images/musicon_up.png", "res/images/musicon_down.png", menu, 1, 3) end
menuButtons.musicoff = function(menu) return menuButton("res/images/musicoff_up.png", "res/images/musicoff_down.png", menu, 1, 3) end
menuButtons.soundson = function(menu) return menuButton("res/images/soundson_up.png", "res/images/soundson_down.png", menu, 2, 3) end
menuButtons.soundsoff = function(menu) return menuButton("res/images/soundsoff_up.png", "res/images/soundsoff_down.png", menu, 2, 3) end
menuButtons.back = function(menu) return menuButton("res/images/back_up.png", "res/images/back_down.png", menu, 3, 3) end
----------------Menu Buttons--------------

----------------Scene Manager--------------
sceneManager = SceneManager.new({
	["mainScreen"] = mainScreen,
	["optionsScreen"] = optionsScreen,
	["gameScreen"] = gameScreen
})

transition = SceneManager.flipWithFade
stage:addChild(sceneManager)
sceneManager:changeScene("mainScreen", 1, transition, easing.outBack)
----------------Scene Manager--------------