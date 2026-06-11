# Ex-Situ Tendon-Network Tactile Sensing

This repository contains MATLAB scripts and source data associated with the manuscript:

**Harsh-Environment Manipulation Enabled by Ex-Situ Tendon-Network Tactile Sensing**

The code is used to reproduce the contact-force, contact-position, and contact-trajectory reconstruction results based on tendon-tension inputs.

## Files

```text
.
├── pattern_test/
│   └── force_cal_pattern.m        # Continuous contact-trajectory reconstruction under random errors
├── transformations/               # Coordinate transformation functions
├── P_F_ex_result_cal.m             # Main contact-force and contact-position reconstruction script
├── config.m                       # Model, geometry, and calibration parameters
├── data_all_final.xlsx             # Source data used for generating the manuscript figures
├── force_cal.m                    # Force reconstruction under random tendon-tension perturbations
├── test_point_force.m              # Initial disturbance-free inputs for contact-point reconstruction tests
├── sensing_area.m                 # Sensing surface visualization
├── surface_point.m                # Distal phalanx surface-point generation
└── other helper scripts
```

## Requirements

The code was developed in MATLAB. No additional third-party toolbox is required for the basic reconstruction scripts.

## Data

`data_all_final.xlsx` contains the source data used to generate the manuscript figures, including experimental measurements, processed results, and plotting data.

Please keep this Excel file in the root directory unless the file path is modified in the scripts.

## Main scripts

### `P_F_ex_result_cal.m`

Core solver used by other scripts to estimate external force and contact position from tendon-tension measurements. This file mainly implements the equation-solving procedure and is typically called within reconstruction workflows.

### `force_cal.m`

Calculates reconstructed external forces under random tendon-tension perturbations.

```matlab
force_cal
```

### `test_point_force.m`

Contains the initial disturbance-free tendon-tension inputs for contact-point and force reconstruction tests. Random perturbations can be added to these initial inputs to evaluate the influence of tendon-tension errors.

The random perturbation is defined as:

random_noise = -0.02 + 0.04 * rand(6, 6, 3);

The unit is kgf. This generates a 6 × 6 × 3 random perturbation matrix, with each element uniformly distributed between -0.02 kgf and +0.02 kgf.

### `pattern_test/force_cal_pattern.m`

Generates reconstructed continuous contact trajectories under random input errors.

```matlab
cd pattern_test
force_cal_pattern
```

## Outputs

Depending on the script, the outputs include:

* reconstructed external force;
* reconstructed force direction;
* reconstructed contact position;
* reconstructed continuous contact trajectory;
* visualization of contact points and sensing surface.

## Notes

The parameters in `config.m` are specific to the prototype geometry, tendon routing, and calibration used in the manuscript. For other robotic fingers or tendon-network designs, these parameters should be updated.

Because random perturbations are used in some scripts, repeated runs may produce slightly different results unless the random seed is fixed.
