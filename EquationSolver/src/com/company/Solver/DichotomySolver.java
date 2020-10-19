package com.company.Solver;

import com.company.Operation.Operation;

public class DichotomySolver implements Solver {

    private double leftBorder;
    private double rightBorder;
    private double epsilon;

    public DichotomySolver(double leftBorder, double rightBorder, double epsilon) {
        this.leftBorder = leftBorder;
        this.rightBorder = rightBorder;
        this.epsilon = epsilon;
    }

    @Override
    public double findRoot(Operation equation) {
        double a = leftBorder;
        double b = rightBorder;
        while ((b - a) > epsilon) {
            double newBorder = (a + b) / 2;
            if ((equation.solve(b) * equation.solve(newBorder)) < 0) {
                a = newBorder;
            } else {
                b = newBorder;
            }
        }
        return (a + b) / 2;
    }
}
