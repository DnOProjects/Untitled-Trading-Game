local assets = {}

function assets.get(assetType, name, fontSize)
	local asset = assets[name]
	if not asset then --Get new asset
	    if assetType == 'image' then asset = love.graphics.newImage("assets/images/"..name..".jpg") end
	  	if assetType == 'sound' then asset = love.audio.newSource("assets/sounds/"..name..".wav", "static") end
	  	if assetType == 'font' then asset = love.graphics.newFont("assets/fonts/"..name..".ttf", fontSize) end
	    assets[name] = asset
	end
	return asset
end

return assets