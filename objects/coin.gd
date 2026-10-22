extends Area3D

var time := 0.0
var grabbed := false

@onready var mesh: MeshInstance3D = $Mesh
@onready var particles: GPUParticles3D = $Particles

# Collecting coins

func _on_body_entered(body):
	if body.has_method("collect_coin") and !grabbed:
		
		body.collect_coin()
		
		Audio.play("res://sounds/coin.ogg") # Play sound
		
		mesh.hide() # Make invisible
		particles.emitting = false # Stop emitting stars
		
		grabbed = true
		
		Events.resettable_object_used.emit(self)

func reset()-> void:
	grabbed = false
	mesh.show()
	particles.emitting = true
	
# Rotating, animating up and down

func _process(delta):
	
	rotate_y(2 * delta) # Rotation
	position.y += (cos(time * 5) * 1) * delta # Sine movement
	
	time += delta


#func reset()-> void:
	#
