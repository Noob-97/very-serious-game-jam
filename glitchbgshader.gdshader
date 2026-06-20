shader_type canvas_item;

uniform float glitch_speed : hint_range(1.0, 10.0) = 5.0;
uniform float glitch_intensity : hint_range(0.0, 1.0) = 0.02;

float rand(vec2 co) {
	return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	vec2 uv = UV;
	
	float time_step = floor(TIME * glitch_speed);
	float glitch_line = step(0.95, rand(vec2(time_step, floor(uv.y * 20.0))));
	
	uv.x += glitch_line * (rand(vec2(time_step, uv.y)) - 0.5) * glitch_intensity;
	COLOR = texture(TEXTURE, uv);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
