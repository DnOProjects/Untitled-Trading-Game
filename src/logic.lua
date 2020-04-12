local logic = {}

function logic.inBounds(point, rect)
	if (point[1] > rect[1] and point[1] < rect[1] + rect[3] and point[2] > rect[2] and point[2] < rect[2] + rect[4]) then
		return true
	end
	return false
end

function logic.round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function logic.inList(var, list)
	for i=1,#list do
		if var == list[i] then
			return true
		end
	end
	return false
end

return logic