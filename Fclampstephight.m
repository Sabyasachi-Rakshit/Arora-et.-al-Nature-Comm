function Fclampstephight
% Date- 10.01.2020 by JPH-SR-NA
% to determine the step height of unfolding in force clamp, careful to change the
% height no(line134) if stop the program in between,and it will not give
% the name of file with measured height of a force curve.
clear 'all'
close 'all'
fclose 'all'
folder = 'G:\AFM_NISHA\Dimer-Dimer23May\peg5000\StepHieght calcn\0.03\multiplemodified\Heightchecked1';
cd(folder);
mkdir(folder,'Heightchecked');
mkdir(folder,'reject');

di=dir('mod_**.txt');
l_time = zeros(length(di),15);
height = zeros(length(di),15);
force = zeros(length(di),15);
for i=1:length(di);
    clear time0 l x y x2 y2 k1 i2
    name=di(i).name;
    l = load(name);
    x = (l(:,4));
    y = (l(:,3));
    x2 = (l(:,1));% height
    y2 = (l(:,3));
    %y4 = (l(:,4));
    H_f=figure;
    set(H_f,'PaperUnits','centimeters')
    xSize = 400;  ySize = 350;
    xLeft = (400-xSize)/3;  yTop = (1000-ySize)/3;
    set(H_f,'position',[xLeft yTop xSize ySize])
    plot(x2,y2,'.-k');
    title(name)
    xlabel('height')
    ylabel('force(pN)')
    zoom on
    H_k=figure;
    set(H_k,'position',[xLeft+xSize yTop xSize ySize])
    plot(x,x2,'.-k');
    xlabel('time')
    zoom on
    ylabel('height measured')
    H_g= figure;
    set(H_g,'position',[xLeft+xSize+xSize yTop xSize ySize])
    plot(x,y2,'.-k');
    xlabel('time')
    ylabel('force')
    
    zoom on;
    pause
    zoom off;
     k1=input('enter the operation code(1=copyfile, 2=reject):');
    switch k1;
        case 1;
           disp('accept');
    delete (H_f);
    delete(H_k);
    delete(H_g);
    %     k1 = input ('Enter the operation code (1=single, 2=double, 3=three, 4=four, 5=five):')
    k1 = input('Enter the number of unfolding observed:');
    for i2=1:k1
        clear dcm_obj c_info d_info dcm_obj1 d_info z
        H_f = figure;
        set(H_f,'position',[xLeft yTop xSize ySize])
        plot(x,x2,'.-k');
        title(name)
        xlabel('time');
        ylabel('height');
        zoom on;
        H_g= figure;
        set(H_g,'position',[xLeft+xSize+xSize yTop xSize ySize])
        plot(x,y2,'.-k');
        xlabel('time')
        ylabel('force')
        zoom on;
        pause
        zoom off;
        dcm_obj = datacursormode(H_g); %H_f
        set(dcm_obj, 'enable', 'on')
        pause
        % do disable data cursor mode use
        set(dcm_obj, 'enable', 'off')
        c_info = getCursorInfo(dcm_obj);
        zoom on
        pause
        zoom off
        % enable data cursor mode
        dcm_obj1 = datacursormode(H_g); %H_f
        set(dcm_obj1, 'enable', 'on')
        pause
        % do disable data cursor mode use
        set(dcm_obj1, 'enable', 'off')
        d_info = getCursorInfo(dcm_obj1);
%          z=(c_info.DataIndex):(d_info.DataIndex);
%          force (i,i2) = mean(y2(z));
           force(i,i2) = y2(c_info.DataIndex);
        if i2 == 1
            %             force (i) = mean(y2(z));
            time0 = c_info.Position(:,1);   %here (:,1)implies the x value of c info
        end
        
        l_time(i,i2)=d_info.Position(:,1)-time0;
        height(i,i2)= x2(d_info.DataIndex)-x2(c_info.DataIndex);
        delete(H_f)
        delete(H_g)
    end
    %     delete(H_f)
    %     delete(H_g)
    %                     height=((x2(c_info.DataIndex))-(x2(d_info.DataIndex)));
    data = horzcat(force,l_time,height);
    %     namel = name(end-10:end);
    
        movefile(name,'G:\AFM_NISHA\Dimer-Dimer23May\peg5000\StepHieght calcn\0.03\multiplemodified\Heightchecked1\Heightchecked');
    
    dlmwrite('Height_force.txt',data,'delimiter','\t','precision',6);
    %     fprintf(fidn1, '%s %f %f\n',namel, l_time,height);
    case 2;
            delete(H_f);
%             delete (H_l);
            delete (H_g);
            disp('reject');
            movefile(name,'G:\AFM_NISHA\Dimer-Dimer23May\peg5000\StepHieght calcn\0.03\multiplemodified\Heightchecked1\reject');
    end
    
end
end







