#pragma once
#include <iostream>
#include <vector>

#include "Solver.h"

using namespace std;

namespace myPhysics {
	class Constraint
	{
	public:
		using vd = vector<double>;
	public:
		Constraint(vector<int> state_mapping) : state_mapping(state_mapping) {};
		Constraint(initializer_list<int> list) : state_mapping(list) {};

		double getGamma(const vd& state, const vd& dstate, const SolverParameter& param);

		vector<double> getMappedState(const vd& state);

		// virtual function
		virtual double getConstraint(const vd& mapped_state) = 0;
		virtual vd getGradient(const vd& mapped_state) = 0;
		virtual vd getHessian(const vd& mapped_state) = 0;
	protected:
		vector<int> state_mapping;
	
	private:
		double lambda;
		double dlambda;

		vd grad;
	};
};
