package com.company.Operation;

public class Divide implements Operation {

    private Operation lhs;
    private Operation rhs;

    public Divide(Operation lhs, Operation rhs) {
        this.lhs = lhs;
        this.rhs = rhs;
    }

    @Override
    public double solve(double var) {
        return lhs.solve(var) / rhs.solve(var);
    }

    @Override
    public Operation derivate() {
        Operation left = new Multiply(lhs.derivate(), rhs);
        Operation right = new Multiply(lhs, rhs.derivate());
        Operation up = new Minus(left, right);
        Operation down = new Power(rhs, new Constant(2));
        return new Divide(up, down);
    }

    @Override
    public String description() {
        return lhs.description() + " / " + rhs.description();
    }
}
