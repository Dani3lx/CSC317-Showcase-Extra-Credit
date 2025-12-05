# Stellar Galaxy

## Personal Information
- **Full Name:** Daniel Xu
- **UtorID:** xudanie6
- **Student Number:** 1008235857
- **Assignment Augmented:** A6

## Instructions

### Building
```bash
git clone --recursive git@github.com:Dani3lx/CSC317-Showcase-Extra-Credit.git
cd CSC317-Showcase-Extra-Credit
mkdir build
cd build
cmake ..
make
```

### Running
From the build directory:
```bash
./shaderpipeline ../data/galaxy.json
```

### Controls
- **Mouse:** Rotate camera view
- **Scroll:** Zoom in/out
- **L:** Toggle wireframe mode

## Description

This piece creates a procedurally generated galaxy visualization using shader programming. The scene features 20000 stars distributed in a galaxy pattern.

### Features Added

1. **Procedural Galaxy Distribution** (`src/model.glsl`)
   - Generates spiral galaxy structure using trigonometric spiral equations with multiple arms
   - Calculates radial distance from galactic center with density falloff for realistic clustering
   - Assigns each star to one of several spiral arms/branches using modular arithmetic
   - Applies pseudo-random angular and radial offsets to each star for natural dispersion
   - Creates denser galactic bulge near center and sparser outer regions
   - Uses star index as seed for deterministic but varied positioning
   - Size variation for visual depth and star classification
   - All fields are fully customizable for unique rendering

2. **Dynamic Star Rendering** (`src/galaxy.fs` + `main.cpp`)
   - Renders 20000 star objects, can lower or increase for customizability
   - Implemented alpha blending with additive blend mode for realistic light accumulation and bloom-like glow effects
   - Applied Fresnel edge lighting to create luminous halos around star geometry, enhancing depth perception
   - Procedural brightness pulsation using time-based sine waves with per-star frequency variation
   - Smooth alpha falloff from center to edges for soft, diffuse star appearance


https://github.com/user-attachments/assets/d7ff750d-de94-4b8a-b16a-efafe7e5be32


https://github.com/user-attachments/assets/8dd5d569-9a87-4f6f-a674-440277310cad



## Acknowledgements

### Math Resources
- Three.js Journey by Bruno Simon - Spiral galaxy distribution equations adapted from Bruno Simon's tutorials

### Assets
- No external texture assets were used - all visuals are procedurally generated

### External Libraries
- Eigen (included as submodule) for linear algebra operations
- libigl (included as submodule) for mesh utilities
- GLFW 3.3 for windowing
- OpenGL 4.1+ for rendering pipeline

All shader code was written specifically for this project, building upon the base assignment framework.
