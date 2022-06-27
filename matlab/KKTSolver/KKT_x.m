function x = KKT_x(Mi, AMi, AMA, Q, R)
XQ = Mi - AMi'/AMA*AMi;
XR = AMA\AMi';

x = XQ*Q + XR*R;
end