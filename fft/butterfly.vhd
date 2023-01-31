library ieee, ieee_proposed;
use ieee.std_logic_1164.all;
use ieee.math_complex_f.all;
use ieee_proposed.fixed_pkg.all;




entity butterfly is
	port(Ek, Ok : in COMPLEX_F;
		  twiddle_fact : in COMPLEX_F;
		  Xk0, Xk1 : out COMPLEX_F);
end entity;


architecture arc of butterfly is 
	begin 
		Xk0 <= Ek + twiddle_fact * Ok;
		Xk1 <= Ek - twiddle_fact * Ok;
end;