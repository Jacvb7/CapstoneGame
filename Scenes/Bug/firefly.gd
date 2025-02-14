extends Bug

func _ready():
	super._ready()  # Calls parent _ready()
	
	species = "Firefly"
	size = 2.0
	color = Color.YELLOW
	speed = 120.0

	print(species + " is glowing!")

func interact():
	print(species + " lights up when approached.")
