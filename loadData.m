function [all_data] = loadData(filepath, filetype)

  filepath = dir('Data/*.csv');
  %tmp = csvread('Data\2021-07-30-Glycine - 0V B - Batch A.csv');

if (filetype== 'csv')

  for i = 1:length(filepath)
    all_data{i} = csvread([filepath(i).folder, '\', filepath(i).name]);
  end

else
  throw error('Wrong filetype. Eat a potato');
end

end
