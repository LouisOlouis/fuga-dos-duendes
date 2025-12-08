extends Node2D

@export_enum("clear", "rain", "snow") var weatherType: String = "sun"
@export var wind: float = 0.0
@export var size: float = 0.3
@export var amount: int = 1500
@export var light: float = 1.0
@export var snow_darkness: float = 0.2
@export var rain_darkness: float = 0.3
@export var lightChangeTime: float = 2.0
@export var delayWeatherChange: bool = true
@export var weatherChangeTime: float = 2.0

var nightColor: Color = Color.WHITE
@export var followNode: NodePath

@onready var snow: GPUParticles2D = $Snow
@onready var rain: GPUParticles2D = $Rain
@onready var darkness: ColorRect = $Darkness

@onready var follow: Node2D = get_node_or_null(followNode)

var last_amount: int

func _ready():
	change_weather()
	darkness_position()
	position = get_viewport_transform().origin + Vector2(get_viewport_rect().size.x/2,0)
	snow.process_material.emission_box_extents.x = get_viewport_rect().size.x * 2
	rain.process_material.emission_box_extents.x = get_viewport_rect().size.x * 2

func _physics_process(_delta):
	if follow:
		position = follow.position + Vector2(0,-get_viewport_rect().size.y)
		darkness_position()


func change_weather():

	if weatherType == "clear":
		apply_rain_settings()
		apply_snow_settings()
		if delayWeatherChange: await get_tree().create_timer(lightChangeTime).timeout
		change_light(nightColor.darkened(light))

	if weatherType == "snow":
		change_light(nightColor.darkened(light - snow_darkness * size))
		if delayWeatherChange: await get_tree().create_timer(lightChangeTime).timeout
		
		change_amount(snow,amount)
		apply_snow_settings()
		snow.emitting = true
	else:
		snow.emitting = false

	if weatherType == "rain":
		change_light(nightColor.darkened(light - rain_darkness * size))
		if delayWeatherChange: await get_tree().create_timer(lightChangeTime).timeout
		
		change_amount(rain,amount)
		apply_rain_settings()
		rain.emitting = true
	else:
		rain.emitting = false

	last_amount = amount


func change_light(new_color: Color):
	var tween = create_tween()
	tween.tween_property(darkness, "color", new_color, lightChangeTime)


func apply_snow_settings():
	change_size(snow,size)
	change_wind_speed(snow,0.5 + abs(wind)/2)
	change_wind_direction(snow,wind)
	snow.process_material.gravity.x = 70 * wind


func apply_rain_settings():
	change_size(rain,size)
	change_wind_speed(rain,0.5 + abs(wind)/2 + size/2)
	change_wind_direction(rain,wind)
	rain.process_material.gravity.x = 200 * wind


func change_size(weather,new_size):
	var tween = create_tween()
	tween.tween_property(weather.process_material,"anim_offset",new_size,weatherChangeTime)


func change_amount(weather,new_amount):
	if last_amount != amount:
		if weather.emitting: weather.preprocess = weather.lifetime * 2.0
		weather.amount = amount
	else:
		weather.preprocess = 0


func change_wind_direction(weather,new_wind):
	var tween = create_tween()
	tween.tween_property(weather.process_material,"direction:x",new_wind,weatherChangeTime)


func change_wind_speed(weather,new_speed):
	var tween = create_tween()
	tween.tween_property(weather,"speed_scale",new_speed,weatherChangeTime)


func darkness_position():
	darkness.size = get_viewport_rect().size * 4
	darkness.position = get_viewport_rect().position - Vector2(get_viewport_rect().size.x*2,get_viewport_rect().size.y)
