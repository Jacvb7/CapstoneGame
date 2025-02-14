extends CharacterBody2D  # CharacterBody2D allows physics to be used on Bugs

class_name Bug  # children of Bug will include extends Bug in their heading

# bugID must be UNIQUE! 
# This value should increment globally everytime a new bug is spawed.
var bugId: int = 0
# After level 1 (L1), we can randomly assign names to bugs from this enum list
enum Name { ALBY, BIX, EMBER, NOX, ORBIT, TAFFY, ASHBY, ASTRO, AZUL, BAP, BIM, 
	BISCUIT, BLIP, BO, BOON, BRAMBLE, BUBBLES, CALYX, CEDAR, CLOVER, CRUMPET, 
	DANDY, DAX, DERR, DIL, DOODLEBUG, ECHO, ECLIPSE, ELIX, EVER, EVEREST, 
	EZZIE, FABLE, FIZZ, FIZZGIG, FLARE, FLIT, FOXGLOVE, FROLIC, GOSSAMER, 
	HALO, HAZE, HICCUP, INDIGO, IO, JAMBOREE, JINX, JOLLY, JOVI, JULEP, 
	JUNO, KAIRO, KAZOO, KAZOODLE, KESTREL, KIWI, KODA, KOI, LARK, MAKO, 
	MARLOWE, MARSHMALLOW, MELLOW, MISTRAL, MOCHA, MUSE, NIMBUS, NOVA, OAKLEY, 
	OLLIVANDER, OZZY, PEPPIN, PESTO, PIPPIN, PIXEL, PLUM, POE, POGO, PRISM, 
	RAFFI, RAZZLE, RIFF, RIVER, SABLE, SATURN, SCOOTER, SCRIBBLE, SERAPH, 
	SHERBET, SHIMMER, SILO, SKYE, SNICKERS, SOLSTICE, SPARK, SPROUT, STARLIT, 
	SUNNY, THIMBLE, TINKER, TWIX, UKI, UMI, URSA, WAFFLE, WILLOW, WISP, 
	WOBBLE, XANDER, XAVI, XYLO, YONDER, YUKI, ZAPPA, ZEPHYR, ZESTY, ZIGGY, 
	ZINNIA, AERO, ARLO, CHAI, CHROMA, CIDER, CLIX, COSMO, DIP, DOLIVER, 
	DRIFT, FUZZ, GALAXY, GINGERSNAP, GLITCH, GUMBO, HARLOW, HOBNOB, HUSH, 
	IGGY, INK, LULLABY, LUMEN, LUSH, LYRIC, MAPLE, MOMO, MOONBEAM, NEBULA, 
	QUASAR, QUIBBLE, QUILL, QUIRK, RASCAL, REEF, ROBIN, ROOK, RUNE, SALSA, 
	TIZZY, TOFFEE, TONIC, TWIG, TYCHO, VEX, VIBE, VINNIE, VIREO, WHIMSY, 
	ZIPPY, ZODIAC, ZOOMIE 
}
# Different types of bugs should have preset values/ranges that can be
# assigned to newly spawned bugs
enum Type { 
	ANT, BEE, BEETLE, BUTTERFLY, CATERPILLAR, CENTIPEDE, COCKROACH, DRAGONFLY, 
	FLEA, GRASSHOPPER, GRUB, HARVESTMAN, HORSESHOE_CRAB, HOUSEFLY, JUMPING_SPIDER, 
	LADYBUG, MAGGOT, MANTIS_SHRIMP, MILLIPede, MOSQUITO, PRAYING_MANTIS, SCORPION, 
	SPIDER, SPRINGTAIL, STINK_BUG, TERMITE, TICK_LARVA, WASP 
}
# L1 = level 1, L2 = level 2, L3 = level 3
enum Biome {L1, L2, L3}
enum Shape {ROUND, OVAL, SLENDER, LONG, FLAT}
enum Spots {TRUE, FALSE}
enum Stripes {TRUE, FALSE}
enum Wings {TRUE, FALSE}

# NUMERICAL FEATURES BELOW:
#enum Length {}
#enum Eyes {}
#enum Legs {}

@export var species: Type = Type.ANT
@export var color: Color = Color.WHITE
@export var size: int = 1

# movement speed/velocity of Bug NPCs
@export var speed: float = 100.0  # Movement speed


# Called when the node enters the scene tree for the first time
func _ready():
	print("Bug spawned: " + Type.keys()[species])  # Convert enum to string


# Movement function
func move(direction: Vector2, delta: float):
	velocity = direction * speed  # Set velocity for physics-based movement
	move_and_slide()  # Make the CharacterBody2D move based on its velocity

# Placeholder function for bug behavior (to be overridden)
func interact():
	print(Type.keys()[species] + " reacts to the player.")  # Convert enum to string
