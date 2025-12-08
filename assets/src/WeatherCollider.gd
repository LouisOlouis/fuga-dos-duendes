@tool
extends Control

@export_enum("clear", "rain", "snow") var weatherType: String = "sun"
@export var wind: float = 0.0
@export var area_size: float = 0.3        # RENOMEADO de "size" para evitar conflito com Control.size
@export var amount: int = 1500
@export var setLight: bool = false
@export var light: float = 1.0
@export var lightChangeTime: float = 2.0
@export var delayWeatherChange: bool = true
@export var weatherChangeTime: float = 2.0

@export var weatherNode: NodePath = "../Weather"

@onready var weather: Node2D = get_node_or_null(weatherNode)
@onready var collisionShape2D: CollisionShape2D = $Area2D/CollisionShape2D


func _ready() -> void:
	if collisionShape2D:
		_update_area_shape()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		_update_area_shape()


func changeWeather() -> void:
	if weather == null:
		return

	if weather.last_control != self:
		weather.last_control = self

		weather.weatherType = weatherType
		weather.wind = wind
		weather.size = area_size          # Mantém compatibilidade com o node Weather
		weather.amount = amount
		weather.lightChangeTime = lightChangeTime
		weather.delayWeatherChange = delayWeatherChange
		weather.weatherChangeTime = weatherChangeTime

		if setLight:
			weather.light = light

		weather.change_weather()


func _on_Area2D_body_entered(_body: Node) -> void:
	changeWeather()


func _update_area_shape() -> void:
	if collisionShape2D == null:
		return

	var shape = RectangleShape2D.new()
	shape.extents = Vector2(area_size, area_size) / 2.0
	collisionShape2D.shape = shape
	collisionShape2D.position = shape.extents
