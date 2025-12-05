// Construct the model transformation matrix for a galaxy
// Math approach based on Bruno Simon's Three.js tutorials
// https://threejs-journey.com/
//
// Inputs:
//   object_id the id of the object (star)
//   time  seconds on animation clock
// Returns affine model transformation as 4x4 matrix
//
// expects: identity, rotate_about_y, translate, PI

// Pseudo-random function (returns value between 0 and 1)
float hash(float n)
{
    return fract(sin(n) * 12345.676767);
}

mat4 model(int object_id, float time)
{
  mat4 res = identity();
  
  // Galaxy parameters
  float galaxyRadius = 6.67;        // How big the galaxy is
  float spin = 5.5;                 // How much the arms twist
  int branches = 5;                 // Number of spiral arms
  float randomness = 0.167;         // How scattered stars are
  float randomnessPower = 10.67;      // Concentration (higher = more concentrated on arms)
  
  // Generate pseudo-random values based on object_id
  float seed = float(object_id);
  float randRadius = hash(seed * 1.23);
  float randY = hash(seed * 4.56);
  float randYSign = hash(seed * 7.89);
  float randX = hash(seed * 8.90);
  float randZSign = hash(seed * 9.12);
  float randZ = hash(seed * 10.23);
  float randSize = hash(seed * 67.6767);
  
  // Randomly distribute the star in the galaxy within the galaxy radius
  float radius = randRadius * galaxyRadius;
  
  // Calculate how much the spin angle is (the further away it is the more exaggerated the spin)
  float spinAngle = 1;
  if (object_id % 2 == 0) {
    spinAngle = acos(radius * spin);
  } else {
    spinAngle = sin(radius * spin);
  }
  
  // Assign the star to a branch/arm (Arms are evenly distributed across 2 * PI, if 3 arms then each is 2 * PI / 3 apart)
  float branchAngle = float(object_id % branches) / float(branches) * M_PI * 2.0;
  
  // Randomly shift the star so the stars are scattered around the arm 
  // stars concentrate near arms, the further away the star is, the stronger the shift
  float randomX = pow(randY, randomnessPower) * (randYSign < 0.5 ? 1.0 : -1.0) * randomness * radius;
  float randomY = pow(randX, randomnessPower) * (randZSign < 0.5 ? 1.0 : -1.0) * randomness * radius;
  float randomZ = pow(randZ, randomnessPower) * (hash(seed * 53.892) < 0.5 ? 1.0 : -1.0) * randomness * radius;
  
  // Calculate final position
  float totalAngle = branchAngle + spinAngle;
  float x_pos = cos(totalAngle) * radius + randomX;
  float y_pos = randomY * 1.67;
  float z_pos = sin(totalAngle) * radius + randomZ;
  
  // Star size (smaller stars further out, with variation)
  float size_variation = 0.5 + randSize * 0.5;
  float star_size = (0.067 + 0.02 * size_variation) * (1.0 - radius / galaxyRadius * 0.1) * 0.167;
  
  res = rotate_about_y(time * 0.167 + (radius * 1.67)) *                // Galaxy rotation
        translate(vec3(x_pos, y_pos, z_pos)) * 
        uniform_scale(star_size);
  
  return res;
}