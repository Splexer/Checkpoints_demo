extends Node3D

var start_position: Vector3

var falling := false
var fall_velocity := 0.0

@onready var static_collider: CollisionShape3D = $"platform-falling2#StaticBody3D/platform-falling2_StaticBody3D#CollisionShape3D"

func _ready() -> void:
	start_position = global_position

func _physics_process(delta):
	scale = scale.lerp(Vector3(1, 1, 1), delta * 10) # Animate scale
	
	if falling:
		fall_velocity += 15.0 * delta
		position.y -= fall_velocity * delta
		if position.y < -10:
			hide()
			falling = false
			static_collider.set_deferred("disabled", true)
			
	


func reset()-> void:
	set_deferred("global_position", start_position) 
	static_collider.set_deferred("disabled", false)
	falling = false
	fall_velocity = 0.0
	show()

func _on_body_entered(_body):
	if !falling:
		Events.resettable_object_used.emit(self)
		Audio.play("res://sounds/fall.ogg") # Play sound
		scale = Vector3(1.25, 1, 1.25) # Animate scale
		
	falling = true
