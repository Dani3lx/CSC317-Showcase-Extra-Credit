// Uniforms
uniform mat4 view;
uniform mat4 proj;
uniform float animation_seconds;
uniform int object_id;

// Inputs
in vec3 sphere_fs_in;
in vec3 normal_fs_in;
in vec4 pos_fs_in;
in vec4 view_pos_fs_in;

// Outputs
out vec4 color;

vec3 star_pattern(vec3 p, float t)
{   
    // Yellow-white-orange star colors
    // vec3 core = vec3(1.0, 0.95, 0.7);      // Bright yellow-white
    // vec3 mid = vec3(1.0, 0.8, 0.2);        // Golden yellow
    // vec3 outer = vec3(1.0, 0.6, 0.1);      // Orange

    vec3 core = vec3(1.0, 0.9, 1.0);       // Bright white-purple
    vec3 mid = vec3(0.85, 0.3, 1.0);       // Vibrant magenta-purple
    vec3 outer = vec3(0.6, 0.1, 0.9);      // Intense deep purple
    
    vec3 result = mix(outer, mid, 0.3);
    result = mix(result, core, 0.5);
    
    // Boost brightness
    result *= 2.0 + 0.3 * sin(t * 5.0);
    
    return result;
}

void main()
{
    vec3 n = normalize(normal_fs_in);
    vec3 v = normalize(-view_pos_fs_in.xyz);
    
    // Distance from center (for falloff)
    float distFromCenter = length(sphere_fs_in);
    
    // Pulsing animation
    float pulse = 0.8 + sin(object_id * animation_seconds * 10.0);
    
    // Core glow pattern
    vec3 starCore = star_pattern(sphere_fs_in, animation_seconds);
    
    // Volumetric glow effect
    float centerGlow = 1.0 - smoothstep(0.0, 1.0, distFromCenter);
    centerGlow = pow(centerGlow, 1.67) * pulse;
    
    // Surface fresnel glow (edge highlight)
    float cosTheta = max(dot(n, v), 0.0);
    float edgeGlow = pow(1.0 - cosTheta, 2.0);
    
    // Combine layers
    vec3 glowColor = starCore * (centerGlow + 0.3);
    vec3 edgeColor = vec3(1.0, 0.9, 0.6) * edgeGlow * 0.8;
    
    // Final color with bloom-like intensity
    vec3 finalColor = (glowColor + edgeColor) * 0.67;
    finalColor *= 1.2;
    
    color = vec4(finalColor, 1.0);
}