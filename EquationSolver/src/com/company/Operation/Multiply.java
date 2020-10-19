package com.company.Operation;

public class Multiply implements Operation {

    private Operation lhs;
    private Operation rhs;

    public Multiply(Operation lhs, Operation rhs) {
        this.lhs = lhs;
        this.rhs = rhs;
    }

    @Override
    public double solve(double var) {
        return lhs.solve(var) * rhs.solve(var);
    }

    @Override
    public Operation derivate() {
        return new Add(new Multiply(lhs, rhs.derivate()), new Multiply(lhs.derivate(), rhs));
    }

    @Override
    public String description() {
        return lhs.description() + " * " + rhs.description();
    }
}
