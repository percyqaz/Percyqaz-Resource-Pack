#version 120

attribute vec4 Position;

uniform mat4 ProjMat;
uniform vec2 InSize;

varying vec2 texCoord;
varying vec2 oneTexel;

void main(){
    vec4 outPos = ProjMat * vec4(Position.xy, 0.0, 1.0);
    gl_Position = vec4(outPos.xy, 0.9, 1.0);

    oneTexel = 2.0 / InSize;
    texCoord = outPos.xy * 0.5 + 0.5;
}
