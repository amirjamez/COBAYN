function bnet = mk_insur_bnet()
%
%

node = struct('Age', 1, ...
              'SocioEcon', 2, ...
              'GoodStudent', 3, ...
              'RiskAversion', 4, ...
              'VehicleYear', 5, ...
              'MakeModel', 6, ...
              'Antilock', 7, ...
              'Mileage', 8, ...
              'SeniorTrain', 9, ...
              'DrivingSkill', 10, ...
              'DrivQuality', 11, ...
              'Accident', 12, ...
              'RuggedAuto', 13, ...
              'ThisCarDam', 14, ...
              'CarValue', 15, ...
              'AntiTheft', 16, ...
              'HomeBase', 17, ...
              'Theft', 18, ...
              'ThisCarCost', 19, ...
              'OtherCarCost', 20, ...
              'PropCost', 21, ...
              'OtherCar', 22, ...
              'Airbag', 23, ...
              'Cushioning', 24, ...
              'MedCost', 25, ...
              'ILiCost', 26, ...
              'DrivHist', 27);

adjacency = zeros(27);
adjacency([node.Age], node.SocioEcon) = 1;
adjacency([node.SocioEcon node.Age], node.GoodStudent) = 1;
adjacency([node.SocioEcon node.Age], node.RiskAversion) = 1;
adjacency([node.RiskAversion node.SocioEcon], node.VehicleYear) = 1;
adjacency([node.RiskAversion node.SocioEcon], node.MakeModel) = 1;
adjacency([node.MakeModel node.VehicleYear], node.Antilock) = 1;
adjacency([node.RiskAversion node.Age], node.SeniorTrain) = 1;
adjacency([node.SeniorTrain node.Age], node.DrivingSkill) = 1;
adjacency([node.DrivingSkill node.RiskAversion], node.DrivQuality) = 1;
adjacency([node.DrivQuality node.Mileage node.Antilock], node.Accident) = 1;
adjacency([node.MakeModel node.VehicleYear], node.RuggedAuto) = 1;
adjacency([node.RuggedAuto node.Accident], node.ThisCarDam) = 1;
adjacency([node.Mileage node.MakeModel node.VehicleYear], node.CarValue) = 1;
adjacency([node.RiskAversion node.SocioEcon], node.AntiTheft) = 1;
adjacency([node.RiskAversion node.SocioEcon], node.HomeBase) = 1;
adjacency([node.HomeBase node.AntiTheft node.CarValue], node.Theft) = 1;
adjacency([node.Theft node.CarValue node.ThisCarDam], node.ThisCarCost) = 1;
adjacency([node.RuggedAuto node.Accident], node.OtherCarCost) = 1;
adjacency([node.OtherCarCost node.ThisCarCost], node.PropCost) = 1;
adjacency([node.SocioEcon], node.OtherCar) = 1;
adjacency([node.MakeModel node.VehicleYear], node.Airbag) = 1;
adjacency([node.Airbag node.RuggedAuto], node.Cushioning) = 1;
adjacency([node.Cushioning node.Accident node.Age], node.MedCost) = 1;
adjacency([node.Accident], node.ILiCost) = 1;
adjacency([node.DrivingSkill node.RiskAversion], node.DrivHist) = 1;

value = {{'Adolescent'; 'Adult'; 'Senior'}, ...
         {'Prole'; 'Middle'; 'UpperMiddle'; 'Wealthy'}, ...
         {'True'; 'False'}, ...
         {'Psychopath'; 'Adventurous'; 'Normal'; 'Cautious'}, ...
         {'Current'; 'Older'}, ...
         {'SportsCar'; 'Economy'; 'FamilySedan'; 'Luxury'; 'SuperLuxury'}, ...
         {'True'; 'False'}, ...
         {'FiveThou'; 'TwentyThou'; 'FiftyThou'; 'Domino'}, ...
         {'True'; 'False'}, ...
         {'SubStandard'; 'Normal'; 'Expert'}, ...
         {'Poor'; 'Normal'; 'Excellent'}, ...
         {'None'; 'Mild'; 'Moderate'; 'Severe'}, ...
         {'EggShell'; 'Football'; 'Tank'}, ...
         {'None'; 'Mild'; 'Moderate'; 'Severe'}, ...
         {'FiveThou'; 'TenThou'; 'TwentyThou'; 'FiftyThou'; 'Million'}, ...
         {'True'; 'False'}, ...
         {'Secure'; 'City'; 'Suburb'; 'Rural'}, ...
         {'True'; 'False'}, ...
         {'Thousand'; 'TenThou'; 'HundredThou'; 'Million'}, ...
         {'Thousand'; 'TenThou'; 'HundredThou'; 'Million'}, ...
         {'Thousand'; 'TenThou'; 'HundredThou'; 'Million'}, ...
         {'True'; 'False'}, ...
         {'True'; 'False'}, ...
         {'Poor'; 'Fair'; 'Good'; 'Excellent'}, ...
         {'Thousand'; 'TenThou'; 'HundredThou'; 'Million'}, ...
         {'Thousand'; 'TenThou'; 'HundredThou'; 'Million'}, ...
         {'Zero'; 'One'; 'Many'}};

bnet = mk_bnet(adjacency, [3 4 2 4 2 5 2 4 2 3 3 4 3 4 5 2 4 2 4 4 4 2 2 4 4 4 3]);
bnet.CPD{node.Age} = tabular_CPD(bnet, node.Age, [0.2 0.6 0.2]);
bnet.CPD{node.SocioEcon} = tabular_CPD(bnet, node.SocioEcon, [0.4 0.4 0.5 0.4 0.4 0.2 0.19 0.19 0.29 0.01 0.01 0.01]);
bnet.CPD{node.GoodStudent} = tabular_CPD(bnet, node.GoodStudent, [0.1 0.4 0 0 0.2 0 0 0 0.5 0 0 0 0.9 0.6 1 1 0.8 1 1 1 0.5 1 1 1]);
bnet.CPD{node.RiskAversion} = tabular_CPD(bnet, node.RiskAversion, [0.02 0.015 0.01 0.02 0.015 0.01 0.02 0.015 0.01 0.02 0.015 0.01 0.58 0.285 0.09 0.38 0.185 0.04 0.48 0.285 0.09 0.58 0.285 0.09 0.3 0.5 0.4 0.5 0.6 0.35 0.4 0.5 0.4 0.3 0.4 0.4 0.1 0.2 0.5 0.1 0.2 0.6 0.1 0.2 0.5 0.1 0.3 0.5]);
bnet.CPD{node.VehicleYear} = tabular_CPD(bnet, node.VehicleYear, [0.15 0.3 0.8 0.9 0.15 0.3 0.8 0.9 0.15 0.3 0.8 0.9 0.15 0.3 0.8 0.9 0.85 0.7 0.2 0.1 0.85 0.7 0.2 0.1 0.85 0.7 0.2 0.1 0.85 0.7 0.2 0.1]);
bnet.CPD{node.MakeModel} = tabular_CPD(bnet, node.MakeModel, [0.1 0.15 0.2 0.3 0.1 0.15 0.2 0.3 0.1 0.15 0.2 0.3 0.1 0.15 0.2 0.3 0.7 0.2 0.05 0.01 0.7 0.2 0.05 0.01 0.7 0.2 0.05 0.01 0.7 0.2 0.05 0.01 0.2 0.65 0.3 0.09 0.2 0.65 0.3 0.09 0.2 0.65 0.3 0.09 0.2 0.65 0.3 0.09 0 0 0.45 0.4 0 0 0.45 0.4 0 0 0.45 0.4 0 0 0.45 0.4 0 0 0 0.2 0 0 0 0.2 0 0 0 0.2 0 0 0 0.2]);
bnet.CPD{node.Antilock} = tabular_CPD(bnet, node.Antilock, [0.9 0.4 0.99 0 0.3 0.001 0.99 0.1 0 0.15 0.1 0.6 0.01 1 0.7 0.999 0.01 0.9 1 0.85]);
bnet.CPD{node.Mileage} = tabular_CPD(bnet, node.Mileage, [0.1 0.4 0.4 0.1]);
bnet.CPD{node.SeniorTrain} = tabular_CPD(bnet, node.SeniorTrain, [0 0 0.000001 0 0 0.000001 0 0 0.3 0 0 0.9 1 1 0.999999 1 1 0.999999 1 1 0.7 1 1 0.1]);
bnet.CPD{node.DrivingSkill} = tabular_CPD(bnet, node.DrivingSkill, [0.5 0.3 0.1 0.5 0.3 0.4 0.45 0.6 0.6 0.45 0.6 0.5 0.05 0.1 0.3 0.05 0.1 0.1]);
bnet.CPD{node.DrivQuality} = tabular_CPD(bnet, node.DrivQuality, [1 0.3 0 0.5 0.01 1 0.3 1 0 1 0 0 0 0.4 0 0.2 0.01 0 0.2 0 0.8 0 1 0 0 0.3 1 0.3 0.98 0 0.5 0 0.2 0 0 1]);
bnet.CPD{node.Accident} = tabular_CPD(bnet, node.Accident, [0.7 0.6 0.4 0.3 0.3 0.2 0.2 0.1 0.99 0.98 0.98 0.96 0.97 0.95 0.95 0.94 0.999 0.995 0.995 0.99 0.99 0.98 0.985 0.98 0.2 0.2 0.3 0.2 0.3 0.2 0.2 0.1 0.007 0.01 0.01 0.02 0.02 0.03 0.03 0.03 0.0007 0.003 0.003 0.007 0.007 0.01 0.01 0.01 0.07 0.1 0.2 0.2 0.2 0.2 0.3 0.3 0.002 0.005 0.005 0.015 0.007 0.015 0.01 0.02 0.0002 0.001 0.001 0.002 0.002 0.005 0.003 0.007 0.03 0.1 0.1 0.3 0.2 0.4 0.3 0.5 0.001 0.005 0.005 0.005 0.003 0.005 0.01 0.01 0.0001 0.001 0.001 0.001 0.001 0.005 0.002 0.003]);
bnet.CPD{node.RuggedAuto} = tabular_CPD(bnet, node.RuggedAuto, [0.95 0.2 0.05 0.9 0.1 0.5 0.1 0.95 0.05 0.05 0.04 0.6 0.55 0.1 0.6 0.5 0.6 0.04 0.55 0.55 0.01 0.2 0.4 0 0.3 0 0.3 0.01 0.4 0.4]);
bnet.CPD{node.ThisCarDam} = tabular_CPD(bnet, node.ThisCarDam, [1 0.001 0.000001 0.000001 1 0.2 0.001 0.000001 1 0.7 0.05 0.05 0 0.9 0.000999 0.000009 0 0.75 0.099 0.000999 0 0.29 0.6 0.2 0 0.098 0.7 0.00009 0 0.049999 0.8 0.009 0 0.009999 0.3 0.2 0 0.001 0.299 0.9999 0 0.000001 0.1 0.99 0 0.000001 0.05 0.55]);
bnet.CPD{node.CarValue} = tabular_CPD(bnet, node.CarValue, [0 0.1 0 0 0.01 0.000001 0 0.1 0.7 0.5 0.05 0.000001 0 0.4 0.99 0.7 0 0 0 0.9 0 0.03 0.25 0.2 0 0 0 0.16 0 0.1 0 0 0.1 0.000001 0 0.1 0.999998 0.99 0.2 0.000001 0.1 0.8 0.1 0 0.09 0.000001 0.1 0.8 0.2999 0.3 0.15 0.000001 0 0.47 0.009999 0.2 0.1 0 0 0.06 0 0.3 0.7 0.3 0.1 0 0 0.5 0.1 0.8 0.1 0 0.3 0.000001 0.1 0.8 0.000001 0.009999 0.2 0.000001 0.8 0.1 0.9 0 0.2 0.000001 0.8 0.1 0.0001 0.2 0.3 0.000001 0 0.1 0.000001 0.1 0.9 0 0 0.02 0 0.6 0.05 0.5 0.9 0 0 0.3 0.8 0.1 0.9 0 0.3 0.000001 0.8 0.1 0.000001 0.000001 0.3 0.000001 0.09 0 0 1 0.7 0.000001 0.09 0 0 0 0.5 0.000001 0 0.02 0 0 0 1 0 0.01 0 0.06 0 0 0 1 0 0.03 0.09 0 0 1 0.3 0.000001 0.09 0 0 0 0.3 0.000001 0.01 0 0 0 0 0.999996 0.01 0 0 0 0 0.999996 1 0.01 0 0 0 0 1 0.01 1 0.01 0 0 0 0 1 0.01 0.01 0 0 0 0 0.999996 0.01 0 0 0 0 0.999996]);
bnet.CPD{node.AntiTheft} = tabular_CPD(bnet, node.AntiTheft, [0.000001 0.000001 0.05 0.5 0.000001 0.000001 0.2 0.5 0.1 0.3 0.9 0.8 0.95 0.999999 0.999999 0.999999 0.999999 0.999999 0.95 0.5 0.999999 0.999999 0.8 0.5 0.9 0.7 0.1 0.2 0.05 0.000001 0.000001 0.000001]);
bnet.CPD{node.HomeBase} = tabular_CPD(bnet, node.HomeBase, [0.000001 0.15 0.35 0.489999 0.000001 0.01 0.2 0.95 0.000001 0.299999 0.5 0.85 0.000001 0.95 0.999997 0.999997 0.8 0.8 0.6 0.5 0.8 0.25 0.4 0.000001 0.8 0.000001 0.000001 0.000001 0.8 0.000001 0.000001 0.000001 0.049999 0.04 0.04 0.000001 0.05 0.6 0.3 0.000001 0.05 0.6 0.4 0.001 0.05 0.024445 0.000001 0.000001 0.15 0.01 0.01 0.01 0.149999 0.14 0.1 0.049998 0.149999 0.1 0.099999 0.148999 0.149999 0.025554 0.000001 0.000001]);
bnet.CPD{node.Theft} = tabular_CPD(bnet, node.Theft, [0.000001 0.00001 0.002 0.0001 0.0003 0.000002 0.00005 0.000001 0.000001 0.00001 0.005 0.000003 0.0005 0.005 0.0002 0.000001 0.0005 0.00001 0.0001 0.000003 0.00005 0.01 0.000001 0.000001 0.001 0.000002 0.0002 0.005 0.0002 0.0003 0.000001 0.000001 0.00001 0.000002 0.00002 0.01 0.000002 0.0005 0.000001 0.000001 0.999999 0.99999 0.998 0.9999 0.9997 0.999998 0.99995 0.999999 0.999999 0.99999 0.995 0.999997 0.9995 0.995 0.9998 0.999999 0.9995 0.99999 0.9999 0.999997 0.99995 0.99 0.999999 0.999999 0.999 0.999998 0.9998 0.995 0.9998 0.9997 0.999999 0.999999 0.99999 0.999998 0.99998 0.99 0.999998 0.9995 0.999999 0.999999]);
bnet.CPD{node.ThisCarCost} = tabular_CPD(bnet, node.ThisCarCost, [0.2 0.15 0.05 0.03 0.05 0.03 0.01 0.000001 0.04 0.03 0.001 0.000001 0.04 0.03 0.001 0.000001 0.04 0.02 0.001 0.000001 1 0.95 0.25 0.05 1 0.95 0.15 0.01 1 0.99 0.01 0.005 1 0.99 0.005 0.001 1 0.98 0.003 0.000001 0.8 0.85 0.95 0.97 0.95 0.97 0.99 0.999999 0.01 0.02 0.001 0.000001 0.01 0.02 0.001 0.000001 0.01 0.03 0.001 0.000001 0 0.05 0.75 0.95 0 0.05 0.85 0.99 0 0.01 0.01 0.005 0 0.01 0.005 0.001 0 0.01 0.003 0.000001 0 0 0 0 0 0 0 0 0.95 0.95 0.998 0.999998 0.95 0.95 0.998 0.999998 0.2 0.25 0.018 0.009998 0 0 0 0 0 0 0 0 0 0 0.98 0.99 0 0 0.99 0.998 0 0.01 0.044 0.029998 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.75 0.7 0.98 0.99 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.95 0.97]);
bnet.CPD{node.OtherCarCost} = tabular_CPD(bnet, node.OtherCarCost, [1 0.99 0.6 0.2 1 0.98 0.5 0.1 1 0.95 0.4 0.005 0 0.005 0.2 0.4 0 0.01 0.2 0.5 0 0.03 0.3 0.55 0 0.00499 0.19998 0.39996 0 0.009985 0.29997 0.39994 0 0.01998 0.29996 0.4449 0 0.00001 0.00002 0.00004 0 0.00005 0.00003 0.00006 0 0.00002 0.00004 0.0001]);
bnet.CPD{node.PropCost} = tabular_CPD(bnet, node.PropCost, [0.7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.3 0.95 0 0 0.95 0.6 0 0 0 0 0 0 0 0 0 0 0 0.05 0.98 0 0.05 0.4 0.95 0 0.98 0.8 0.6 0 0 0 0 0 0 0 0.02 1 0 0 0.05 1 0.02 0.2 0.4 1 1 1 1 1]);
bnet.CPD{node.OtherCar} = tabular_CPD(bnet, node.OtherCar, [0.5 0.8 0.9 0.95 0.5 0.2 0.1 0.05]);
bnet.CPD{node.Airbag} = tabular_CPD(bnet, node.Airbag, [1 1 1 0.05 0.6 1 1 0.1 0.2 0.1 0 0 0 0.95 0.4 0 0 0.9 0.8 0.9]);
bnet.CPD{node.Cushioning} = tabular_CPD(bnet, node.Cushioning, [0.5 0 0 0.7 0.1 0 0.3 0.1 0 0.3 0.6 0 0.2 0.6 0 0 0.3 0.7 0 0.3 1 0 0 0.3]);
bnet.CPD{node.MedCost} = tabular_CPD(bnet, node.MedCost, [1 0.96 0.5 0.3 1 0.98 0.8 0.5 1 0.99 0.95 0.9 1 0.999 0.99 0.95 1 0.96 0.5 0.3 1 0.98 0.8 0.5 1 0.99 0.95 0.9 1 0.999 0.99 0.95 1 0.9 0.3 0.2 1 0.95 0.5 0.3 1 0.97 0.9 0.6 1 0.99 0.95 0.9 0 0.03 0.2 0.3 0 0.019 0.15 0.2 0 0.0099 0.02 0.07 0 0.00099 0.007 0.03 0 0.03 0.2 0.3 0 0.019 0.15 0.2 0 0.0099 0.02 0.07 0 0.00099 0.007 0.03 0 0.07 0.3 0.2 0 0.04 0.2 0.3 0 0.025 0.07 0.3 0 0.007 0.03 0.05 0 0.009 0.2 0.2 0 0.0009 0.03 0.2 0 0.00009 0.02 0.02 0 0.000009 0.002 0.01 0 0.009 0.2 0.2 0 0.0009 0.03 0.2 0 0.00009 0.02 0.02 0 0.000009 0.002 0.01 0 0.02 0.2 0.3 0 0.007 0.2 0.2 0 0.003 0.02 0.07 0 0.002 0.01 0.03 0 0.001 0.1 0.2 0 0.0001 0.02 0.1 0 0.00001 0.01 0.01 0 0.000001 0.001 0.01 0 0.001 0.1 0.2 0 0.0001 0.02 0.1 0 0.00001 0.01 0.01 0 0.000001 0.001 0.01 0 0.01 0.2 0.3 0 0.003 0.1 0.2 0 0.002 0.01 0.03 0 0.001 0.01 0.02]);
bnet.CPD{node.ILiCost} = tabular_CPD(bnet, node.ILiCost, [1 0.999 0.9 0.8 0 0.000998 0.05 0.1 0 0.000001 0.03 0.06 0 0.000001 0.02 0.04]);
bnet.CPD{node.DrivHist} = tabular_CPD(bnet, node.DrivHist, [0.001 0.5 0.99 0.1 0.6 0.3 0.3 0.03 0.95 0.002 0.9 0.999998 0.004 0.3 0.009999 0.3 0.3 0.3 0.3 0.15 0.04 0.008 0.07 0.000001 0.995 0.2 0.000001 0.6 0.1 0.4 0.4 0.82 0.01 0.99 0.03 0.000001]);
