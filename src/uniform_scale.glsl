// Inputs:
//   s  amount to scale in all directions
// Return a 4x4 matrix that scales and input 3D position/vector by s in all 3
// directions.
mat4 uniform_scale(float s)
{
  mat4 res = identity();
  for (int i = 0; i < 3; i++) {
    res[i][i] = s;
  }
  return res;
}

