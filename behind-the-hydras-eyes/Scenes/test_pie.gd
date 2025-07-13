extends Control

@export var chart:LabellessPieChart
@export var colors:Array[Color]
@export var values:Array[float]
@export var buttonDifference:float = 0.02 # var used to increase/decrease buttons
@export var additionalsDifference:float = 0.05
@export var savingsText:Label 
@export var totalSalary:float
@export var startingSavings:float


func _ready() -> void:
	savingsText.text = str(startingSavings)
	
func _process(delta: float) -> void:
	chart.all_entries = [
			LabellessPieChartEntry.new(values[0],colors[0]), #RENt
			LabellessPieChartEntry.new(values[1],colors[1]), #BILLS
			LabellessPieChartEntry.new(values[2],colors[2]), #SAVINGS
			LabellessPieChartEntry.new(values[3],colors[3]) #LIFESTYLE
	]
	savingsText.text = "£"+str(startingSavings+totalSalary*values[2])
	
	



func _on_savings_pressed() -> void: #DECREASE
	if values[2]> 0:
		values[2] -=buttonDifference
		values[3] +=buttonDifference
func _on_lifestyle_pressed() -> void: #DECREASE
	if values[3] > 0.2:
		values[3] -=buttonDifference
		values[2] +=buttonDifference
func _on_savings_increase() -> void: #INCREASE
	if values[3] > 0.2:
		values[2] +=buttonDifference
		values[3] -= buttonDifference
func _on_lifestyle_increase() -> void: #INCREASE
	if values[2] > 0.05:
		values[3] +=buttonDifference
		values[2] -=buttonDifference
		
func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		values[1] += additionalsDifference
		if (values[2]>=0):
			values[2] -= additionalsDifference
		else:
			values[3] -= additionalsDifference

	else:
		values[1] -= additionalsDifference
		values[2] += additionalsDifference


func _on_save_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		var buttons = get_tree().get_nodes_in_group("Buttons")
		for i in buttons:
			if i is Button:
				i.disabled = true
	if toggled_on == false:
		var buttons = get_tree().get_nodes_in_group("Buttons")
		for i in buttons:
			if i is Button:
				i.disabled = false
	
