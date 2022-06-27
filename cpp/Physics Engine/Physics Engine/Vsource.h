#pragma once
#include <functional>

#include "Constraint.h"

using namespace std;

namespace myPhysics {
    class Vsource : public Constraint {
    public:
        using ft = function<double(double)>;
    public:
        Vsource(initializer_list<int>, const ft& V, const ft& dV, const ft& d2V);



        // Constraint을(를) 통해 상속됨
        virtual double getConstraint(const myPhysics::Constraint::vd& mapped_state) override;

        virtual myPhysics::Constraint::vd getGradient(const myPhysics::Constraint::vd& mapped_state);

        virtual myPhysics::Constraint::vd getHessian(const myPhysics::Constraint::vd& mapped_state);

    private:
        ft V;
        ft dV;
        ft d2V;
    };
}
