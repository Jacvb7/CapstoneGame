extends Node2D


@onready var interact_label: Label = $InteractRange/InteractLabel
#var current_interactions := []
var can_interact :bool = false
#@onready var data_entry_table: Control = $CanvasLayer/DataEntryTable
#@onready var button: Button = $CanvasLayer/Button
#@onready var button: Button = $Button
@onready var data_entry_table: Control = $DataEntryTable
#@onready var chickens: Node2D = $Chickens

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass # Replace with function body.
	print("in interacting_component")
	#print(can_interact)

func _process(delta: float) -> void:
	if Input.is_action_pressed("Interact") and can_interact:
		#_on_E_pressed()
		interact()


func _on_E_pressed() -> void:
	if Input.is_action_pressed("Interact") and can_interact:
		print("in input")
		#can_interact = false			
		#await current_interactions[0].interact.call()
		interact()
		

func interact() -> void:
	print("interacting")
	data_entry_table.visible = true
	#button.visible = true
	interact_label.visible = true


	#if current_interactions and can_interact:
		##current_interactions.sort_custom(_sort_by_nearest)
		#if current_interactions[0].is_interactable:
			#interact_label.text = "Press 'E'" #current_interactions[0].interact_name
			#interact_label.show()
	#else:
		#interact_label.hide()
		
		
		
#func _sort_by_nearest(area1, area2):
	#var area1_dist = global_position.distance_to(area1.global_position)
	#var area2_dist = global_position.distance_to(area2.global_position)
	#return area1_dist < area2_dist


func _on_interact_range_area_entered(area: Area2D) -> void:
	#current_interactions.push_back(area)
	#interact_label.show()
	interact_label.visible = true
	can_interact = true
	#print("entered")


func _on_interact_range_area_exited(area: Area2D) -> void:
	interact_label.visible = false
	can_interact = false


#func _on_button_button_down() -> void:
	#data_entry_table.visible = false


#func _on_button_pressed() -> void:
	#data_entry_table.visible = false
	#button.visible = false
