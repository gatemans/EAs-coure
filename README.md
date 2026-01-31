# Evolutionary Algorithms for Optimization (GA, PSO, and More)

This repository contains **educational MATLAB implementations of Evolutionary Algorithms (EAs)** developed as part of my *Optimization* course. The main goal is not just to provide working code, but to **clearly explain the structure, logic, and key parameters** of popular metaheuristic algorithms such as **Genetic Algorithm (GA)** and **Particle Swarm Optimization (PSO)**.

The repository is suitable for:

* Students learning optimization and metaheuristics
* Researchers who want clean, readable reference implementations
* Anyone who wants to understand *how* and *why* these algorithms work, not just run them

---

## 📁 Repository Structure (MATLAB-Oriented)

```
Optimization-EAs/
│
├── GA/
│   ├── ga_main.m              # Main GA script
│   ├── ga_initialize.m        # Population initialization
│   ├── ga_selection.m         # Selection operators
│   ├── ga_crossover.m         # Crossover operators
│   ├── ga_mutation.m          # Mutation operators
│   ├── ga_fitness.m           # Fitness / objective function
│   └── README.md              # GA-specific explanation
│
├── PSO/
│   ├── pso_main.m             # Main PSO script
│   ├── pso_initialize.m       # Swarm initialization
│   ├── pso_update.m           # Velocity & position update
│   ├── pso_fitness.m          # Cost / objective function
│   └── README.md              # PSO-specific explanation
│
├── test_functions/
│   ├── sphere.m
│   ├── rastrigin.m
│   ├── rosenbrock.m
│   └── ackley.m
│
├── results/
│   ├── convergence_plots/
│   └── logs/
│
└── README.md                  # This file
```

Each algorithm is **modularized using MATLAB `.m` files**, so every step of the optimization process is easy to follow, debug, and modify.

---

## 🧬 Genetic Algorithm (GA) – MATLAB Implementation

### 1. Basic Idea

The Genetic Algorithm is inspired by **biological evolution**. A population of candidate solutions evolves over generations using operators such as **selection**, **crossover**, and **mutation**.

At each generation:

1. Better solutions have a higher chance to survive
2. New solutions are created by combining existing ones
3. Random mutations help maintain diversity

---

### 2. GA Algorithm Structure

```
Initialize population
Evaluate fitness
while termination condition not met:
    Select parents
    Apply crossover
    Apply mutation
    Evaluate offspring
    Form new population
end
Return best solution
```

This structure is directly reflected in the MATLAB code organization, where each operator is implemented as a separate `.m` function.

---

### 3. Main GA Parameters

| Parameter           | Description               | Typical Values       |
| ------------------- | ------------------------- | -------------------- |
| Population Size (N) | Number of individuals     | 20 – 200             |
| Max Generations     | Stopping criterion        | 50 – 1000            |
| Crossover Rate (Pc) | Probability of crossover  | 0.6 – 0.9            |
| Mutation Rate (Pm)  | Probability of mutation   | 0.001 – 0.1          |
| Selection Method    | Parent selection strategy | Roulette, Tournament |
| Encoding            | Solution representation   | Binary / Real-valued |

---

### 4. Strengths & Weaknesses

**Advantages**

* Global search capability
* Works with non-differentiable functions
* Highly flexible

**Disadvantages**

* Can be slow to converge
* Parameter tuning is critical
* May lose diversity without proper mutation

---

## 🐦 Particle Swarm Optimization (PSO) – MATLAB Implementation

### 1. Basic Idea

PSO is inspired by **social behavior** of birds or fish. Each particle represents a candidate solution and moves through the search space based on:

* Its own experience (personal best)
* The experience of the swarm (global best)

Unlike GA, PSO does **not** use crossover or mutation.

---

### 2. PSO Algorithm Structure

```
Initialize particles (position & velocity)
Evaluate fitness
Update personal bests
Update global best
while termination condition not met:
    Update velocities
    Update positions
    Evaluate fitness
    Update personal & global bests
end
Return global best solution
```

---

### 3. Velocity Update Equation

```
v = w*v + c1*r1*(pbest - x) + c2*r2*(gbest - x)
x = x + v
```

Where:

* `w` : inertia weight
* `c1` : cognitive coefficient
* `c2` : social coefficient
* `r1, r2` : random numbers in [0,1]

---

### 4. Main PSO Parameters

| Parameter          | Description                      | Typical Values    |
| ------------------ | -------------------------------- | ----------------- |
| Swarm Size         | Number of particles              | 20 – 100          |
| Inertia Weight (w) | Balance exploration/exploitation | 0.4 – 0.9         |
| c1 (Cognitive)     | Self-confidence                  | ~1.5 – 2          |
| c2 (Social)        | Swarm confidence                 | ~1.5 – 2          |
| Velocity Limits    | Prevent explosion                | Problem-dependent |
| Max Iterations     | Stopping criterion               | 100 – 1000        |

---

### 5. Strengths & Weaknesses

**Advantages**

* Simple to implement
* Fast convergence
* Few parameters compared to GA

**Disadvantages**

* Can get trapped in local minima
* Sensitive to parameter tuning
* Less diversity than GA

---

## 🧪 Test Functions

The repository includes common benchmark functions:

* Sphere
* Rastrigin
* Rosenbrock
* Ackley

These functions help evaluate convergence speed, stability, and robustness.

---

## 📊 Results & Visualization

* Convergence curves
* Best fitness per iteration
* Parameter sensitivity analysis (when applicable)

Plots are stored in the `results/` directory.

---

## 🚀 How to Use (MATLAB)

1. Clone the repository from GitHub
2. Choose an algorithm folder (GA or PSO)
3. Set parameters in the main script
4. Run the main file
5. Analyze convergence plots

---

## 🎯 Educational Focus

This repository prioritizes:

* **Readability over extreme performance**
* **Clear mapping between theory and code**
* **Well-commented, modular implementations**

---

## 📌 Future Work

* Hybrid GA–PSO
* Constraint handling techniques
* Multi-objective optimization (NSGA-II, MOPSO)
* Adaptive parameter control

---

## 👤 Author

**Mohammad Mahdi Khaligh**
Optimization & Control / Evolutionary Algorithms (MATLAB)

