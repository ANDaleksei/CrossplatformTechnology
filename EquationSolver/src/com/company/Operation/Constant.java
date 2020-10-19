package com.company.Operation;

public class Constant implements Operation {

    private double constant;

    public Constant(double number) {
        this.constant = number;
    }

    @Override
    public double solve(double var) {
        return constant;
    }

    @Override
    public Operation derivate() {
        return new Constant(0);
    }

    @Override
    public String description() {
        return "" + constant;
    }
}
