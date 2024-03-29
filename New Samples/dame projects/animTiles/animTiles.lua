

groups = DAME.GetGroups()
groupCount = as3.tolua(groups.length) -1

DAME.SetFloatPrecision(3)

tab1 = "\t"
tab2 = "\t\t"
tab3 = "\t\t\t"
tab4 = "\t\t\t\t"

exportOnlyCSV = as3.tolua(VALUE_ExportOnlyCSV)
flixelPackage = as3.tolua(VALUE_FlixelPackage)
as3Dir = as3.tolua(VALUE_AS3Dir)
tileMapClass = "FlxTilemap";
mainLayer = as3.tolua(VALUE_MainLayer)
levelName = as3.tolua(VALUE_LevelName)
GamePackage = as3.tolua(VALUE_GamePackage)
csvDir = as3.tolua(VALUE_CSVDir)
importsText = as3.tolua(VALUE_Imports)

-- This is the file for the map base class
baseFileText = "";

-- Output tilemap data
-- slow to call as3.tolua many times.

function exportMapCSV( mapLayer, layerFileName )
	-- get the raw mapdata. To change format, modify the strings passed in (rowPrefix,rowSuffix,columnPrefix,columnSeparator,columnSuffix)
	
	
	mapText = as3.tolua(DAME.ConvertMapToText(mapLayer,"","\n","",",",""))
	--print("output to "..as3.tolua(VALUE_CSVDir).."/"..layerFileName)
	DAME.WriteFile(csvDir.."/"..layerFileName..".csv", mapText );
end

-- This is the file for the map level class.
fileText = "//Code generated with DAME. http://www.dambots.com\n\n"
fileText = fileText.."package "..GamePackage.."\n"
fileText = fileText.."{\n"
fileText = fileText..tab1.."import flash.utils.Dictionary;\n"
fileText = fileText..tab1.."import "..flixelPackage..".*;\n"
if # importsText > 0 then
	fileText = fileText..tab1.."// Custom imports:\n"..importsText.."\n"
end
fileText = fileText..tab1.."public class Level_"..levelName.." extends BaseLevel\n"
fileText = fileText..tab1.."{\n"
fileText = fileText..tab2.."//Embedded media...\n"

maps = {}
spriteLayers = {}

masterLayerAddText = ""
stageAddText = tab3.."if ( addToStage )\n"
stageAddText = stageAddText..tab3.."{\n"

for groupIndex = 0,groupCount do
	group = groups[groupIndex]
	groupName = as3.tolua(group.name)
	groupName = string.gsub(groupName, " ", "_")
	
	
	layerCount = as3.tolua(group.children.length) - 1
	
	
	
	-- Go through each layer and store some tables for the different layer types.
	for layerIndex = 0,layerCount do
		layer = group.children[layerIndex]
		isMap = as3.tolua(layer.map)~=nil
		layerSimpleName = as3.tolua(layer.name)
		layerSimpleName = string.gsub(layerSimpleName, " ", "_")
		layerName = groupName..layerSimpleName
		if isMap == true then
			basicMapFileName = "mapCSV_"..groupName.."_"..layerSimpleName
			-- Generate the map file.
			exportMapCSV( layer, basicMapFileName )
			mapFileName = basicMapFileName..".csv"
			if layerSimpleName == mainLayer then mainLayer = layerName end
			
			-- This needs to be done here so it maintains the layer visibility ordering.
			if exportOnlyCSV == false then
				table.insert(maps,{layer,layerName})
				-- For maps just generate the Embeds needed at the top of the class.
				fileText = fileText..tab2.."[Embed(source=\""..as3.tolua(DAME.GetRelativePath(as3Dir, csvDir.."/"..mapFileName)).."\", mimeType=\"application/octet-stream\")] public var CSV_"..layerName..":Class;\n"
				fileText = fileText..tab2.."[Embed(source=\""..as3.tolua(DAME.GetRelativePath(as3Dir, csvDir.."/"..basicMapFileName.."_stacks.txt")).."\", mimeType=\"application/octet-stream\")] public var CSV_"..layerName.."_Stacks:Class;\n"
				fileText = fileText..tab2.."[Embed(source=\""..as3.tolua(DAME.GetRelativePath(as3Dir, layer.imageFile)).."\")] public var Img_"..layerName..":Class;\n"
				masterLayerAddText = masterLayerAddText..tab3.."masterLayer.add(layer"..layerName..");\n"
			end
	
		elseif as3.tolua(layer.IsSpriteLayer()) == true then
			if exportOnlyCSV == false then
				table.insert( spriteLayers,{groupName,layer,layerName})
				masterLayerAddText = masterLayerAddText..tab3.."masterLayer.add("..layerName.."Group);\n"
				
				stageAddText = stageAddText..tab4.."addSpritesForLayer"..layerName.."(onAddSpritesCallback);\n"
			end
		end
	end
end


	
if exportOnlyCSV == false then
	stageAddText = stageAddText..tab4.."FlxG.state.add(masterLayer);\n"
	stageAddText = stageAddText..tab3.."}\n\n"

	fileText = fileText.."\n"
	fileText = fileText..tab2.."//Tilemaps\n"
	for i,v in ipairs(maps) do
		fileText = fileText..tab2.."public var layer"..maps[i][2]..":"..tileMapClass..";\n"
	end
	fileText = fileText.."\n"
	
	fileText = fileText..tab2.."//Sprites\n"
	for i,v in ipairs(spriteLayers) do
		fileText = fileText..tab2.."public var "..spriteLayers[i][3].."Group:FlxGroup = new FlxGroup;\n"
	end
	fileText = fileText.."\n"
	
	fileText = fileText..tab2.."private var tileProperties:Array = [];\n\n"
	
	fileText = fileText.."\n"
	fileText = fileText..tab2.."public function Level_"..levelName.."(addToStage:Boolean = true, onAddCallback:Function = null)\n"
	fileText = fileText..tab2.."{\n"
	fileText = fileText..tab3.."// Generate maps.\n"
	
	minx = 9999999
	miny = 9999999
	maxx = -9999999
	maxy = -9999999
	-- Create the tilemaps.
	for i,v in ipairs(maps) do
		layerName = maps[i][2]
		layer = maps[i][1]
		
		x = as3.tolua(layer.map.x)
		y = as3.tolua(layer.map.y)
		xscroll = as3.tolua(layer.xScroll)
		yscroll = as3.tolua(layer.yScroll)
		hasHitsString = ""
		if as3.tolua(layer.HasHits) == true then
			hasHitsString = "true"
		else
			hasHitsString = "false"
		end

		
-- IMPORTANT ---	
-- This is where the animated tile data gets parsed. You can modify this if you like to add extra information.
----------------

		tileAnimsString = "%%if tileanim%%"..tab3.."tileAnims[%tileid%]=new TileAnim(\"%name%\",%fps%,[%tileframes%]);\n%%endif tileanim%%"
		tileData = as3.tolua(DAME.CreateTileDataText( layer, tileAnimsString, "%tileid%%separator%", ","))
		if # tileData > 0 then
			fileText = fileText..tab3.."var tileAnims:Dictionary = new Dictionary;\n"..tileData
			fileText = fileText..tab3.."tileProperties.push( { name:\"%DAME_tiledata%\", value:tileAnims } );\n"
		end
		
		fileText = fileText..tab3.."layer"..layerName.." = addTilemap( CSV_"..layerName..", Img_"..layerName..", "..string.format("%.3f",x)..", "..string.format("%.3f",y)..", "..as3.tolua(layer.map.tileWidth)..", "..as3.tolua(layer.map.tileHeight)..", "..string.format("%.3f",xscroll)..", "..string.format("%.3f",yscroll)..", false, "..as3.tolua(layer.map.collideIndex)..", "..as3.tolua(layer.map.drawIndex)..", properties, onAddCallback );\n"
		
		x = as3.tolua(layer.map.x)
		y = as3.tolua(layer.map.y)
		width = as3.tolua(layer.map.width)
		height = as3.tolua(layer.map.height)
		if x < minx then minx = x end
		if y < miny then miny = y end
		if x + width > maxx then maxx = x + width end
		if y + height > maxy then maxy = y + height end
		
		fileText = fileText..tab3.."layer"..layerName..".x = "..string.format("%.6f",x)..";\n"
		fileText = fileText..tab3.."layer"..layerName..".y = "..string.format("%.6f",y)..";\n"
		fileText = fileText..tab3.."layer"..layerName..".scrollFactor.x = "..string.format("%.6f",as3.tolua(layer.xScroll))..";\n"
		fileText = fileText..tab3.."layer"..layerName..".scrollFactor.y = "..string.format("%.6f",as3.tolua(layer.yScroll))..";\n"
	end
	
	-- Add the layers to the layer list.
	
	fileText = fileText.."\n"..tab3.."//Add layers to the master group in correct order.\n"
	fileText = fileText..masterLayerAddText.."\n\n";
		
	fileText = fileText..stageAddText
	
	fileText = fileText..tab3.."mainLayer = layer"..mainLayer..";\n\n"
	fileText = fileText..tab3.."boundsMinX = "..minx..";\n"
	fileText = fileText..tab3.."boundsMinY = "..miny..";\n"
	fileText = fileText..tab3.."boundsMaxX = "..maxx..";\n"
	fileText = fileText..tab3.."boundsMaxY = "..maxy..";\n\n"
	
	fileText = fileText..tab2.."}\n\n"	-- end constructor

	-- create the sprites.
	
	for i,v in ipairs(spriteLayers) do
		layer = spriteLayers[i][2]
		creationText = tab3.."addSpriteToLayer(%class%, "..spriteLayers[i][3].."Group , %xpos%, %ypos%, %degrees%, %flipped%, "..as3.tolua(layer.xScroll)..", "..as3.tolua(layer.xScroll)..", onAddCallback );//%name%\n" 
		fileText = fileText..tab2.."public function addSpritesForLayer"..spriteLayers[i][3].."(onAddCallback:Function = null):void\n"
		fileText = fileText..tab2.."{\n"
	
		fileText = fileText..as3.tolua(DAME.CreateTextForSprites(layer,creationText,"Avatar"))
		fileText = fileText..tab2.."}\n\n"
	end
	
	fileText = fileText.."\n"

	fileText = fileText..tab1.."}\n"	-- end class
	fileText = fileText.."}\n"		-- end package
		
	-- Save the file!
	
	DAME.WriteFile(as3Dir.."/Level_"..levelName..".as", fileText )
end




return 1
