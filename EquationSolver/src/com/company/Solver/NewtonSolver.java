package com.company.Solver;

import com.company.Operation.Operation;

public class NewtonSolver implements Solver {

    private double firstCoord;
    private double epsilon;

    public NewtonSolver(double firstCoord, double epsilon) {
        this.firstCoord = firstCoord;
        this.epsilon = epsilon;
    }

    @Override
    public double findRoot(Operation equation) {
        Operation derivative = equation.derivate();
        double result = firstCoord;
        double prev = result - 1;
        while (Math.abs(result - prev) > epsilon) {
            prev = result;
            result = result - (equation.solve(result)) / (derivative.solve(result));
        }
        return result;
    }
}
