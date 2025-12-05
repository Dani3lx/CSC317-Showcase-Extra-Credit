// Inputs:
//   theta  amount y which to rotate (in radians)
// Return a 4x4 matrix that rotates a given 3D point/vector about the y-axis by
// the given amount.
mat4 rotate_about_y(float theta)
{
  mat4 res = identity();
  res[0][0] = cos(theta);
  res[0][2] = -sin(theta);
  res[2][0] = sin(theta);
  res[2][2] = cos(theta);
  return res;
}

