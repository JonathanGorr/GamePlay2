-- Display the settings for the exporter.

DAME.AddHtmlTextLabel("This demos exporting of an isometric tile map along with aligned sprites.")
DAME.AddBrowsePath("AS3 dir:","AS3Dir",false, "Where you place the Actionscript files.")
DAME.AddBrowsePath("CSV dir:","CSVDir",false)

DAME.AddTextInput("Level Name", "", "LevelName", true, "The name you wish to call this level." )
DAME.AddTextInput("Main Layer", "", "MainLayer", true, "Name of the tilemap layer to use as the main layer for hits." )
DAME.AddTextInput("Game package", "com", "GamePackage", true, "package for your game's .as files." )
DAME.AddTextInput("Flixel package", "org.flixel", "FlixelPackage", true, "package use for flixel .as files." )
DAME.AddMultiLineTextInput("Imports", "", "Imports", 50, true, "Imports for each level class file go here" )

DAME.AddCheckbox("Export only CSV","ExportOnlyCSV",false,"If ticked then the script will only export the map CSV files and nothing else.");

return 1
