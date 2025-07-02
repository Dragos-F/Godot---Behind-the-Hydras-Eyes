extends Control

@export var chart:LabellessPieChart
@export var colors:Array[Color]
@export var values:Array[float]
@export var buttonDifference:float = 0.02 # var used to increase/decrease buttons
@export var savingsText:Label 
@export var totalSalary:float
@export var startingSavings:float


func _ready() -> void:
	savingsText.text = str(startingSavings)
	
func _process(delta: float) -> void:
	chart.all_entries = [
			LabellessPieChartEntry.new(values[0],colors[0]),
			LabellessPieChartEntry.new(values[1],colors[1]),
			LabellessPieChartEntry.new(values[2],colors[2]),
			LabellessPieChartEntry.new(values[3],colors[3])
	]
	savingsText.text = "£"+str(startingSavings+totalSalary*values[2])
	



func _on_savings_pressed() -> void: #DECREASE
	if values[2]> 0:
		values[2] -=buttonDifference
		values[3] +=buttonDifference
func _on_lifestyle_pressed() -> void: #DECREASE
	if values[3] > 0.05:
		values[3] -=buttonDifference
		values[2] +=buttonDifference
func _on_savings_increase() -> void: #INCREASE
	if values[3] > 0.05:
		values[2] +=buttonDifference
		values[3] -= buttonDifference
func _on_lifestyle_increase() -> void: #INCREASE
	if values[2] > 0.05:
		values[3] +=buttonDifference
		values[2] -=buttonDifference


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		values[1] += buttonDifference
		values[2] -= buttonDifference/2
		values[3] -= buttonDifference/2
	else:
		values[1] -= buttonDifference
		values[2] += buttonDifference/2
		values[3] += buttonDifference/2
		
