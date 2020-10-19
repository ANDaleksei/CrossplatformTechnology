package com.company;

import com.company.Operation.*;
import com.company.Solver.ChordSolver;
import com.company.Solver.DichotomySolver;
import com.company.Solver.NewtonSolver;
import com.company.Solver.Solver;

public class Main {

    private static double epsilon = 0.00001;

    public static void main(String[] args) {
        double epsilon = 0.00001;
        System.out.println("Check dichotomy method.");
        check(getFirstEquation(), new DichotomySolver(0, 2, epsilon));
        System.out.println("Check chord method.");
        check(getSecondEquation(), new ChordSolver(8, 3, epsilon));
        System.out.println("Check Newnton method.");
        check(getThirdEquation(), new NewtonSolver(0.6, epsilon));
    }

    private static void check(Operation equation, Solver solverMethod) {
        System.out.println("Equation: " + equation.description());
        double root = solverMethod.findRoot(equation);
        System.out.println("Root between 0 and 2 is: " + root);
        System.out.println(equation.description() + " ~= " +  equation.solve(root) + " when x = " + root);
    }

    // 4 - e^x - 2x^2
    private static Operation getFirstEquation() {
        Operation first = new Constant(4);
        Operation second = new Power(new Constant(Math.exp(1)), new Variable());
        Operation third = new Multiply(new Constant(2), new Power(new Variable(), new Constant(2)));
        return new Minus(new Minus(first, second), third);
    }

    // x^3 - 18x - 83
    private static Operation getSecondEquation() {
        Operation first = new Power(new Variable(), new Constant(3));
        Operation second = new Multiply(new Constant(18), new Variable());
        Operation third = new Constant(83);
        return new Minus(new Minus(first, second), third);
    }

    // e^x + 3x - 4
    private static Operation getThirdEquation() {
        Operation first = new Power(new Constant(Math.exp(1)), new Variable());
        Operation second = new Multiply(new Constant(3), new Variable());
        Operation third = new Constant(4);
        return new Minus(new Add(first, second), third);
    }
}
