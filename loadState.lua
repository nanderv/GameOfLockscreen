local  image =  love.graphics.newImage( "screenshot.png" )
local w = image:getWidth()
local h = image:getHeight()
local ImageData = image:getData()
local av = 0

for i=0, (w)-1 do
    for j=0, (h)-1 do
    	if j + offsetY < 2160 then
    	
	        local r,g,b = ImageData:getPixel(i,j+offsetY)
	        r=255-r
	        g=255-g
	        b=255-b
	        av = av + math.sqrt( 0.299*r*r + 0.7*g*g + 0.114*b*b )/(w*h)

    end
    end
end

for q=1, w/10-1 do
	for s=1, h/10-1 do
		local i = q*10
		local j = s*10
    	if j + offsetY < 2160 then

			local r,g,b = ImageData:getPixel(i,j+offsetY)
			r=255-r
			g=255-g
			b=255-b
			if math.sqrt( 0.299*r*r + 0.7*g*g + 0.114*b*b )>av then
				addPoint(q,s,state)

			end
	end
 	end
end
