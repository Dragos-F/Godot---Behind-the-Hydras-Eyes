extends Control

@export var chart:LabellessPieChart
@export var colors:Array[Color]
@export var values:Array[float]
@export var buttonDifference:float = 0.05 # var used to increase/decrease buttons

func _process(delta: float) -> void:
	chart.all_entries = [
			LabellessPieChartEntry.new(values[0],colors[0]),
			LabellessPieChartEntry.new(values[1],colors[1]),
			LabellessPieChartEntry.new(values[2],colors[2]),
			LabellessPieChartEntry.new(values[3],colors[3])
	]
	



func _on_savings_pressed() -> void: #DECREASE
	values[2] -=buttonDifference


func _on_lifestyle_pressed() -> void: #DECREASE
	values[3] -=buttonDifference



func _on_savings_increase() -> void: #INCREASE
	values[2] +=buttonDifference
	
func _on_lifestyle_increase() -> void: #INCREASE
	values[3] +=buttonDifference
