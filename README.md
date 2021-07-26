# Simple-Animation
Only details on animations will be covered here, for info on importing custom units see [Craven's guide](https://github.com/Craven73/Vermintide-Mods/tree/master/ExampleCustomUnit). 
You won't need to setup a physics file for your unit unless you want it to have collision.

# Setting Up the Model and Animation
--place description for setting up the model and animation in blender
# Creating the bones
In the same directory as your `<custom_unit>.unit` create a file called `<custom_unit>.bones`.
Inside this file you'll make a list of your bones. These bones will have the same name as the mesh nodes you specified to render in your `<your-unit>.unit` file. 
```sjson
bones = [
  "sphere"
  "cube"
]
```
# Creating Animation files
Each animation will need to have a two files corresponding to it; a `<custom_animation>.fbx` and `<custom_animation>.animation`.
Inside of `<custom_animation>.animation` you'll need to specify the path to your unit's bones file and the animation's hermite curve tolernaces.
```sjson
bones = "units/sphere/sphere"
tolerance = {
	"" = [
		0.01
		0.01
		false
		false
	]
}
```

# Creating the State Machine
In the same directory as your `<custom_unit>.unit` create a file called `<custom_unit>.state_machine`.
Inside this file you will specify different animation states for your unit.

```sjson
events = {
	idle = {
	}
	ragdoll = {
	}
}
layers = [
	{
		default_state = "base/idle"
		states = [
			{
				animations = [
					"units/sphere/anims/sphere1"
				]
				loop_animation = true
				name = "base/idle"
				randomization_type = "every_loop"
				root_driving = "ignore"
				speed = "1"
				state_type = "regular"
				transitions = [
					{
						blend_time = 0.2
						event = "idle"
						mode = "direct"
						on_beat = ""
						to = "base/idle"
					}
					{
						blend_time = 0.2
						event = "death"
						mode = "direct"
						on_beat = ""
						to = "base/death"
					}
				]
				weights = [
					"1.0"
				]
			}
			{
				name = "base/death"
				ragdoll = "ragdoll"
				state_type = "ragdoll"
				transitions = [
					{
						blend_time = 0.2
						event = "idle"
						mode = "direct"
						on_beat = ""
						to = "base/idle"
					}
					{
						blend_time = 0.2
						event = "death"
						mode = "direct"
						on_beat = ""
						to = "base/death"
					}
					{
						blend_time = 0.2
						event = "ragdoll"
						mode = "direct"
						on_beat = ""
						to = "base/death"
					}
				]
			}
		]
	}
]
ragdolls = {
	ragdoll = {
		actors = [
		]
		keyframed = [
		]
	}
}
variables = {
	move_speed = 1
}
```
# Some Options in the State Machine
The `default_state` specifies which animation state will play if no animation event is given to the unit. 
States are specified in the `events` table and each state's namesgiven by `name = "base/<state>"`.
A state can have multiple animations by simply adding that animation's path to the state's `animation` table like so:
```sjson
animations = [
  "units/sphere/anims/sphere1"
  "units/sphere/anims/sphere2"
]
```
The chance of each animation playing is specified in the `wieghts` table. With a wieght of "10" meaning the animation is ten times more likely to play.
```sjson
weights = [
  "1.0"
  "10"
]
```

