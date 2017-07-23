function[Index]=sus(SelCant,Sumvector) 
% [Index]=sus(SelCant,Sumvector) 
% sus:  Stocastic Universal Sampling method. Use as an alternative to
%       roullete wheel selection to choose a sample of SelCant points according to a distribution for
%       different type of samples
% INPUTS
% SelCant: Number of samples
% Sumvector: Cumulative distribution of an original distribution specifying
%            the probability associated to each class.
% OUTPUTS
%  Index:   Index(i) specifies to which class sample i belongs to, where
%           the number of classes is size(Sumvector,2)
%
% EXAMPLE
%         [Index]=sus(10,[0.8,1.0]): Choose 10 samples from two classes.
%         The first with probability 0.8, the second with probability 0.2
% 
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  

aux=rand(1,1);

toadd=1/SelCant;

cant=1;

while cant<=SelCant
 count=1;
  while aux>Sumvector(count) 
   count=count+1;
  end
  Index(cant)=count;
  cant=cant+1;
  aux=aux+toadd;
  if aux>1
   aux=aux-1;
  end
end

torandomize = randperm(SelCant);
Index = Index(torandomize);
return

