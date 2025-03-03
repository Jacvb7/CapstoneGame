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
	FLEA, GRASSHOPPER, GRUB, HARVESTMEN, HORSESHOE_CRAB, HOUSEFLY, JUMPING_SPIDER, 
	LADYBUG, MAGGOT, MANTIS_SHRIMP, MILLIPEDE, MOSQUITO, PRAYING_MANTIS, SCORPION, 
	SLUG, SNAIL, SPIDER, SPRINGTAIL, STINK_BUG, TERMITE, TICK_LARVA, WASP 
}

enum Shape {ROUND, OVAL, SLENDER, LONG, FLAT}
enum Spots {TRUE, FALSE}
enum Stripes {TRUE, FALSE}
enum Wings {TRUE, FALSE}


# Dictionary of hardcoded bugs for level 1: index = bugID, Type = species, 
# total eyes, total legs, width, height, 
# color, shape, 
# does it have spots, does it have stripes, does it have wings
const tutorial_bug_database = {
	Name.ALBY : [ # bugID = 0
		Type.ANT, 
		2, 
		6, 
		1, 
		2, 
		Color.RED, 
		Shape.OVAL, 
		Spots.FALSE, 
		Stripes.FALSE, 
		Wings.FALSE
		],
	Name.BIX : [ # bugID = 1
		Type.BUTTERFLY, 
		2, 
		6, 
		4, 
		3, 
		Color.BLUE, 
		Shape.FLAT, 
		Spots.FALSE, 
		Stripes.FALSE, 
		Wings.TRUE
		],
	Name.EMBER : [ # bugID = 2
		Type.CATERPILLAR, 
		12, 
		16, 
		1, 
		4, 
		Color.GREEN, 
		Shape.LONG, 
		Spots.TRUE, 
		Stripes.FALSE, 
		Wings.FALSE
		],
	Name.NOX : [ # bugID = 3
		Type.SNAIL, 
		2, 
		0, 
		2, 
		2, 
		Color.ORANGE, 
		Shape.ROUND, 
		Spots.FALSE, 
		Stripes.TRUE, 
		Wings.FALSE
		],
	Name.TAFFY : [ # bugID = 4
		Type.SPIDER, 
		4, 
		8, 
		2, 
		2, 
		Color.PURPLE, 
		Shape.ROUND, 
		Spots.FALSE, 
		Stripes.FALSE, 
		Wings.FALSE
		],
		Name.FIZZGIG : [ # bugID = 5
		Type.SCORPION, 
		6, 
		8, 
		1, 
		3, 
		Color.SADDLE_BROWN, 
		Shape.OVAL, 
		Spots.FALSE, 
		Stripes.TRUE, 
		Wings.FALSE
		],
}
