extends Node


const save_location = "user://BtHESaveFile.tres"

var SaveFileData:SaveDataResource = SaveDataResource.new()


func _save():
	SaveFileData.email_choices = PermanentGlobal.email_choices.duplicate(true)
	SaveFileData.location_choice = PermanentGlobal.LocationChoice
	SaveFileData.Savings = PermanentGlobal.Savings
	SaveFileData.Lifestyle = PermanentGlobal.Lifestyle
	SaveFileData.deleted = PermanentGlobal.deleted
	SaveFileData.watercoolers = PermanentGlobal.watercoolers
	ResourceSaver.save(SaveFileData,save_location)

func _load():
	if FileAccess.file_exists(save_location):
		SaveFileData = ResourceLoader.load(save_location).duplicate(true)
	
