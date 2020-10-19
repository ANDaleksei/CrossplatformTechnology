package com.company.Operation;

public class Variable implements Operation {

    @Override
    public double solve(double x) {
        return x;
    }

    @Override
    public Operation derivate() {
        return new Constant(1);
    }

    @Override
    public String description() {
        return "x";
    }
}
