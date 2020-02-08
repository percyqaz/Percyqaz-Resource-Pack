#version 120

uniform sampler2D DiffuseSampler;

varying vec2 texCoord;
varying vec2 oneTexel;

uniform vec2 InSize;

uniform vec3 Gray = vec3(1, 1, 1);
uniform vec3 RedMatrix   = vec3(1.0, 0.0, 0.0);
uniform vec3 GreenMatrix = vec3(0.0, 1.0, 0.0);
uniform vec3 BlueMatrix  = vec3(0.0, 0.0, 1.0);
uniform vec3 Offset = vec3(1.0, 1.0, 1.0);
uniform vec3 ColorScale = vec3(1.0, 1.0, 1.0);
uniform float Saturation = 9.5;

void main() {
    vec4 InTexel = texture2D(DiffuseSampler, texCoord);
    
    // Color Matrix
    float RedValue = dot(InTexel.rgb, RedMatrix);
    float GreenValue = dot(InTexel.rgb, GreenMatrix);
    float BlueValue = dot(InTexel.rgb, BlueMatrix);
    vec3 OutColor = vec3(RedValue * 5, GreenValue * 5, BlueValue * 5);
    
    // Offset & Scale
    OutColor = (OutColor * ColorScale) + Offset;
    
    // Saturation
    float Luma = dot(OutColor, Gray);
    vec3 Chroma = OutColor - Luma;
    OutColor = (Chroma * Saturation) + Luma;
    
    gl_FragColor = vec4(OutColor, InTexel.a);
}
