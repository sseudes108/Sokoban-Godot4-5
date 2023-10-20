extends Node

const MUSIC1 = "1"
const MUSIC2 = "2"
const MUSIC3 = "3"
const MUSIC4 = "4"
const MUSIC5 = "5"
const MUSIC6 = "6"
const MUSIC7 = "7"
const MUSIC8 = "8"
const MUSIC9 = "9"
#const MUSIC10 = "10"
#const MUSIC11 = "11"
#const MUSIC12 = "12"

const SOUNDS = { 
	MUSIC1: preload("res://assets/Custom Assets/Music/dancing-with-the-lion.ogg"),
	MUSIC2: preload("res://assets/Custom Assets/Music/groove-de-sim.ogg"),
	MUSIC3: preload("res://assets/Custom Assets/Music/in-the-city.ogg"),
	MUSIC4: preload("res://assets/Custom Assets/Music/mahali-pazuri.ogg"),
	MUSIC5: preload("res://assets/Custom Assets/Music/not-in-vain.ogg"),
	MUSIC6: preload("res://assets/Custom Assets/Music/underground-town.ogg"),
	MUSIC7: preload("res://assets/Custom Assets/Music/vibrant.ogg"),
	MUSIC8: preload("res://assets/Custom Assets/Music/a-farming-we-will-go.ogg"),
	MUSIC9: preload("res://assets/Custom Assets/Music/first-story.ogg"),
	
	###################################################################
	#MUSIC1: preload("res://assets/Custom Assets/Music/Pixel 1.ogg"),
	#MUSIC2: preload("res://assets/Custom Assets/Music/Pixel 2.ogg"),
	#MUSIC3: preload("res://assets/Custom Assets/Music/Pixel 3.ogg"),
	#MUSIC4: preload("res://assets/Custom Assets/Music/Pixel 4.ogg"),
	#MUSIC5: preload("res://assets/Custom Assets/Music/Pixel 5.ogg"),
	#MUSIC6: preload("res://assets/Custom Assets/Music/Pixel 6.ogg"),
	#MUSIC7: preload("res://assets/Custom Assets/Music/Pixel 7.ogg"),
	#MUSIC8: preload("res://assets/Custom Assets/Music/Pixel 8.ogg"),
	#MUSIC9: preload("res://assets/Custom Assets/Music/Pixel 9.ogg"),
	#MUSIC10: preload("res://assets/Custom Assets/Music/Pixel 10.ogg"),
	#MUSIC11: preload("res://assets/Custom Assets/Music/Pixel 11.ogg"),
	#MUSIC12: preload("res://assets/Custom Assets/Music/Pixel 12.ogg"),
	
	
	
	
	}

func PlaySound(player: AudioStreamPlayer, key: String) -> void:
	if SOUNDS.has(key) == false:
		return
		
	player.stop()
	player.stream = SOUNDS[key]
	player.play()

func GetRandomMusic():
	pass
