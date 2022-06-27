#include "Constraint.h"

namespace myPhysics {
	double Constraint::getGamma(const vector<double>& state, const vector<double>& dstate, const SolverParameter& param) {
		// size
		auto mapped_size = this->state_mapping.size();

		// parameter
		auto alpha = param.alpha;
		auto beta = param.beta;

		// state mapping
		auto mapped_state = this->getMappedState(state);
		auto mapped_dstate = this->getMappedState(dstate);

		// constraint
		auto phi = this->getConstraint(mapped_state);
		auto gradient = this->getGradient(mapped_state);
		auto hessian = this->getHessian(mapped_state);

		// derivate of constraint
		double dphi = 0.0;
		double d2phi = 0.0;

		for (size_t i = 0; i < mapped_size; i++) {
			for (size_t j = 0; j < mapped_size; j++) {
				size_t idx = i * mapped_size + j;
				d2phi += hessian[idx] * mapped_dstate[i] * mapped_dstate[j];
			}

			dphi += gradient[i] * mapped_dstate[i];
		}

		//gamma
		double gamma = -d2phi - alpha * dphi - beta * phi;

		return gamma;
	}

	vector<double> Constraint::getMappedState(const vector<double>& state) {
		auto mapping_size = this->state_mapping.size();
		vector<double> res(mapping_size);

		for (size_t i = 0; i < mapping_size; i++) {
			res[i] = state[this->state_mapping[i]];
		}

		return res;
	}
}