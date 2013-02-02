gameScreen = gideros.class(Sprite)

bugTable = {}
timeStart = nil

lives = 3
timeLeft = 90

local textLives = TextField.new(nil, nil)
textLives:setPosition(0, 8)
stage:addChild(textLives)

local textTimer = TextField.new(nil, nil)
textTimer:setPosition(0, 20)
stage:addChild(textTimer)
	
function gameScreen:init()

	gameScreen:setLivesText()
	gameScreen:setTimerText()
	
	gameScreen:addBug()
	
	timeStart = os.clock()
	
	timer = Timer.new(1000)
	timer:addEventListener(Event.TIMER, onTimer, timer)
	timer:start()
	
	timerLives = Timer.new(100)
	timerLives:addEventListener(Event.TIMER, onTimerLives, timerLives)
	timerLives:start()
end

function gameScreen:addToTable(bug)
	table.insert(bugTable, 1, bug)
end

function gameScreen:decreaseLive()
	lives = lives - 1
end

function gameScreen:setLivesText()
	textLives:setText("Lives : " .. lives)
end

function gameScreen:setTimerText()
	textTimer:setText("Time : " .. timeLeft)
end

function gameScreen:stopLevel(result)
	for key, value in pairs(bugTable) do
		value:setInactive()
	end
	
	timer:removeEventListener(Event.TIMER, onTimer, timer)
	timerLives:removeEventListener(Event.TIMER, onTimerLives, timerLives)
	
	if (result == "lost") then
		sound.play("lose")
	else
		sound.play("win")	
	end
end

function gameScreen:addBug()
	local bug = Bug.new()
	stage:addChild(bug)
end

function onTimerLives(timer)
	if (lives == 0) then
		gameScreen:stopLevel("lost")
	end
	
	gameScreen:setLivesText()
end

function onTimer(timer)
	if (timeLeft == 0) then
		gameScreen:stopLevel("won")
	else
		timeLeft = math.abs(math.ceil(timeLeft - (os.clock() - timeStart)))
		timeStart = os.clock()
		
		if (timeLeft % 5 == 0) then
			gameScreen:addBug()
		end
	end
	
	gameScreen:setTimerText()
end
