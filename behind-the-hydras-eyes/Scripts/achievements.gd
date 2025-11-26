extends Node

var achievements: Dictionary[String, bool] = {
	"achieve1": false,
	"achieve2": false,
	"achieve3": false
	}
	
	
func _ready() -> void:
	initialize_steam()

func initialize_steam() -> void:
	var initialize_response: Dictionary = Steam.steamInitEx()
	print("Did Steam initialize?: %s" % initialize_response)

	if initialize_response['status'] > Steam.STEAM_API_INIT_RESULT_OK:
		print("Failed to initialize Steam: %s" % initialize_response['status'])
		return

	load_steam_achievements()
	
# Process achievements
# Process achievements
func load_steam_achievements() -> void:
	for this_achievement in achievements.keys():
		var steam_achievement: Dictionary = Steam.getAchievement(this_achievement)
		# Does the achievement actually exist in the Steamworks back-end?
		if not steam_achievement['ret']:
			print("Steam does not have this achievement, defaulting to local value: %s" % achievements[this_achievement])
			continue
		if achievements[this_achievement] == steam_achievement['achieved']:
			print("Steam achievements match local file, skipping: %s" % this_achievement)
			continue
			set_achievement(this_achievement)

		print("Steam achievements loaded")
		
func set_achievement(this_achievement: String) -> void:
	if not achievements.has(this_achievement):
		print("This achievement does not exist locally: %s" % this_achievement)
		return
	achievements[this_achievement] = true

	if not Steam.setAchievement(this_achievement):
		print("Failed to set achievement: %s" % this_achievement)
		return

	print("Set acheivement: %s" % this_achievement)
	store_steam_data()


func store_steam_data() -> void:
	if not Steam.storeStats():
		print("Failed to store data on Steam, should be stored locally")
		return
	print("Data successfully sent to Steam")
