#pragma once

#include <iostream>

using namespace std;

namespace myPhysics {
	struct SolverParameter {
		double alpha;
		double beta;

		double dt;

		SolverParameter(
			double alpha_hat = 3.46, 
			double beta_hat = 3.78, 
			double dt = 1. / 6000
		){
			this->alpha = alpha_hat / dt;
			this->beta = beta_hat / dt / dt;

			this->dt = dt;
		};
	};
};