function [xapp,yapp,xtest,ytest,appind,testind] = shufflemulticlass(x,y,apprate,u,h)

if nargin<4
	u = unique(y);
end%if
if nargin<5
	for i=1:length(u)
		ind{i} = find(y==u(i));
		h(i) = length(ind{i});
	end%for
end%if
if ~exist('ind')
	for i=1:length(u)
		ind{i} = find(y==u(i));
	end%for
end%if

appind = [];
testind = [];
for i=1:length(h)
	appsizei = round(h(i)*apprate);
	%indi = find(y==u(i));
	indi = ind{i};
	indi = indi(randperm(h(i)));
	appind =  [appind; indi(1:appsizei)];
	if appsizei<h(i)
		testind = [testind; indi(appsizei+1:h(i))];
	end%if
end%for

appind = appind(randperm(length(appind)));
testind = testind(randperm(length(testind)));

xapp = x(appind,:);
yapp = y(appind);
xtest = x(testind,:);
ytest = y(testind);

end%function
