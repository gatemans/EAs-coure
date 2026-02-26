# Discrete MOPSO for RC Beam Design

MATLAB implementation of a **Discrete Multi-Objective Particle Swarm Optimization (MOPSO)**
for selecting optimal reinforced concrete (RC) beam designs from a predefined database.

## Objectives
- Maximize bending moment capacity  
- Minimize construction cost  

The optimization is performed in minimization form:
- f1 = −Moment  
- f2 = Cost  

## Method
- Discrete particle representation (design index)
- Pareto dominance for pbest and archive update
- External Pareto archive
- Leader selection from archive
- Knee point method for final solution selection

## Input
`data.xlsx` containing:
- `Cost`
- `M1_pos`, `M2_pos`

Moment is calculated as:

## Output
- Pareto front (Moment vs Cost)
- Convergence history
- Selected optimal design (knee point)

## Run

No additional toolboxes required.

## Author
Mohammad Mahdi Khaligh
