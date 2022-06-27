#include <iostream>

#include "Vsource.h"

using namespace std;
using namespace myPhysics;

int main() {
	// solver param
	auto param = SolverParameter();

	// state
	vector<double> X(3), dX(3);
	X[1] = 5;

	// constraint
	auto V = [](double t)->double { return 5; };
	auto dV = [](double t)->double { return 0; };
	auto d2V = [](double t)->double { return 0; };
	Vsource test({ 0, 1, 2 }, V, dV, d2V);

	cout << test.getGamma(X, dX, param) << endl;
	return 0;
}