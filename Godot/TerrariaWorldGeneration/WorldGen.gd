extends TileMap

var noise : OpenSimplexNoise = OpenSimplexNoise.new() #Terrain Noise Variable
var cave_noise : OpenSimplexNoise = OpenSimplexNoise.new() #Cave Noise Variable
var x_length : int = 1024 #World Length
var y_depth : int = 128 #World Depth
var height : int = 64 #World Height

func _ready():
	randomize() #Randomize the internal game seed

	#Set the seed as random numbers
	noise.seed = randi()
	cave_noise.seed = randi()

	noise.period = 128 #The farther away from zero the smoother the terrain is going to look

	for x in range(-x_length,x_length): #Loop through the X length starting from negative to positive
		var y = ceil(noise.get_noise_1d(x) * height) #Get the noise at the given length and multiply it by the height then round it
		self.set_cellv(Vector2(x,y),0) #Set the cell at the given X and Y


		for depth in range(y+5,y_depth): #Generate stone 5 blocks down from the given Y value
			self.set_cellv(Vector2(x,depth),1)

		for depth in range(y,y+5): #Fill in air gaps with dirt starting from the Y value to 5 blocks down
			if self.get_cellv(Vector2(x,depth)) == TileMap.INVALID_CELL: #'Air Blocks' are empty cells
				self.set_cellv(Vector2(x,depth),2)

		for depth in range(y,y_depth): #Start from the Y and go down to the Y depth
			var yy = noise.get_noise_2d(x,depth) #Get 2d noise from the given X and Y value

			if abs(yy) < .03: #Check if the absolute value of the noise is less than .03
				self.set_cellv(Vector2(x,depth + y),-1) #Remove the block at the given X and Y value
