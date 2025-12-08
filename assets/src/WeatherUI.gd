extends Control

var weatherType := ["clear", "rain", "snow"]

@onready var weatherTypeList: ItemList = $weatherTypeList
@onready var windSlider: Slider = $windSlider
@onready var sizeSlider: Slider = $sizeSlider
@onready var amountSlider: Slider = $amountSlider
@onready var lightSlider: Slider = $lightSlider
@onready var snowDarkSlider: Slider = $snowDarkSlider
@onready var rainDarkSlider: Slider = $rainDarkSlider
@onready var lightTimeSlider: Slider = $lightTimeSlider
@onready var weatherTimeSlider: Slider = $weatherTimeSlider

@export var weatherNode: NodePath = "../Weather"
@onready var weather: Node2D = get_node(weatherNode)


func _ready() -> void:
	# Preenche a lista
	for w in weatherType:
		weatherTypeList.add_item(w)

	# Define valores iniciais no Weather
	weather.wind = windSlider.value
	weather.size = sizeSlider.value
	weather.amount = amountSlider.value
	weather.light = lightSlider.value
	weather.snow_darkness = snowDarkSlider.value
	weather.rain_darkness = rainDarkSlider.value
	weather.lightChangeTime = lightTimeSlider.value
	weather.weatherChangeTime = weatherTimeSlider.value

	weather.change_weather()


func _on_windSlider_value_changed(value: float) -> void:
	weather.wind = value
	weather.change_weather()

func _on_sizeSlider_value_changed(value: float) -> void:
	weather.size = value
	weather.change_weather()

func _on_amountSlider_value_changed(value: float) -> void:
	weather.amount = value
	weather.change_weather()

func _on_lightSlider_value_changed(value: float) -> void:
	weather.light = value
	weather.change_weather()

func _on_snowDarkSlider_value_changed(value: float) -> void:
	weather.snow_darkness = value
	weather.change_weather()

func _on_rainDarkSlider_value_changed(value: float) -> void:
	weather.rain_darkness = value
	weather.change_weather()

func _on_lightTimeSlider_value_changed(value: float) -> void:
	weather.lightChangeTime = value
	weather.change_weather()

func _on_weatherTimeSlider_value_changed(value: float) -> void:
	weather.weatherChangeTime = value
	weather.change_weather()

func _on_weatherTypeList_item_selected(index: int) -> void:
	weather.weatherType = weatherType[index]
	weather.change_weather()
