shader_type canvas_item;

uniform vec4 original_0 : source_color;
uniform vec4 original_1 : source_color;
uniform vec4 original_2 : source_color;

uniform vec4 replace_0 : source_color;
uniform vec4 replace_1 : source_color;
uniform vec4 replace_2 : source_color;

const float precision = 0.1;

vec4 replace_color(vec4 color) {
	vec4 original_colors[3] = vec4[3](original_0, original_1, original_2);
	vec4 replace_colors[3] = vec4[3](replace_0, replace_1, replace_2);
	
	for(int i = 0; i < original_colors.length(); i++){
		if(distance(color, original_colors[i]) <= precision) {
			color = replace_colors[i];
		}
	}
	
	return color;
	
}

void fragment() {
	COLOR = replace_color(texture(TEXTURE, UV));
}
