package com.company.Solver;

import com.company.Operation.Operation;

public class ChordSolver implements Solver {

    private double firstCoord;
    private double secondCoord;
    private double epsilon;

    public ChordSolver(double firstCoord, double secondCoord, double epsilon) {
        this.firstCoord = firstCoord;
        this.secondCoord = secondCoord;
        this.epsilon = epsilon;
    }

    public double findRoot(Operation equation) {
        double prev = firstCoord;
        double current = secondCoord;
        while (Math.abs(current - prev) > epsilon) {
            double newPrev = current;
            current = prev - (equation.solve(prev) * (current - prev)) / (equation.solve(current) - equation.solve(prev));
            prev = newPrev;
        }
        return current;
    }
}
