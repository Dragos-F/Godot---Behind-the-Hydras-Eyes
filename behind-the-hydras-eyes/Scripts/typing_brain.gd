extends Node

@export var On:bool = false
@export var targetControl:Control
@export var controlGroup:Array[Node]
@onready var workingControl:RichTextLabel
@onready var counter1:int = 0 #tracks which text to load next
@onready var counter2:int = 0 #tracks complete texts
@export var charToAdd:float = 5
@export var checker: InputEventKey
@export var ignoredInputs:Array[String]



signal typing_finished #custom signal that the screen-UI-BRAIN thing listens for

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#function that turns typing on, and then sets the control group as all children of the target node
#Due to my shody programming, all children of the control Node need to be RichTextLabels.
func start_new_type(target:Control): 
	controlGroup = target.get_children()
	On = true
		
func _unhandled_input(event: InputEvent) -> void:
#This is the part of unhandled inputs that make the typing happen.
	if (On && event is InputEventKey && event.is_pressed()&& !ignoredInputs.has(event.as_text())):
		print(event.to_string())
		print(ignoredInputs)
		if (workingControl == null): #checks whether there is an active label
			workingControl = controlGroup[counter1]  #assigns one if empty
			print ("Set workingControl to "+controlGroup[counter1].name)
			counter1 +=1 #increase counter for next time
		else: #if already existent
			workingControl.visible_characters += charToAdd #show more chars
			print ("Showed more characters on "+workingControl.name)
			print (workingControl.visible_ratio)
			if (workingControl!=null and workingControl.visible_ratio >= 1): #if all chars are visible
				print ("All Chars are visible!")
				workingControl = null #empty the working control
				counter2 += 1 #increase counter for complete texts
				print (controlGroup.size())
				print (counter2)
				if (counter2 == controlGroup.size()):
					print ("Set TypingOn to False")
					typing_finished.emit()
					counter1 = 0
					counter2 = 0
					On = false
