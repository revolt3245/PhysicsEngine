#include "Vsource.h"

namespace myPhysics {
	Vsource::Vsource(initializer_list<int> list, const function<double(double)>& V, const function<double(double)>& dV, const function<double(double)>& d2V)
		:Constraint(list)
	{
		this->V = V;
		this->dV = dV;
		this->d2V = d2V;
	}

	double Vsource::getConstraint(const myPhysics::Constraint::vd& mapped_state) {
		return mapped_state[1] - mapped_state[2] - this->V(mapped_state[0]);
	}
	myPhysics::Constraint::vd Vsource::getGradient(const myPhysics::Constraint::vd& mapped_state) {
		vd res(3);

		res[0] = -this->dV(mapped_state[0]);
		res[1] = 1;
		res[2] = -1;

		return res;
	}
	myPhysics::Constraint::vd Vsource::getHessian(const myPhysics::Constraint::vd& mapped_state) {
		vd res(9);

		res[0] = -this->d2V(mapped_state[0]);

		return res;
	}
}