// Given a 3d position as a seed, compute an even smoother procedural noise
// value. "Improving Noise" [Perlin 2002].
//
// Inputs:
//   st  3D seed
// Values between  -½ and ½ ?
//
// expects: random_direction, improved_smooth_step
float improved_perlin_noise( vec3 st) 
{
  vec3 i = floor(st);
  vec3 f = fract(st);
  vec3 u = improved_smooth_step(f);

  vec3 corners[8] = vec3[8](
    vec3(0,0,0), vec3(1,0,0), vec3(0,1,0), vec3(1,1,0),
    vec3(0,0,1), vec3(1,0,1), vec3(0,1,1), vec3(1,1,1)
  );

  float dots[8];
  for (int idx = 0; idx < 8; idx++) {
    vec3 g = random_direction(i + corners[idx]);
    vec3 d = f - corners[idx];
    dots[idx] = dot(g, d);
  }

  float nx00 = mix(dots[0], dots[1], u.x);
  float nx01 = mix(dots[2], dots[3], u.x);
  float nx10 = mix(dots[4], dots[5], u.x);
  float nx11 = mix(dots[6], dots[7], u.x);

  float nxy0 = mix(nx00, nx01, u.y);
  float nxy1 = mix(nx10, nx11, u.y);

  float nxyz = mix(nxy0, nxy1, u.z);

  return nxyz;
}

