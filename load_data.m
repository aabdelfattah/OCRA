files = dir('*.txt');
for i=1:length(files)
    eval(['pic = load (''' files(i).name ''');']);
    [l,w] = size(pic);
    x = pic(:,2);
    y = pic(:,1);
    g = zeros(1600,2560);
    for j = 1 : l 
        if(x(j)==0)
            x(j)= x(j) + 1;
        end
        if(y(j)==0)
            y(j)= y(j) + 1;
        end
        g(x(j),y(j)) = 1; 
    end
    imwrite(g,strcat(files(i).name,'.png'));
end