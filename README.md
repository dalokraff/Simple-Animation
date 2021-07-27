# Simple-Animation
Only details on animations will be covered here, for info on importing custom units see [Craven's guide](https://github.com/Craven73/Vermintide-Mods/tree/master/ExampleCustomUnit). 
You won't need to setup a physics file for your unit unless you want it to have collision.

# Setting Up the Model and Animation
For this specific package we are going to have 2 parented objects rotating, but it should work fine if you only have 1 object, you can follow the animation steps and it should be fine. If you are new to blender, or don't usually work with it, use the `animation tab` (at the very top, near layout, UV editing...) and make sure to set the interface up similarly to what is shown, we will need the `Non linear animation` and the `dope sheet` windows.

First create your objects, and if you make any changes to their rotation or scale make sure to apply it using `ctrl + a`
![Step1](https://imgur.com/eSkLUmg)

after that we are going to parent them using `ctrl + p`
![Step2](https://imgur.com/7g565kb)

next for the animations use `I` to insert keyframes, currently scale animations don't seem to work, so don' use it, so define the starting position of your objects, `insert location rotation keyframes`, and animate away, move the cursor to the next frame you want to animate, make changes to your object and insert keyframes again.
![Step3](https://imgur.com/VotdySs)

Once you are done with your animation you're going to want to push the action into an NLA strip, by pressing the button shown in the image, IMPORTANT, this will make your keyframes disappear, and you will have to change your dope sheet tab into the action editor tab if you wish to make any changes, and then push it down again.
![Step4](https://imgur.com/3bDk2on)

## Export Settings
If you use the `Selected objects` option make sure you have all the objects you want to export selected, change the `Apply scalings` to FBX Units Scale and in animation remove Force Start/End Keying
![Export Setting](https://imgur.com/EyenTH3)

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

