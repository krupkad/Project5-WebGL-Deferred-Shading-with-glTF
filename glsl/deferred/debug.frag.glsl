#version 100
precision highp float;
precision highp int;

#define NUM_GBUFFERS 3

uniform int u_debug;
uniform mat4 u_projMat;
uniform mat4 u_viewMat;
uniform sampler2D u_gbufs[NUM_GBUFFERS];
uniform sampler2D u_depth;

varying vec2 v_uv;

const vec4 SKY_COLOR = vec4(0.66, 0.73, 1.0, 1.0);

void main() {
    vec4 gb0 = texture2D(u_gbufs[0], v_uv);
    vec4 gb1 = texture2D(u_gbufs[1], v_uv);
    vec4 gb2 = texture2D(u_gbufs[2], v_uv);
    float depth = texture2D(u_depth, v_uv).x;
    // TODO: Extract needed properties from the g-buffers into local variables
    // These definitions are suggested for starting out, but you will probably want to change them.

    vec3 pos = gb0.xyz;     // World-space position
    vec3 nor = gb1.xyz;  // Normals of the geometry as defined, without normal mapping
    vec3 colmap = gb2.rgb;  // The color map - unlit "albedo" (surface color)

    // TODO: uncomment
    if (u_debug == 0) {
        gl_FragColor = vec4(vec3(depth), 1.0);
    } else if (u_debug == 1) {
        gl_FragColor = vec4(abs(pos) * 0.1, 1.0);
    } else if (u_debug == 2) {
        gl_FragColor = vec4(abs(nor), 1.0);
    } else if (u_debug == 3) {
        gl_FragColor = vec4(colmap, 1.0);
    } else {
        gl_FragColor = vec4(1, 0, 0, 1);
    }
}
