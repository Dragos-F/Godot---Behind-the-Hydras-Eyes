extends Control
class_name Computer
@export var MainEmailBody:RichTextLabel
@onready var dave:Dave = %Dave
@export var replyTarget:Control #needed since I've decided to make the typing system dependent on a control node
@export var Sender:RichTextLabel
@export var ToBox:RichTextLabel
@onready var send: Button = $MainEmail/Send
@onready var reply: Button = $MainEmail/Reply
@onready var choiceEmail: bool = false
@onready var selectedTexts:Array[String]
@onready var typing_brain: Node = %TypingBrain
@onready var hint_text: RichTextLabel = $MainEmail/Hint
@onready var summaries_container: VBoxContainer = $EmailList/SummariesContainer
@onready var inbox_buttons:Array[Button]
@onready var selectedPreview:Node
@export var emailsProgressionQuota:int
@export var emailsDone:int
@export var EmailList:Array[Panel]
@export var Budget:Panel
@export var BrowserThing:Panel
@export var emailNotif:Node2D
@export var keyboardTarget:Node2D
@export var info:BudgetData


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	send.visible = false
	send.disabled = true
	
	reply.visible = false
	reply.disabled = true
	info.startingSavings = PermanentGlobal.Savings
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if emailsDone == emailsProgressionQuota:
		emailNotif.visible = false
	
func open_email(text:Array[String],boss:bool,choice:bool)->void:
	choiceEmail = false
	selectedTexts = text.duplicate(true)
	Sender.text = text[0]
	ToBox.text = text[1]
	MainEmailBody.text ="[b]"+text[2]+"[/b]\n\n" + text[3]
	MainEmailBody.visible_ratio = 0.9
	MainEmailBody.visible_ratio = 1
	choiceEmail = choice
	if (!boss):
		reply.visible = true
		reply.disabled = false
	else:
		reply.visible = false
		reply.disabled = true

		
	

func _on_reply_pressed() -> void:
	reply.visible = false #set the reply button false
	reply.disabled = true
	
	if !choiceEmail:
		Sender.text = selectedTexts[2]
		ToBox.text = selectedTexts[0]
		MainEmailBody.visible_characters = 0
		hint_text.visible = true
		MainEmailBody.text = selectedTexts[4]
		typing_brain.start_new_type(replyTarget)
		#code to get and disable all buttons
		inbox_buttons.assign(summaries_container.find_children("Button"))
		if (inbox_buttons!=null):
			for i in inbox_buttons:
				i.disabled = true
				
	elif choiceEmail:
		
		Dialogic.Styles.load_style("Bubble Style Test")
		var layout = Dialogic.start("EmailChoice")
		layout.register_character ("res://Dialogue stuffs/Dialogic/Characters/Office/Keyboard.dch",keyboardTarget)
		await Dialogic.timeline_ended
		dave.move_time = false
		if Dialogic.VAR.EmailChoice == 1:
			Sender.text = selectedTexts[2]
			ToBox.text = selectedTexts[0]
			MainEmailBody.visible_characters = 0
			hint_text.visible = true
			MainEmailBody.text = selectedTexts[4]
			typing_brain.start_new_type(replyTarget)
			#code to get and disable all buttons
			inbox_buttons.assign(summaries_container.find_children("Button"))
			if (inbox_buttons!=null):
				for i in inbox_buttons:
					i.disabled = true
		elif Dialogic.VAR.EmailChoice == 2:
			Sender.text = selectedTexts[2]
			ToBox.text = selectedTexts[0]
			MainEmailBody.visible_characters = 0
			hint_text.visible = true
			MainEmailBody.text = selectedTexts[5]
			typing_brain.start_new_type(replyTarget)
			#code to get and disable all buttons
			inbox_buttons.assign(summaries_container.find_children("Button"))
			if (inbox_buttons!=null):
				for i in inbox_buttons:
					i.disabled = true
		PermanentGlobal.new_choice(selectedTexts[2],Dialogic.VAR.EmailChoice) # this look wrong, but selText[2] is indeed right

func _on_typing_brain_typing_finished() -> void: #custom signal from the typing brain
	hint_text.visible = false
	send.visible = true
	send.disabled = false
	

func _on_send_pressed() -> void:
	selectedPreview.queue_free()
	MainEmailBody.text= ""
	Sender.text=""
	ToBox.text= ""
	selectedTexts.clear()
	send.visible = false
	send.disabled = true
	if (inbox_buttons!=null):
		for i in inbox_buttons:
			i.disabled = false
	inbox_buttons.clear()
	emailsDone+=1
	MainEmailBody.visible_ratio = 0.9
	MainEmailBody.visible_ratio = 1
	


func _on_emails_pressed() -> void:
	if Budget != null:
		Budget.visible = false
	if BrowserThing != null:
		BrowserThing.visible = false
	for i in EmailList:
		i.visible = true

func _on_budget_pressed() -> void:
	Budget.visible = true
	if BrowserThing!=null:
		BrowserThing.visible = false
	for i in EmailList:
		i.visible = false


func _on_job_thing_pressed() -> void:
	BrowserThing.visible = true
	Budget.visible = false
	for i in EmailList:
		i.visible = false


func _on_save_button_pressed() -> void:
	PermanentGlobal.Savings = info.savingsContribution+info.startingSavings
	PermanentGlobal.Lifestyle = info.lifestyleTypes[info.lifestyleChoice]
	SaveLoad._save()

func _on_internet_pressed() -> void:
	if Budget.visible:
		Budget.visible = false
	for i in EmailList:
		i.visible = false
	BrowserThing.visible = true
