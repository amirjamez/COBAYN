function luck = chisquare_lucky(chi2, fre)
%
% Q_{x2,d} = [2^{d}*gamma(d)]^{-1} \int_{x2}^{inf} t^{d-1}exp(-t/2)dt
%   gamma(x) = \int_{0}^{inf} t^{x-1}exp(-t/2)dt
%

tiny = exp(-700);

%luck = 2^(-fre/2) * gammainc(chi2/2,fre/2);
luck = 2^(-fre/2)*gammainc(chi2/2,fre/2) + tiny;
%P = gammainc(X2/2, v/2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function b = gammainc(x,a)
%GAMMAINC Incomplete gamma function.
%   Y = GAMMAINC(X,A) evaluates the incomplete gamma function for
%   corresponding elements of X and A.  X and A must be real and the same
%   size (or either can be a scalar).  A must also be non-negative.
%   The incomplete gamma function is defined as: 
%
%    gammainc(x,a) = 1 ./ gamma(a) .*
%       integral from 0 to x of t^(a-1) exp(-t) dt
%
%   For any a>=0, as x approaches infinity, gammainc(x,a) approaches 1.
%   For small x and a, gammainc(x,a) ~= x^a, so gammainc(0,0) = 1.
%
%   See also GAMMA, GAMMALN.

%   Copyright 1984-2001 The MathWorks, Inc. 
%   $Revision: 5.15 $  $Date: 2001/04/15 12:01:47 $

% x and a must be compatible for addition.

try
   b = zeros(size(x + a));
catch
   error('X and A must be the same size, or scalars.')
end
if any(a < 0)
   error('A must be non-negative.')
end

% If a is a vector, make sure x is too.

ascalar = (max(size(a)) == 1);
if ~ascalar & (max(size(x)) == 1)
   x = x(ones(size(a)));
end

% Upper limit for series and continued fraction.

amax = 2^20;
if all(a <= amax)

   % Series expansion for x < a+1

   k = find(a ~= 0 & x ~= 0 & x < a+1);
   if ~isempty(k)
      xk = x(k);
      if ascalar, ak = a; else, ak = a(k); end
      ap = ak;
      sum = 1./ap;
      del = sum;
      while norm(del,'inf') >= 100*eps*norm(sum,'inf')
         ap = ap + 1;
         del = xk .* del ./ ap;
         sum = sum + del;
      end
      b(k) = sum .* exp(-xk + ak.*log(xk) - gammaln(ak));
   end

   % Continued fraction for x >= a+1

   k = find(a ~= 0 & x ~= 0 & x >= a+1);
   if ~isempty(k)
      xk = x(k);
      a0 = ones(size(k));
      a1 = x(k);
      b0 = zeros(size(k));
      b1 = a0;
      if ascalar, ak = a; else, ak = a(k); end
      fac = 1;
      n = 1;
      g = b1;
      gold = b0;
      while norm(g-gold,'inf') >= 100*eps*norm(g,'inf');
         gold = g;
         ana = n - ak;
         a0 = (a1 + a0 .*ana) .* fac;
         b0 = (b1 + b0 .*ana) .* fac;
         anf = n*fac;
         a1 = xk .* a0 + anf .* a1;
         b1 = xk .* b0 + anf .* b1;
         fac = 1 ./ a1;
         g = b1 .* fac;
         n = n + 1;
      end
      b(k) = 1 - exp(-xk + ak.*log(xk) - gammaln(ak)) .* g;
   end

   k = find(x == 0);
   if ~isempty(k)
      b(k) = 0;
   end
   k = find(a == 0 & ones(size(x)));
   if ~isempty(k)
      b(k) = 1;
   end

else

   % Approximation for a > amax.  Accurate to about 5.e-5.

   if ascalar
      x = max(amax-1/3 + sqrt(amax/a).*(x-(a-1/3)),0);
      b = gammainc(x,amax);
   else
      k = find(a > amax);
      x(k) = max(amax-1/3 + sqrt(amax./a(k)).*(x(k)-(a(k)-1/3)),0);
      a(k) = amax;
      b = gammainc(x,a);
   end

end
