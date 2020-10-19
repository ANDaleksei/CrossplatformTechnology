package com.company.Operation;

import java.lang.Math;

public class Power implements Operation {

    private Operation lhs;
    private Operation rhs;

    public Power(Operation lhs, Operation rhs) {
        this.lhs = lhs;
        this.rhs = rhs;
    }

    @Override
    public double solve(double var) {
        return Math.pow(lhs.solve(var), rhs.solve(var));
    }

    @Override
    public Operation derivate() {
        if (rhs instanceof Constant) {
            double value = rhs.solve(0);
            return new Multiply(new Multiply(new Constant(value), new Power(lhs, new Constant(value - 1))), lhs.derivate());
        } else if (lhs instanceof Constant && rhs instanceof Variable) {
            return new Multiply(new Constant(Math.log(lhs.solve(0))), new Power(lhs, rhs));
        } else {
            throw new RuntimeException();
        }
    }

    @Override
    public String description() {
        return lhs.description() + "^(" + rhs.description() + ")";
    }
}
