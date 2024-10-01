#version 460 core

precision highp float;

uniform float iWidth;
uniform float iHeight;
uniform float noiseDataLength;
uniform float noiseData[44100]; // Assuming maximum 44100 samples

out vec4 fragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / vec2(iWidth, iHeight);
    float index = uv.x * (noiseDataLength - 1.0);
    int lowIndex = int(floor(index));
    int highIndex = int(ceil(index));
    float t = fract(index);
    
    float noiseValue = mix(noiseData[lowIndex], noiseData[highIndex], t);
    
    vec3 color = vec3(noiseValue * 0.5 + 0.5); // Normalize to 0-1 range
    fragColor = vec4(color, 1.0);
}