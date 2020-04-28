extends Node2D

var rng = RandomNumberGenerator.new()

var day = 1
var month = 4
var monthMax = 30
var year = 0

var tick = 0

var big = 0
var small = 0
var inflation = 0
var money = 100000000

var end = false

onready var big_cost = [0,0,0,0,0]
onready var big_days = [-1,-1,-1,-1,-1]
onready var small_cost = [0,0,0,0,0]
onready var small_days = [-1,-1,-1,-1,-1]

onready var bBtn1 = $Big_Business_1
onready var bBtn2 = $Big_Business_2
onready var bBtn3 = $Big_Business_3
onready var bBtn4 = $Big_Business_4
onready var bBtn5 = $Big_Business_5

onready var sBtn1 = $Small_Business_1
onready var sBtn2 = $Small_Business_2
onready var sBtn3 = $Small_Business_3
onready var sBtn4 = $Small_Business_4
onready var sBtn5 = $Small_Business_5

onready var big_business_buttons = [bBtn1, bBtn2, bBtn3, bBtn4, bBtn5]
onready var small_business_buttons = [sBtn1, sBtn2, sBtn3, sBtn4, sBtn5]

var big_fluff = ["Walmart", "American Airlines", "BP", "Ford", "Ram", "Goldman Sachs", "Exxon Mobil", "Amazon", "General Motors", "Fannie Mae", "Bank of America", "Chase", "Boeing", "Target", "PepsiCo", "Disney", "Coca-Cola"]
var small_fluff = ["Midwest restaurants", "East Coast restaurants", "West Coast restaurants", "Southern restaurants", "Midwest Retail", "East Coast Retail", "West Coast Retail", "Southern Retail", "Midwest Rent", "East Coast Rent", "West Coast Rent", "Southern Rent", "Student Loans", ""]

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	setMoney()

func _process(delta):
	if day < 10 && month < 10:
		$Date.text = "0" + str(day) + "/0" + str(month) + "/2020"
	elif day < 10 && month > 9:
		$Date.text = "0" + str(day) + "/" + str(month) + "/2020"
	elif day > 9 && month < 10:
		$Date.text = str(day) + "/0" + str(month) + "/2020"
	else:
		$Date.text = str(day) + "/" + str(month) + "/2020"
	
	tick += delta
	
	if tick >= 0.1 && !end:
		tick = 0
		day += 1
		updateBusinesses()
		
		if rng.randf() > 0.8:
			spawnBusinesses()
		
		if day > monthMax:
			day = 1
			month += 1
			if month > 12:
				month = 1
				end()
				
			if month == 2:
				monthMax = 28
			elif month == 4 || month == 6 || month == 9 || month == 11:
				monthMax = 30
			else:
				monthMax = 31
				
	
func end():
	end = true
	$EndScreen.visible = true
	if inflation >= 5:
		$EndScreen/EndLabel.text = "Despite your best efforts the inflation of the US dollar was to high. Fiat currency becomes worthless as people look to alternatives to trade. The global economy collapses."
	elif big > small:
		$EndScreen/EndLabel.text = "Big Business survives but their employees are severly hurt. In order to pay off their debts they spend all their relief money keeping themselves afloat while laying off millions. Small businesses fail and people cannot afford housing or food. Rioting and civil unrest overtakes the country"
	else:
		$EndScreen/EndLabel.text = "The large corperations do not survive but people are able to weather the storm. While the economy shinks drastically and prices go up, order holds. "
	
func setMoney():
	var money_str = comma_sep(money)
	$Actual_Money.text = "$ " + money_str

func comma_sep(number):
	var string = str(number)
	var mod = string.length() % 3
	var res = ""

	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]

	return res

func updateBusinesses():
	for i in len(big_days):
		big_days[i] -= 1
		if big_days[i] <= 0:
			big_business_buttons[i].visible = false
	
	for i in len(small_days):
		small_days[i] -= 1
		if small_days[i] <= 0:
			small_business_buttons[i].visible = false

func spawnBusinesses():
	for i in len(big_days):
		if big_days[i] < 0:
			big_cost[i] = rng.randi_range(1000000, 5000000000)
			big_business_buttons[i].text = big_fluff[rng.randi_range(0, len(big_fluff) - 1)] + ": $" + comma_sep(big_cost[i])
			big_business_buttons[i].visible = true
			big_days[i] = rng.randi_range(18, 35)
			break
	
	for i in len(small_days):
		if small_days[i] < 0:
			small_cost[i] = rng.randi_range(250000, 5000000)
			small_business_buttons[i].text = small_fluff[rng.randi_range(0, len(small_fluff) - 1)] + ": $" + comma_sep(small_cost[i])
			small_business_buttons[i].visible = true
			small_days[i] = rng.randi_range(18, 35)
			break

func _on_Big_Business_1_pressed():
	big += 1
	big_business_buttons[0].visible = false
	money -= big_cost[0]
	big_days[0] = -1
	setMoney()


func _on_Big_Business_2_pressed():
	big += 1
	big_business_buttons[1].visible = false
	money -= big_cost[1]
	big_days[1] = -1
	setMoney()


func _on_Big_Business_3_pressed():
	big += 1
	big_business_buttons[2].visible = false
	money -= big_cost[2]
	big_days[2] = -1
	setMoney()


func _on_Big_Business_4_pressed():
	big += 1
	big_business_buttons[3].visible = false
	money -= big_cost[3]
	big_days[3] = -1
	setMoney()


func _on_Big_Business_5_pressed():
	big += 1
	big_business_buttons[4].visible = false
	money -= big_cost[4]
	big_days[4] = -1
	setMoney()


func _on_Small_Business_1_pressed():
	small += 1
	small_business_buttons[0].visible = false
	money -= small_cost[0]
	small_days[0] = -1
	setMoney()


func _on_Small_Business_2_pressed():
	small += 1
	small_business_buttons[1].visible = false
	money -= small_cost[1]
	small_days[1] = -1
	setMoney()


func _on_Small_Business_3_pressed():
	small += 1
	small_business_buttons[2].visible = false
	money -= small_cost[2]
	small_days[2] = -1
	setMoney()


func _on_Small_Business_4_pressed():
	small += 1
	small_business_buttons[3].visible = false
	money -= small_cost[3]
	small_days[3] = -1
	setMoney()


func _on_Small_Business_5_pressed():
	small += 1
	small_business_buttons[4].visible = false
	money -= small_cost[4]
	small_days[4] = -1
	setMoney()


func _on_Print_Money_pressed():
	inflation += 1
	money += round(250000000 + (250000000 * (exp(inflation) / 5)))
	setMoney()
