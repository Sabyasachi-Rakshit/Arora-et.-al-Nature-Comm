function Fclamp_sorting_new
% Date- 26/09/2016-   SG
% Before running this program please check the clamping force and standard
% deviation for one force curve and then give the multiplication factor
% according to that value
clear 'all';
close 'all';
% global out;
fclose('all');
folder='H:\CDHPCDH CATCH DATA\May2021\9thJuly2021Cdh12Pcdh12mediumLR200nmps\0.12_processed-2021.07.12-20.12.12\processed_curves-2021.07.12-20.12.12_processed-2021.07.12-22.50.18\processed_curves-2021.07.12-22.50.18';
cd(folder);
mkdir(folder,'selectedcurves');
mkdir(folder,'noevents');
mkdir(folder,'orgselcurves')
di=dir('force**.txt');
for i=1:length(di);
    clear s A str n n2;
    name=di(i).name;
    fprintf(1,'%s %s\n','analyzing file : ',name);
    %Reading 1st loading rate
    fid=fopen(name);
    fid1=fopen(tempname, 'w+');
    for i1=1:16;
        fgetl(fid); %gets rid of the 16 header lines
    end
    for n=1:50000
        s=fgets(fid); %reads all the ASCII forceruns
        fwrite(fid1,s); %write all the forceruns to a temp file
    end
    fclose(fid);
    frewind(fid1);
    A1=fscanf(fid1,'%f %f %f %f %f',[5 inf]);
    A1=A1';
    la = length(A1(:,5));
    fid2=fopen(name);
    fid2a=fopen(tempname, 'w+');
    for i2=1:la+16+8
        fgetl(fid2); %gets rid of the header lines
    end
    for n2=1:50000
        s2=fgets(fid2); %reads all the ASCII forceruns
        fwrite(fid2a,s2); %write all the forceruns to a temp file
    end
    fclose(fid2);
    frewind(fid2a);
    A2=fscanf(fid2a,'%f %f %f %f %f',[5 inf]);
    A2=A2';
    lb = length(A2(:,5));
    fid3=fopen(name);
    fid3a=fopen(tempname, 'w+');
    for i3 = 1:16+la+lb+8+8
        fgetl(fid3); %gets rid of the header lines
    end
    for n3=1:50000
        s3=fgets(fid3);
        fwrite(fid3a,s3);
    end
    fclose(fid3);
    frewind(fid3a);
    A3=fscanf(fid3a,'%f %f %f %f %f',[5 inf]);
    fclose(fid3a);
    A3=A3';
    lc=length(A3(:,5));
    fid4=fopen(name);
    fid4a=fopen(tempname, 'w+');
    for i4 = 1:16+la+lb+lc+8+8+8
        fgetl(fid4); %gets rid of the header lines
    end
    for n4=1:100000
        s4=fgets(fid4);
        fwrite(fid4a,s4);
    end
    fclose(fid4);
    frewind(fid4a);
    A4=fscanf(fid4a,'%f %f %f %f %f',[5 inf]);
    fclose(fid4a);
    A4=A4';
    ld=length(A4(:,5));
    fid5=fopen(name);
    fid5a=fopen(tempname, 'w+');
    for i5 = 1:16+la+lb+lc+ld+8+8+8+8
        fgetl(fid5); %gets rid of the header lines
    end
    for n5=1:200000
        s5=fgets(fid5);
        fwrite(fid5a,s5);
    end
    fclose(fid5);
    frewind(fid5a);
    A5=fscanf(fid5a,'%f %f %f %f %f',[5 inf]);
    fclose(fid5a);
    A5=A5';
    le=length(A5(:,5));
    fid6=fopen(name);
    fid6a=fopen(tempname, 'w+');
    for i6 = 1:16+la+lb+lc+ld+le+8+8+8+8+8
        fgetl(fid6); %gets rid of the header lines
    end
    for n6=1:50000
        s6=fgets(fid6);
        fwrite(fid6a,s6);
    end
    fclose(fid6);
    frewind(fid6a);
    A6=fscanf(fid6a,'%f %f %f %f %f',[5 inf]);
    fclose(fid6a);
    A6=A6';
        cat=vertcat(A1,A2,A3,A4,A5);
        cat(:,2) = cat(:,2)*(10^12);
    cat=vertcat(A1,A2,A3,A4,A5,A6);
    cat(:,2) = cat(:,2)*(10^12);
    x=cat(:,4);
    %     y=cat(:,2);
    x2=cat(:,1);
    y2=cat(:,2);
    dpts = y2(end-20:end);
    S= std(dpts);
    I = y2<-3*S;
    Y1= y2(I);
    if (Y1)
        data = nan*ones(length(x2),3);
        data(:,1) = x; %%time
        %          data(:,2) = y;
        data(:,2) = x2.*(10^9); %% tipsample distance
        data(:,3) = y2;  %%force
        name2=strcat('FC 0.12',name(end-20:end));
        dlmwrite(name2,data,'delimiter','\t')
        movefile(name2,'H:\CDHPCDH CATCH DATA\May2021\9thJuly2021Cdh12Pcdh12mediumLR200nmps\0.12_processed-2021.07.12-20.12.12\processed_curves-2021.07.12-20.12.12_processed-2021.07.12-22.50.18\processed_curves-2021.07.12-22.50.18\selectedcurves') ;
        movefile(name,'H:\CDHPCDH CATCH DATA\May2021\9thJuly2021Cdh12Pcdh12mediumLR200nmps\0.12_processed-2021.07.12-20.12.12\processed_curves-2021.07.12-20.12.12_processed-2021.07.12-22.50.18\processed_curves-2021.07.12-22.50.18\orgselcurves')
    else
        movefile(name,'H:\CDHPCDH CATCH DATA\May2021\9thJuly2021Cdh12Pcdh12mediumLR200nmps\0.12_processed-2021.07.12-20.12.12\processed_curves-2021.07.12-20.12.12_processed-2021.07.12-22.50.18\processed_curves-2021.07.12-22.50.18\noevents') ;
    end
    %delete H_f;
    fclose 'all';
end
end
