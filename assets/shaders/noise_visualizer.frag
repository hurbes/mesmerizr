#version 460 core

precision highp float;

uniform float iWidth;
uniform float iHeight;
uniform float noiseDataLength;
uniform float noiseData[44100]; // Maximum 44100 samples

out vec4 fragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / vec2(iWidth, iHeight);
    float index = uv.x * (noiseDataLength - 1.0);
    int lowIndex = int(floor(index));
    int highIndex = int(ceil(index));
    
    // Ensure we don't access out of bounds
    lowIndex = clamp(lowIndex, 0, int(noiseDataLength) - 1);
    highIndex = clamp(highIndex, 0, int(noiseDataLength) - 1);
    
    float t = fract(index);
    
    float noiseValue = mix(noiseData[lowIndex], noiseData[highIndex], t);
    
    // Visualize the noise as a grayscale value
    vec3 color = vec3(noiseValue * 0.5 + 0.5); // Normalize to 0-1 range
    fragColor = vec4(color, 1.0);
}