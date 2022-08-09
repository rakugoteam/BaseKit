# this file must be manually copied to kit repo
extends "res://addons/gd-plug/plug.gd"


func _plugging():
	# Declare your plugins in here with plug(src, args)
	# By default, only "addons/" directory will be installed
	plug("rakugoteam/Emojis-For-Godot", {"include": ["addons", ".import/"]})
	plug("rakugoteam/Godot-Material-Icons", {"include": ["addons", ".import/"]})
	plug("rakugoteam/AdvancedText")
	plug("rakugoteam/Rakugo", {"include": ["addons/rakugo", ".import/"]})

	# this 2 instruction must be changed to kit needs
	# this will update base-kit it self
	plug("rakugoteam/BaseKit", {
		"include": ["addons/kit", "addons/gd-plug"],
		"exclude": ["addons/kit/plugin.cfg"],
		"on_update": "post_kit_update"
	})
	
	## comment-out if of you don't want to update kit itself
	# plug("your/kit-repo", {"include": ["addons", "plug.gd"]})

func post_kit_update(plugin : Dictionary):
	directory_copy_recursively("addons/kit/", "addons/your-kit")
    # this will update your kit
    