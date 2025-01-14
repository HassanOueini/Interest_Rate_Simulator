# Interest_Rate_Simulator
The Interest Rate Simulation Models project provides MATLAB implementations for simulating interest rates using three widely-used stochastic models: the Vasicek model, the Cox-Ingersoll-Ross (CIR) model, and the Lognormal (Geometric Brownian Motion) model. These models are crucial for understanding the dynamics of interest rates, pricing fixed-income derivatives, and managing interest rate risk. Additionally, a test file is included to run and compare all three models together.

# Abstract
Interest rates are a huge factor when it comes to finance. They dictate how much you can borrow as an investor and what the market expects as a return on their investment. Modelling it and finding the future rates is a big factor to see if it's worth investing now or waiting. This project simulates and finds the potential interest rate in the future to help make better decisions. There are many different strategies and models, this code implements a handful of different simulators. Users can plug in their own values for variables and potentiall think of a decision or strategy.

## What It Does
This project simulates interest rate paths for the Vasicek, CIR, and Lognormal models and generates visualizations to illustrate their dynamics. Each model computes and plots the analytical mean, simulated mean, and several simulated paths. The test script combines the three models for side-by-side comparison under the same parameter settings.

## How to Modify It
To customize the simulations, adjust the following parameters in the code:

- **`r0`**: Initial short rate (e.g., `0.03` for 3%).
  - Represents the starting point of the interest rate.
- **`theta`**: Long-term mean reversion level.
  - Determines the equilibrium level to which rates revert.
- **`kappa`**: Speed of mean reversion.
  - Controls how quickly rates revert to the mean.
- **`sigma`**: Volatility of the interest rate.
  - Governs the magnitude of rate fluctuations.
- **`mu`** (Lognormal): Drift rate for the Lognormal model.
  - Specifies the expected growth rate of rates over time.
- **`T`**: Time horizon (in years).
  - Length of the simulation.
- **`N`**: Number of time steps.
  - Controls the granularity of the simulation.
- **`M`**: Number of simulation paths.
  - Defines how many independent paths are simulated.

These parameters can be adjusted in each simulator file or the test script.

## The Math Behind It

### 1. Vasicek Model:
The Vasicek model is described by the stochastic differential equation (SDE): 
$$dr_t = \kappa (\theta - r_t) dt + \sigma dW_t$$
- **Parameters**:
  - \( $\kappa$ \): Speed of mean reversion.
  - \( $\theta$ \): Long-term mean level.
  - \( $\sigma$ \): Volatility of the interest rate.
  - \( $dW_t$ \): Wiener process (Brownian motion).
- **Key Feature**: Rates revert to $\theta$ over time at a speed determined by $\kappa$.

### 2. Cox-Ingersoll-Ross (CIR) Model:
The CIR model modifies the Vasicek model to ensure non-negative rates:
$$dr_t = \kappa (\theta - r_t) dt + \sigma \sqrt{r_t} dW_t$$
- **Parameters**:
  - \( $\kappa$ \): Speed of mean reversion.
  - \( $\theta$ \): Long-term mean level.
  - \( $\sigma$ \): Volatility, scaled by \( $\sqrt{r_t}$ \).
  - \( $dW_t$ \): Wiener process.
- **Key Feature**: Ensures that non-negative interest rates, while still incorporating mean-reverting behavior.

### 3. Lognormal (Geometric Brownian Motion) Model:
This model assumes interest rates follow a geometric Brownian motion:
$$dr_t = \mu r_t dt + \sigma r_t dW_t$$
- **Parameters**:
  - \( $\mu$ \): Drift rate (expected growth).
  - \( $\sigma$ \): Volatility.
  - \( $dW_t$ \): Wiener process.
- **Key Feature**: Rates grow proportionally to their current value, making the model suitable for modeling exponentially growing quantities.

## Outputs
Each model produces the following outputs:

1. **Simulated Paths**:
   - Multiple interest rate paths are plotted to illustrate stochastic behavior over time.
2. **Analytical Mean**:
   - The expected value of the process is plotted as a dashed red line.
3. **Simulated Mean**:
   - The average of all simulated paths is plotted as a solid black line.

### Test Script Output
The test script runs all three models and visualizes them in separate plots for comparison. By analyzing the outputs, you can observe how each model behaves under the same parameters:
- **Vasicek Model**: Displays mean-reverting behavior with paths oscillating around the long-term mean \( $\theta$ \).
- **CIR Model**: Similar to Vasicek but ensures non-negative rates, with paths tending to revert to \( $\theta$ \).
- **Lognormal Model**: Displays exponential growth with volatility proportional to the current rate, leading to wider path divergence over time.

