extends Node

var username = ""
var has_scanner: bool = false
var isByteVisable: bool = false
var isNPCVisable: bool = false
var finish_mini_game: bool = false

# Taken from enable_variables
# used in state machine to enable and disable dragging on click
var dragging_enabled = false  # Set to false during the tutorial

var enable_click = false # stop tutorial state machine from advancing on click until player enters the scene

signal byte_show
signal byte_hide

func _ready():
	randomize() # Ensure different results each run
	var name_keys = Name.keys()
	username = name_keys[randi() % name_keys.size()]
	print("Assigned username:", username)
	
func hideByte() -> void:
	#print("entered")
	byte_hide.emit()


func showByte() -> void:
	#print("exited")
	byte_show.emit()

enum Name { ORBIT, ASHBY, ASTRO, AZUL, BAP, BIM, 
	BISCUIT, BLIP, BO, BOON, BRAMBLE, BUBBLES, CALYX, CEDAR, CLOVER, CRUMPET, 
	DANDY, DAX, DERR, DIL, DOODLEBUG, ECHO, ECLIPSE, ELIX, EVER, EVEREST, 
	EZZIE, FABLE, FIZZ, FLARE, FLIT, FOXGLOVE, FROLIC, GOSSAMER, 
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
