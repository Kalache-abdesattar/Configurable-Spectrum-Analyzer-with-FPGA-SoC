library ieee, ieee_proposed;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee_proposed.fixed_float_types.all;
use ieee_proposed.fixed_pkg.all;
use WORK.MATH_REAL.all;


package MATH_COMPLEX_F is
  constant CopyRightNotice : STRING
    := "Copyright 2008 IEEE. All rights reserved.";

  --
  -- Type Definitions
  --
  type COMPLEX_F is
  record
    RE : sfixed(8 downto -7);                          -- Signed Fixed Real part
    IM : sfixed(8 downto -7);                       -- Imaginary part
  end record;
  
    type COMPLEX_F_OUT is
  record
    RE : sfixed(8 downto -8);                          -- Signed Fixed Real part
    IM : sfixed(8 downto -8);                       -- Imaginary part
  end record;

  
  type COMPLEX_F_array is array(0 to 15) of COMPLEX_F;
  
  type COMPLEX is
  record
    RE : REAL;                          -- Real part
    IM : REAL;                          -- Imaginary part
  end record;
  
  subtype POSITIVE_REAL is REAL range 0.0 to REAL'high;

  subtype PRINCIPAL_VALUE is REAL range -MATH_PI to MATH_PI;

  type COMPLEX_POLAR_F is
  record
    MAG : ufixed(8 downto -7);                -- Magnitude
    ARG : sfixed(8 downto -7);  -- Angle in radians; -MATH_PI is illegal
  end record;

  --
  -- Constant Definitions
  --
  constant MATH_CBASE_1 : COMPLEX := COMPLEX'(1.0, 0.0);
  constant MATH_CBASE_J : COMPLEX := COMPLEX'(0.0, 1.0);
  constant MATH_CZERO   : COMPLEX := COMPLEX'(0.0, 0.0);


  --
  -- Overloaded equality and inequality operators for COMPLEX_POLAR
  -- (equality and inequality operators for COMPLEX are predefined)
  --

  function "=" (L : in COMPLEX_POLAR; R : in COMPLEX_POLAR) return BOOLEAN;
  -- Purpose:
  --         Returns TRUE if L is equal to R and returns FALSE otherwise
  -- Special values:
  --         COMPLEX_POLAR'(0.0, X) = COMPLEX_POLAR'(0.0, Y) returns TRUE
  --         regardless of the value of X and Y.
  -- Domain:
  --         L in COMPLEX_POLAR and L.ARG /= -MATH_PI
  --         R in COMPLEX_POLAR and R.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if L.ARG = -MATH_PI
  --         Error if R.ARG = -MATH_PI
  -- Range:
  --         "="(L,R) is either TRUE or FALSE
  -- Notes:
  --         None

  function "/=" (L : in COMPLEX_POLAR; R : in COMPLEX_POLAR) return BOOLEAN;
  -- Purpose:
  --         Returns TRUE if L is not equal to R and returns FALSE
  --         otherwise
  -- Special values:
  --         COMPLEX_POLAR'(0.0, X) /= COMPLEX_POLAR'(0.0, Y) returns
  --         FALSE regardless of the value of X and Y.
  -- Domain:
  --         L in COMPLEX_POLAR and L.ARG /= -MATH_PI
  --         R in COMPLEX_POLAR and R.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if L.ARG = -MATH_PI
  --         Error if R.ARG = -MATH_PI
  -- Range:
  --         "/="(L,R) is either TRUE or FALSE
  -- Notes:
  --         None

  --
  -- Function Declarations
  --
  function CMPLX(X : in REAL; Y : in REAL := 0.0) return COMPLEX;
  -- Purpose:
  --         Returns COMPLEX number X + iY
  -- Special values:
  --         None
  -- Domain:
  --         X in REAL
  --         Y in REAL
  -- Error conditions:
  --         None
  -- Range:
  --         CMPLX(X,Y) is mathematically unbounded
  -- Notes:
  --         None

  function GET_PRINCIPAL_VALUE(X : in REAL) return PRINCIPAL_VALUE;
  -- Purpose:
  --         Returns principal value of angle X; X in radians
  -- Special values:
  --         None
  -- Domain:
  --         X in REAL
  -- Error conditions:
  --         None
  -- Range:
  --         -MATH_PI < GET_PRINCIPAL_VALUE(X) <= MATH_PI
  -- Notes:
  --         None

  function COMPLEX_TO_POLAR(Z : in COMPLEX) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns principal value COMPLEX_POLAR of Z
  -- Special values:
  --         COMPLEX_TO_POLAR(MATH_CZERO) = COMPLEX_POLAR'(0.0, 0.0)
  --         COMPLEX_TO_POLAR(Z) = COMPLEX_POLAR'(ABS(Z.IM),
  --                              SIGN(Z.IM)*MATH_PI_OVER_2) if Z.RE = 0.0
  -- Domain:
  --         Z in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function POLAR_TO_COMPLEX(Z : in COMPLEX_POLAR) return COMPLEX;
  -- Purpose:
  --         Returns COMPLEX value of Z
  -- Special values:
  --         None
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  -- Range:
  --         POLAR_TO_COMPLEX(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "ABS"(Z : in COMPLEX) return POSITIVE_REAL;
  -- Purpose:
  --         Returns absolute value (magnitude) of Z
  -- Special values:
  --         None
  -- Domain:
  --         Z in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         ABS(Z) is mathematically unbounded
  -- Notes:
  --         ABS(Z) = SQRT(Z.RE*Z.RE + Z.IM*Z.IM)

  function "ABS"(Z : in COMPLEX_POLAR) return POSITIVE_REAL;
  -- Purpose:
  --         Returns absolute value (magnitude) of Z
  -- Special values:
  --         None
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  -- Range:
  --         ABS(Z) >= 0.0
  -- Notes:
  --         ABS(Z) = Z.MAG

  function ARG(Z : in COMPLEX) return PRINCIPAL_VALUE;
  -- Purpose:
  --         Returns argument (angle) in radians of the principal
  --         value of Z
  -- Special values:
  --         ARG(Z) = 0.0 if Z.RE >= 0.0 and Z.IM = 0.0
  --         ARG(Z) = SIGN(Z.IM)*MATH_PI_OVER_2 if Z.RE = 0.0
  --         ARG(Z) = MATH_PI if Z.RE < 0.0        and Z.IM = 0.0
  -- Domain:
  --         Z in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         -MATH_PI < ARG(Z) <= MATH_PI
  -- Notes:
  --         ARG(Z) = ARCTAN(Z.IM, Z.RE)

  function ARG(Z : in COMPLEX_POLAR) return PRINCIPAL_VALUE;
  -- Purpose:
  --         Returns argument (angle) in radians of the principal
  --         value of Z
  -- Special values:
  --         None
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  -- Range:
  --         -MATH_PI < ARG(Z) <= MATH_PI
  -- Notes:
  --         ARG(Z) = Z.ARG


  function "-" (Z : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns unary minus of Z
  -- Special values:
  --         None
  -- Domain:
  --         Z in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         "-"(Z) is mathematically unbounded
  -- Notes:
  --         Returns -x -jy for Z= x + jy

  function "-" (Z : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns principal value of unary minus of Z
  -- Special values:
  --         "-"(Z) = COMPLEX_POLAR'(Z.MAG, MATH_PI) if Z.ARG = 0.0
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         Returns COMPLEX_POLAR'(Z.MAG, Z.ARG - SIGN(Z.ARG)*MATH_PI) if
  --                Z.ARG /= 0.0

  function CONJ (Z : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns complex conjugate of Z
  -- Special values:
  --         None
  -- Domain:
  --         Z in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         CONJ(Z) is mathematically unbounded
  -- Notes:
  --         Returns x -jy for Z= x + jy

  function CONJ (Z : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns principal value of complex conjugate of Z
  -- Special values:
  --         CONJ(Z) = COMPLEX_POLAR'(Z.MAG, MATH_PI) if Z.ARG = MATH_PI
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         Returns COMPLEX_POLAR'(Z.MAG, -Z.ARG) if Z.ARG /= MATH_PI

  function SQRT(Z : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns square root of Z with positive real part
  --         or, if the real part is zero, the one with nonnegative
  --         imaginary part
  -- Special values:
  --         SQRT(MATH_CZERO) = MATH_CZERO
  -- Domain:
  --         Z in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         SQRT(Z) is mathematically unbounded
  -- Notes:
  --         None

  function SQRT(Z : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns square root of Z with positive real part
  --         or, if the real part is zero, the one with nonnegative
  --         imaginary part
  -- Special values:
  --         SQRT(Z) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG = 0.0
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function EXP(Z : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns exponential of Z
  -- Special values:
  --         EXP(MATH_CZERO) = MATH_CBASE_1
  --         EXP(Z) = -MATH_CBASE_1 if Z.RE = 0.0 and ABS(Z.IM) = MATH_PI
  --         EXP(Z) = SIGN(Z.IM)*MATH_CBASE_J if Z.RE = 0.0 and
  --                                          ABS(Z.IM) =  MATH_PI_OVER_2
  -- Domain:
  --         Z in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         EXP(Z) is mathematically unbounded
  -- Notes:
  --         None



  function EXP(Z : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns principal value of exponential of Z
  -- Special values:
  --         EXP(Z) = COMPLEX_POLAR'(1.0, 0.0) if Z.MAG =0.0 and
  --                                                        Z.ARG = 0.0
  --         EXP(Z) = COMPLEX_POLAR'(1.0, MATH_PI) if Z.MAG = MATH_PI and
  --                                        ABS(Z.ARG) = MATH_PI_OVER_2
  --         EXP(Z) = COMPLEX_POLAR'(1.0, MATH_PI_OVER_2) if
  --                                        Z.MAG = MATH_PI_OVER_2 and
  --                                        Z.ARG = MATH_PI_OVER_2
  --         EXP(Z) = COMPLEX_POLAR'(1.0, -MATH_PI_OVER_2) if
  --                                        Z.MAG = MATH_PI_OVER_2 and
  --                                        Z.ARG = -MATH_PI_OVER_2
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function LOG(Z : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns natural logarithm of Z
  -- Special values:
  --         LOG(MATH_CBASE_1) = MATH_CZERO
  --         LOG(-MATH_CBASE_1) = COMPLEX'(0.0, MATH_PI)
  --         LOG(MATH_CBASE_J) = COMPLEX'(0.0, MATH_PI_OVER_2)
  --         LOG(-MATH_CBASE_J) = COMPLEX'(0.0, -MATH_PI_OVER_2)
  --         LOG(Z) = MATH_CBASE_1 if Z = COMPLEX'(MATH_E, 0.0)
  -- Domain:
  --         Z in COMPLEX and ABS(Z) /= 0.0
  -- Error conditions:
  --         Error if ABS(Z) = 0.0
  -- Range:
  --         LOG(Z) is mathematically unbounded
  -- Notes:
  --         None

  function LOG2(Z : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns logarithm base 2 of Z
  -- Special values:
  --         LOG2(MATH_CBASE_1) = MATH_CZERO
  --         LOG2(Z) = MATH_CBASE_1 if Z = COMPLEX'(2.0, 0.0)
  -- Domain:
  --         Z in COMPLEX and ABS(Z) /= 0.0
  -- Error conditions:
  --         Error if ABS(Z) = 0.0
  -- Range:
  --         LOG2(Z) is mathematically unbounded
  -- Notes:
  --         None

  function LOG10(Z : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns logarithm base 10 of Z
  -- Special values:
  --         LOG10(MATH_CBASE_1) = MATH_CZERO
  --         LOG10(Z) = MATH_CBASE_1 if Z = COMPLEX'(10.0, 0.0)
  -- Domain:
  --         Z in COMPLEX and ABS(Z) /= 0.0
  -- Error conditions:
  --         Error if ABS(Z) = 0.0
  -- Range:
  --         LOG10(Z) is mathematically unbounded
  -- Notes:
  --         None

  function LOG(Z : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns principal value of natural logarithm of Z
  -- Special values:
  --         LOG(Z) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG = 1.0 and
  --                                             Z.ARG = 0.0
  --         LOG(Z) = COMPLEX_POLAR'(MATH_PI, MATH_PI_OVER_2) if
  --                              Z.MAG = 1.0 and Z.ARG = MATH_PI
  --         LOG(Z) = COMPLEX_POLAR'(MATH_PI_OVER_2, MATH_PI_OVER_2) if
  --                              Z.MAG = 1.0 and  Z.ARG = MATH_PI_OVER_2
  --         LOG(Z) = COMPLEX_POLAR'(MATH_PI_OVER_2, -MATH_PI_OVER_2) if
  --                              Z.MAG = 1.0 and  Z.ARG = -MATH_PI_OVER_2
  --         LOG(Z) = COMPLEX_POLAR'(1.0, 0.0) if Z.MAG = MATH_E and
  --                                             Z.ARG = 0.0
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  --         Z.MAG /= 0.0
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  --         Error if Z.MAG = 0.0
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function LOG2(Z : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns principal value of logarithm base 2 of Z
  -- Special values:
  --         LOG2(Z) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG = 1.0 and
  --                                              Z.ARG = 0.0
  --         LOG2(Z) = COMPLEX_POLAR'(1.0, 0.0) if Z.MAG = 2.0 and
  --                                             Z.ARG = 0.0
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  --         Z.MAG /= 0.0
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  --         Error if Z.MAG = 0.0
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --        None

  function LOG10(Z : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns principal value of logarithm base 10 of Z
  -- Special values:
  --         LOG10(Z) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG = 1.0 and
  --                                               Z.ARG = 0.0
  --         LOG10(Z) = COMPLEX_POLAR'(1.0, 0.0) if Z.MAG = 10.0 and
  --                                               Z.ARG = 0.0
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  --         Z.MAG /= 0.0
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  --         Error if Z.MAG = 0.0
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function LOG(Z : in COMPLEX; BASE : in REAL) return COMPLEX;
  -- Purpose:
  --         Returns logarithm base BASE of Z
  -- Special values:
  --         LOG(MATH_CBASE_1, BASE) = MATH_CZERO
  --         LOG(Z,BASE) = MATH_CBASE_1 if Z = COMPLEX'(BASE, 0.0)
  -- Domain:
  --         Z in COMPLEX and ABS(Z) /= 0.0
  --         BASE > 0.0
  --         BASE /= 1.0
  -- Error conditions:
  --         Error if ABS(Z) = 0.0
  --         Error if BASE <= 0.0
  --         Error if BASE = 1.0
  -- Range:
  --         LOG(Z,BASE) is mathematically unbounded
  -- Notes:
  --         None

  function LOG(Z : in COMPLEX_POLAR; BASE : in REAL) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns principal value of logarithm base BASE of Z
  -- Special values:
  --         LOG(Z, BASE) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG = 1.0 and
  --                                                Z.ARG = 0.0
  --         LOG(Z, BASE) = COMPLEX_POLAR'(1.0, 0.0) if Z.MAG = BASE and
  --                                                Z.ARG = 0.0
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  --         Z.MAG /= 0.0
  --         BASE > 0.0
  --         BASE /= 1.0
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  --         Error if Z.MAG = 0.0
  --         Error if BASE <= 0.0
  --         Error if BASE = 1.0
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function SIN (Z : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns sine of Z
  -- Special values:
  --         SIN(MATH_CZERO) = MATH_CZERO
  --         SIN(Z) = MATH_CZERO if Z = COMPLEX'(MATH_PI, 0.0)
  -- Domain:
  --         Z in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         ABS(SIN(Z)) <= SQRT(SIN(Z.RE)*SIN(Z.RE) +
  --                                         SINH(Z.IM)*SINH(Z.IM))
  -- Notes:
  --         None

  function SIN (Z : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns principal value of sine of Z
  -- Special values:
  --         SIN(Z) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG = 0.0 and
  --                                            Z.ARG = 0.0
  --         SIN(Z) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG = MATH_PI and
  --                                            Z.ARG = 0.0
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function COS (Z : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns cosine of Z
  -- Special values:
  --         COS(Z) = MATH_CZERO if Z = COMPLEX'(MATH_PI_OVER_2, 0.0)
  --         COS(Z) = MATH_CZERO if Z = COMPLEX'(-MATH_PI_OVER_2, 0.0)
  -- Domain:
  --         Z in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         ABS(COS(Z)) <= SQRT(COS(Z.RE)*COS(Z.RE) +
  --                                         SINH(Z.IM)*SINH(Z.IM))
  -- Notes:
  --         None


  function COS (Z : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns principal value of cosine of Z
  -- Special values:
  --         COS(Z) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG = MATH_PI_OVER_2
  --                                               and Z.ARG = 0.0
  --         COS(Z) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG = MATH_PI_OVER_2
  --                                               and Z.ARG = MATH_PI
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function SINH (Z : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns hyperbolic sine of Z
  -- Special values:
  --         SINH(MATH_CZERO) = MATH_CZERO
  --         SINH(Z) = MATH_CZERO if Z.RE = 0.0 and Z.IM = MATH_PI
  --         SINH(Z) = MATH_CBASE_J if Z.RE = 0.0 and
  --                                               Z.IM = MATH_PI_OVER_2
  --         SINH(Z) = -MATH_CBASE_J if Z.RE = 0.0 and
  --                                               Z.IM = -MATH_PI_OVER_2
  -- Domain:
  --         Z in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         ABS(SINH(Z)) <= SQRT(SINH(Z.RE)*SINH(Z.RE) +
  --                                         SIN(Z.IM)*SIN(Z.IM))
  -- Notes:
  --         None

  function SINH (Z : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns principal value of hyperbolic sine of Z
  -- Special values:
  --         SINH(Z) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG = 0.0 and
  --                                            Z.ARG = 0.0
  --         SINH(Z) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG = MATH_PI and
  --                                            Z.ARG = MATH_PI_OVER_2
  --         SINH(Z) = COMPLEX_POLAR'(1.0, MATH_PI_OVER_2) if Z.MAG =
  --                         MATH_PI_OVER_2 and Z.ARG = MATH_PI_OVER_2
  --         SINH(Z) = COMPLEX_POLAR'(1.0, -MATH_PI_OVER_2) if Z.MAG =
  --                         MATH_PI_OVER_2 and Z.ARG = -MATH_PI_OVER_2
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function COSH (Z : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns hyperbolic cosine of Z
  -- Special values:
  --         COSH(MATH_CZERO) = MATH_CBASE_1
  --         COSH(Z) = -MATH_CBASE_1 if Z.RE = 0.0 and Z.IM = MATH_PI
  --         COSH(Z) = MATH_CZERO if Z.RE = 0.0 and Z.IM = MATH_PI_OVER_2
  --         COSH(Z) = MATH_CZERO if Z.RE = 0.0 and Z.IM = -MATH_PI_OVER_2
  -- Domain:
  --         Z in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         ABS(COSH(Z)) <= SQRT(SINH(Z.RE)*SINH(Z.RE) +
  --                                         COS(Z.IM)*COS(Z.IM))
  -- Notes:
  --         None


  function COSH (Z : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns principal value of hyperbolic cosine of Z
  -- Special values:
  --         COSH(Z) = COMPLEX_POLAR'(1.0, 0.0) if Z.MAG = 0.0 and
  --                                            Z.ARG = 0.0
  --         COSH(Z) = COMPLEX_POLAR'(1.0, MATH_PI) if Z.MAG = MATH_PI and
  --                                            Z.ARG = MATH_PI_OVER_2
  --         COSH(Z) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG =
  --                        MATH_PI_OVER_2 and Z.ARG = MATH_PI_OVER_2
  --         COSH(Z) = COMPLEX_POLAR'(0.0, 0.0) if Z.MAG =
  --                        MATH_PI_OVER_2 and Z.ARG = -MATH_PI_OVER_2
  -- Domain:
  --         Z in COMPLEX_POLAR and Z.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if Z.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  --
  -- Arithmetic Operators
  --
  
  function "+" (L : in COMPLEX_F; R : in COMPLEX_F) return COMPLEX_F;
  -- Purpose:
  --         Returns arithmetic addition of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX
  --         R in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         "+"(Z) is mathematically unbounded
  -- Notes:
  --         None
  
  
  
  function "+" (L : in COMPLEX; R : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns arithmetic addition of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX
  --         R in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         "+"(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "+" (L : in REAL; R : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns arithmetic addition of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in REAL
  --         R in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         "+"(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "+" (L : in COMPLEX; R : in REAL) return COMPLEX;
  -- Purpose:
  --         Returns arithmetic addition of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX
  --         R in REAL
  -- Error conditions:
  --         None
  -- Range:
  --         "+"(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "+" (L : in COMPLEX_POLAR; R : in COMPLEX_POLAR)
    return COMPLEX_POLAR;
  -- Purpose:
  --         Returns arithmetic addition of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX_POLAR and L.ARG /= -MATH_PI
  --         R in COMPLEX_POLAR and R.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if L.ARG = -MATH_PI
  --         Error if R.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None


  function "+" (L : in REAL; R : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns arithmetic addition of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in REAL
  --         R in COMPLEX_POLAR and R.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if R.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function "+" (L : in COMPLEX_POLAR; R : in REAL) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns arithmetic addition of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX_POLAR and L.ARG /= -MATH_PI
  --         R in REAL
  -- Error conditions:
  --         Error if L.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  
  function "-" (L : in COMPLEX_F; R : in COMPLEX_F) return COMPLEX_F;
  -- Purpose:
  --         Returns arithmetic subtraction of L minus R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX
  --         R in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         "-"(Z) is mathematically unbounded
  -- Notes:
  --         None

  
  function "-" (L : in COMPLEX; R : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns arithmetic subtraction of L minus R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX
  --         R in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         "-"(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "-" (L : in REAL; R : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns arithmetic subtraction of L minus R
  -- Special values:
  --         None
  -- Domain:
  --         L in REAL
  --         R in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         "-"(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "-" (L : in COMPLEX; R : in REAL) return COMPLEX;
  -- Purpose:
  --         Returns arithmetic subtraction of L minus R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX
  --         R in REAL
  -- Error conditions:
  --         None
  -- Range:
  --         "-"(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "-" (L : in COMPLEX_POLAR; R : in COMPLEX_POLAR)
    return COMPLEX_POLAR;
  -- Purpose:
  --         Returns arithmetic subtraction of L minus R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX_POLAR and L.ARG /= -MATH_PI
  --         R in COMPLEX_POLAR and R.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if L.ARG = -MATH_PI
  --         Error if R.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function "-" (L : in REAL; R : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns arithmetic subtraction of L minus R
  -- Special values:
  --         None
  -- Domain:
  --         L in REAL
  --         R in COMPLEX_POLAR and R.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if R.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None


  function "-" (L : in COMPLEX_POLAR; R : in REAL) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns arithmetic subtraction of L minus R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX_POLAR and L.ARG /= -MATH_PI
  --         R in REAL
  -- Error conditions:
  --         Error if L.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function "*" (L : in COMPLEX_F; R : in COMPLEX_F) return COMPLEX_F;
  
  
  
  
  
  
  function "*" (L : in COMPLEX; R : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns arithmetic multiplication of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX
  --         R in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         "*"(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "*" (L : in REAL; R : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns arithmetic multiplication of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in REAL
  --         R in COMPLEX
  -- Error conditions:
  --         None
  -- Range:
  --         "*"(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "*" (L : in COMPLEX; R : in REAL) return COMPLEX;
  -- Purpose:
  --         Returns arithmetic multiplication of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX
  --         R in REAL
  -- Error conditions:
  --         None

  -- Range:
  --         "*"(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "*" (L : in COMPLEX_POLAR; R : in COMPLEX_POLAR)
    return COMPLEX_POLAR;
  -- Purpose:
  --         Returns arithmetic multiplication of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX_POLAR and L.ARG /= -MATH_PI
  --         R in COMPLEX_POLAR and R.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if L.ARG = -MATH_PI
  --         Error if R.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function "*" (L : in REAL; R : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns arithmetic multiplication of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in REAL
  --         R in COMPLEX_POLAR and R.ARG /= -MATH_PI
  -- Error conditions:
  --         Error if R.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function "*" (L : in COMPLEX_POLAR; R : in REAL) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns arithmetic multiplication of L and R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX_POLAR and L.ARG /= -MATH_PI
  --         R in REAL
  -- Error conditions:
  --         Error if L.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None


  function "/" (L : in COMPLEX; R : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns arithmetic division of L by R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX
  --         R in COMPLEX and R /= MATH_CZERO
  -- Error conditions:
  --         Error if R = MATH_CZERO
  -- Range:
  --         "/"(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "/" (L : in REAL; R : in COMPLEX) return COMPLEX;
  -- Purpose:
  --         Returns arithmetic division of L by R
  -- Special values:
  --         None
  -- Domain:
  --         L in REAL
  --         R in COMPLEX and R /= MATH_CZERO
  -- Error conditions:
  --         Error if R = MATH_CZERO
  -- Range:
  --         "/"(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "/" (L : in COMPLEX; R : in REAL) return COMPLEX;
  -- Purpose:
  --         Returns arithmetic division of L by R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX
  --         R in REAL and R /= 0.0
  -- Error conditions:
  --         Error if R = 0.0
  -- Range:
  --         "/"(Z) is mathematically unbounded
  -- Notes:
  --         None

  function "/" (L : in COMPLEX_POLAR; R : in COMPLEX_POLAR)
    return COMPLEX_POLAR;
  -- Purpose:
  --         Returns arithmetic division of L by R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX_POLAR and L.ARG /= -MATH_PI
  --         R in COMPLEX_POLAR and R.ARG /= -MATH_PI
  --         R.MAG > 0.0
  -- Error conditions:
  --         Error if R.MAG <= 0.0
  --         Error if L.ARG = -MATH_PI
  --         Error if R.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function "/" (L : in REAL; R : in COMPLEX_POLAR) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns arithmetic division of L by R
  -- Special values:
  --         None
  -- Domain:
  --         L in REAL
  --         R in COMPLEX_POLAR and R.ARG /= -MATH_PI
  --         R.MAG > 0.0
  -- Error conditions:
  --         Error if R.MAG <= 0.0
  --         Error if R.ARG = -MATH_PI
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None

  function "/" (L : in COMPLEX_POLAR; R : in REAL) return COMPLEX_POLAR;
  -- Purpose:
  --         Returns arithmetic division of L by R
  -- Special values:
  --         None
  -- Domain:
  --         L in COMPLEX_POLAR and L.ARG /= -MATH_PI
  --         R /= 0.0
  -- Error conditions:
  --         Error if L.ARG = -MATH_PI
  --         Error if R = 0.0
  -- Range:
  --         result.MAG >= 0.0
  --         -MATH_PI < result.ARG <= MATH_PI
  -- Notes:
  --         None
end package MATH_COMPLEX_F;
