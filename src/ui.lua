local ui = {}

-- Requires
local logic = require "src/logic"

-- Loads
function ui.load()
	volume = 100

	currentPage = 1
	buttons = {}
	sliders = {}
	prints = {}
	initUI()
	canClick = true
	canSlide = true
end

function initUI()
	for i = 1, 2 do
		addPrint(i, "Tropical Trader", 0, 50, 1920, 100, 1, 1, 1, 1, "center")
	end

	addButton(1, "inGame", "Play", 200, 250, 500, 140, 70, 0.1, 0.1, 0.1, 0.8)
	addButton(1, 2, "Options", 200, 450, 500, 140, 70, 0.1, 0.1, 0.1, 0.8)
	addButton(1, "exit", "Exit", 200, 650, 500, 140, 70, 0.1, 0.1, 0.1, 0.8)

	addSlider(2, "Master", 200, 250, 500, 140, 70, 0.1, 0.1, 0.1, 0.8, volume, 6, 11)
	addButton(2, 1, "Back", 200, 650, 500, 140, 70, 0.1, 0.1, 0.1, 0.8)
end

function addButton(page, pageToGo, text, x, y, width, height, textSize, r, g, b, a)
	buttons[#buttons+1] = {page = page, pageToGo = pageToGo, text = text, x = x, y = y, width = width, height = height, textSize = textSize, color = {r, g, b, a}, mouseOver = false}
end

function addSlider(page, text, x, y, width, height, textSize, r, g, b, a, value, sliderWidth, sliderHeight)
	-- sliderWidth must be even as it is halved
	-- sliderHeight must be odd as the 3 from the slider line is odd
	sliders[#sliders+1] = {page = page, text = text, x = x, y = y, width = width, height = height, textSize = textSize, color = {r, g, b, a}, value = value, sliderWidth = sliderWidth, sliderHeight = sliderHeight}
end

function addPrint(page, text, x, y, limit, textSize, r, g, b, a, align)
	prints[#prints+1] = {page = page, text = text, x = x, y = y, limit = limit, textSize = textSize, color = {r, g, b, a}, align = align}
end

-- Updates
function ui.update()
	updateButtons()
	updateSliders()
	if love.mouse.isDown(1) == true then
		canClick = false
	else
		canClick = true
		canSlide = true
	end
end

function updateButtons()
	for i, button in pairs(buttons) do
		if (button.page == currentPage) then
			button.mouseOver = logic.inBounds({mouseX, mouseY}, {button.x, button.y, button.width, button.height})
			if (button.mouseOver and love.mouse.isDown(1) and canClick == true) then
				if button.pageToGo == "exit" then
					love.event.quit()
				else
					currentPage = button.pageToGo
				end
				canSlide = false
			end
		end
	end
end

function updateSliders()
	for i, slider in pairs(sliders) do
		if (slider.page == currentPage) then
			if love.mouse.isDown(1) == true then
				if canSlide == true then
					if logic.inBounds({mouseX, mouseY}, {slider.x, slider.y+slider.height-(((slider.sliderHeight-3)/2)+40), slider.width, slider.sliderHeight + 50}) then
						slider.value = logic.round((mouseX-(slider.x+20))/((slider.width-40)/100))
						if slider.value < 0 then
							slider.value = 0
						elseif slider.value > 100 then
							slider.value = 100
						end
					end
				end
			end
		end
	end
end

-- Drawing
function ui.draw()
	drawButtons()	
	drawSliders()
	drawPrints()
end

function drawButtons()
	for i, button in pairs(buttons) do
	    if (button.page == currentPage) then
			if (button.mouseOver == false) then
				love.graphics.setColor(button.color)
			else
				love.graphics.setColor(button.color[1] - button.color[1]/4, button.color[2] - button.color[2]/4, button.color[3] - button.color[3]/4, button.color[4] - button.color[4]/4)
			end
			love.graphics.rectangle("fill", button.x, button.y, button.width, button.height)
			love.graphics.setColor(1, 1, 1)
			love.graphics.setFont(love.graphics.newFont(button.textSize))
			love.graphics.printf(button.text, button.x, button.y + (button.height/2) - (button.textSize/1.8), button.width, "center")
		end
	end
end

function drawSliders()
	for i, slider in pairs(sliders) do
		if (slider.page == currentPage) then
		    love.graphics.setColor(slider.color)
		    love.graphics.rectangle("fill", slider.x, slider.y, slider.width, slider.height)
		    love.graphics.setColor(1, 1, 1)
		    love.graphics.setFont(love.graphics.newFont(slider.textSize))
		    love.graphics.printf(slider.text.." : "..slider.value, slider.x, slider.y + slider.height/2 - slider.textSize/1.5, slider.width, "center")
			love.graphics.rectangle("line", slider.x+20, slider.y+slider.height-20, slider.width-40, 3)
			love.graphics.rectangle("fill", slider.x+20+((slider.width-40)/100)*slider.value-slider.sliderWidth/2, slider.y+slider.height-(((slider.sliderHeight-3)/2)+20), slider.sliderWidth, slider.sliderHeight)
		end
	end
end

function drawPrints()
	for i, printText in pairs(prints) do
		if (printText.page == currentPage) then
			love.graphics.setFont(love.graphics.newFont(printText.textSize))
			love.graphics.setColor(printText.color)
			love.graphics.printf(printText.text, printText.x, printText.y, printText.limit, printText.align)
		end
	end
end

return ui