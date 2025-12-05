// Inputs:
//   t  3D vector by which to translate
// Return a 4x4 matrix that translates and 3D point by the given 3D vector
mat4 translate(vec3 t)
{
  mat4 res = identity();
  res[3] = vec4(t, 1.0);
  return res;
}

