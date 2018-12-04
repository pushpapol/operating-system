clc;
clear all;
close all;

% Plotting the given signals.......
t=0:0.0003:0.003;
y1=sin(3000*pi*t);
y2=cos(3000*pi*t);
y3=sin(3000*pi*t)+cos(3000*pi*t);
subplot(3,1,1);
plot(t,y1);
title('Signal -1');
ylabel('Amplitude--->');
xlabel('Time--->');
subplot(3,1,2);
plot(t,y2);
title('Signal 2');
ylabel('Amplitude--->');
xlabel('Time--->');
subplot(3,1,3);
plot(t,y3);
title('Signal 3');
ylabel('Amplitude--->');
xlabel('Time--->');
disp('samples of signal 1');
disp(y1);
disp('samples of signal 2');
disp(y2);
disp('samples of signal 3');
disp(y3);

mx(1,1)=max(y1);
mx(1,2)=max(y2);
mx(1,3)=max(y3);
m1=max(ma);
disp('max of all signals');
disp(m1);

mn(1,1)=min(y1);
mn(1,2)=min(y2);
mn(1,3)=min(y3);
m2=min(mi);
disp('min of all signals');
disp(m2);

% Calculating step size.....
size=(m1-m2)/15;
disp('step size');
disp(size);

% Finding all quantization levels....
j=7;
for i=1:16
    quan(i)=size*j;
    j=j-1;
end
for i=1:16
    qlev(i,1)=quan(i);
end
disp('quantization levels');
disp(qlev);

% Assigning binary values to quantization levels.....
l=8;
for k=0:7    
w=k;
    for i=1:4
        tmp=mod(w,2);
        w=fix(w/2);
        po(i)=tmp;
    end
n=4;
    for j=1:4
        code(l,j)=po(n);
        n=n-1;
    end
    l=l-1;
end
l=16;   
for k=8:15    
w=k;
    for i=1:4
        tmp=mod(w,2);
        w=fix(w/2);
        po(i)=tmp;
    end
n=4;
    for j=1:4
        code(l,j)=po(n);
        n=n-1;
    end
    l=l-1;
end 
disp('Binary representation of each quantization level');
disp(code);


for i=1:11
    for j=1:15
        if y1(i)<=quan(j)&y1(i)>=quan(j+1)
            if y1(i)<=(quan(j+1)+quan(j))/2
                r1(i)=quan(j+1);
                j=16;
            else
                r1(i)=quan(j);
                j=16;
            end
        end
    end
end
disp('quantizied output of signal 1');
disp(r1);
for i=1:11
    for j=1:16
        if r1(i)==quan(j)
            for k=1:4
                s_1(i,k)=code(j,k);
            end
            j=17;
        end
    end
end
k=1;
for i=1:11
    for j=1:4
        s1(k)=s_1(i,j);
        k=k+1;
    end
end
disp('Equivalent binary output of signal 1');
disp(s1);

% second signal quantization.......
for i=1:11
    for j=1:15
        if y2(i)<=quan(j)&y2(i)>=quan(j+1)
            if y2(i)<=(quan(j+1)+quan(j))/2
                r2(i)=quan(j+1);
                j=16;
            else
                r2(i)=quan(j);
                j=16;
            end
        end
    end
end
disp('quantizied output of signal 2');
disp(r2);
for i=1:11
    for j=1:16
        if r2(i)==quan(j)
            for k=1:4
                s_2(i,k)=code(j,k);
            end
            j=17;
        end
    end
end
k=1;
for i=1:11
    for j=1:4
        s2(k)=s_2(i,j);
        k=k+1;
    end
end
disp('Equivalent binary output of signal 2');
disp(s2);
% Third Signal Quantization......
for i=1:11
    for j=1:15
        if y3(i)<=quan(j)&y3(i)>=quan(j+1)
            if y3(i)<=(quan(j+1)+quan(j))/2
                r3(i)=quan(j+1);
                j=16;
            else
                r3(i)=quan(j);
                j=16;
            end
        end
    end
end
r3(2)=quan(1);
disp('quantizied output of signal 3');
disp(r3);
for i=1:11
    for j=1:16
        if r3(i)==quan(j)
            for k=1:4
                s_3(i,k)=code(j,k);
            end
            j=17;
        end
    end
end
k=1;
for i=1:11
    for j=1:4
        s3(k)=s_3(i,j);
        k=k+1;
    end
end
disp('Equivalent binary output of signal 3');
disp(s3);

% Given polynomial.....
p=[1 0 1 1];

% forming a matrix of error patterns
for i=1:7
    for j=1:7
        if i==j
            error(i,j)=1;
        else
            error(i,j)=0;
        end
    end
end
disp('error patterns');
disp(error);

% Calculation of syndromes for its respective error pattern............
k=1;
for i=1:7
    erp=[];
    for j=1:7
        erp(j)=error(i,j);
    end
s=division(erp,p);
for j=1:3
    syn(i,j)=s(j);
end
end
disp('Respective syndrome for each error pattern');
disp(syn);
% Codeword generation for samples of signal 1......

% Shifting input data to left by 3 positions......
j=1;
i=1;
for k=1:11
    for n=1:4
    cow1(i)=s1(j);
    i=i+1;
    j=j+1;
    end
    for n=1:3
        cow1(i)=0;
        i=i+1;
    end  
end
% Generating cyclic codeword for input data......
k=1;
n=5;
for i=1:11
    for j=1:7
        tmp1(j)=cow1(k);
        k=k+1;
    end       
fcs=division(tmp1,p);
% Adding FCS to the shifted input data......
for i=1:3
    cow1(n)=fcs(i);
    n=n+1;
end
n=n+4;
end

% Codeword generation for samples of signal 2......

% Shifting input data to left by 3 positions......
j=1;
i=1;
for k=1:11
    for n=1:4
    cow2(i)=s2(j);
    i=i+1;
    j=j+1;
    end
    for n=1:3
        cow2(i)=0;
        i=i+1;
    end  
end
% Generating cyclic codeword for input data......
k=1;
n=5;
for i=1:11
    for j=1:7
        t2(j)=cow2(k);
        k=k+1;
    end       
fcs=division(t2,p);
% Adding FCS to the shifted input data......
for i=1:3
    cow2(n)=fcs(i);
    n=n+1;
end
n=n+4;
end

% Codeword generation for samples of signal 3......

% Shifting input data to left by 3 positions......
j=1;
i=1;
for k=1:11
    for n=1:4
    cow3(i)=s3(j);
    i=i+1;
    j=j+1;
    end
    for n=1:3
        cow3(i)=0;
        i=i+1;
    end  
end
% Generating cyclic codeword for input data......
k=1;
n=5;
for i=1:11
    for j=1:7
        tmp3(j)=cow3(k);
        k=k+1;
    end       
fcs=division(tmp3,p);
% Adding FCS to the shifted input data......
for i=1:3
    cow3(n)=fcs(i);
    n=n+1;
end
n=n+4;
end

% Performing multiplexing of 3 signals.......
n=1;
po=1;
for i=1:11
    for j=1:7
    tdm(n)=cow1(po);
    tdm(n+7)=cow2(po);
    tdm(n+14)=cow3(po);
    po=po+1;
    n=n+1;
    end
    n=n+14;
end

% Performing demultiplexing of 3 signals........
n=1;
po=1;
for i=1:11
    for j=1:7
        cow1(po)=tdm(n);
        cow2(po)=tdm(n+7);
        cow3(po)=tdm(n+14);
        po=po+1;
        n=n+1;
    end
    n=n+14;
end

% Performing error detection and correction on signal 1 codewords.....
k=1;
x=0;
for i=1:11
    for j=1:7
        tmp1(j)=cow1(k);
        k=k+1;
    end       
sy=division(tmp1,p);
if sy==0
    x=x+1;
else 
   disp('received cyclic codeword has an error');
end
end
if x==11
    disp('No error in received codewords of signal 1');
end
% Performing error detection and correction on signal 2 codewords.....
k=1;
x=0;
for i=1:11
    for j=1:7
        t2(j)=cow2(k);
        k=k+1;
    end       
sy=division(t2,p);
if sy==0
    x=x+1;
else
    disp('received cyclic codeword has an error');
end
end
if x==11
    disp('No error in received codewords of signal 2');
end
% Performing error detection and correction on signal 3 codewords.....
k=1;
x=0;
for i=1:11
    for j=1:7
        tmp3(j)=cow3(k);
        k=k+1;
    end       
sy=division(tmp3,p);
if sy==0
    x=x+1;
else
    disp('received cyclic codeword has an error');
end
end
if x==11
    disp('No error in received codewords of signal 3');
end

% Retreiving data from the codewords of signal 1........
n=1;
k=1;
for i=1:11
    for j=1:4
        re1(n)=cow1(k);
        k=k+1;
        n=n+1;
    end
    k=k+3;
end
disp('Received digital data of signal 1');
disp(re1);

% Retreiving data from the codewords of signal 2........
n=1;
k=1;
for i=1:11
    for j=1:4
        re2(n)=cow2(k);
        k=k+1;
        n=n+1;
    end
    k=k+3;
end
disp('Received digital data of signal 2');
disp(re2);

% Retreiving data from the codewords of signal 3........
n=1;
k=1;
for i=1:11
    for j=1:4
        re3(n)=cow3(k);
        k=k+1;
        n=n+1;
    end
    k=k+3;
end
disp('Received digital data of signal 3');
disp(re3);

% Getting the corresponding quantization level values for received digital data.....
% for signal 1......
k=1;
for i=1:11
    for j=1:4
        tmp(j)=re1(k);
        k=k+1;
    end
    
    for po=1:16
        n=0;
        for j=1:4
            if tmp(j)==code(po,j)
                   n=n+1;
            end
        end
        if n==4
            rs1(i)=quan(po);
            i=12;
        end
    end  
end
disp('Equivalent Quantized values of received digital data of signal 1');
disp(rs1);

% for signal 2.....
k=1;
for i=1:11
    for j=1:4
        tmp(j)=re2(k);
        k=k+1;
    end
    
    for po=1:16
        n=0;
        for j=1:4
            if tmp(j)==code(po,j)
                   n=n+1;
            end
        end
        if n==4
            rs2(i)=quan(po);
            i=12;
        end
    end  
end
disp('Equivalent Quantized values of received digital data of signal 2');
disp(rs2);

% for signal 3......
k=1;
for i=1:11
    for j=1:4
        tmp(j)=re3(k);
        k=k+1;
    end
    
    for po=1:16
        n=0;
        for j=1:4
            if tmp(j)==code(po,j)
                   n=n+1;
            end
        end
        if n==4
            rs3(i)=quan(po);
            i=12;
        end
    end  
end
disp('Equivalent Quantized values of received digital data of signal 3');
disp(rs3);


y1=interp(rs1,1);
figure;
subplot(3,1,1);
plot(t,y1);
title('Received Signal 1');
ylabel('Amplitude--->');
xlabel('Time--->');

% signal 2.....
y2=interp(rs2,1);
subplot(3,1,2);
plot(t,y2);
title('Received Signal 2');
ylabel('Amplitude--->');
xlabel('Time--->');

% signal 2.....
y3=interp(rs3,1);
subplot(3,1,3);
plot(t,y3);
title('Received Signal 3');
ylabel('Amplitude--->');
xlabel('Time--->');


function y1= division(y,P)
l1=length(y);  %generating the check code
l2=length(P);
y1= y;
for i= 1:l1-l2+1
    if y1(1,i) == 1
        y1(1,(1:l2)+i-1)= bitxor(y1(1,(1:l2)+i-1),P);
    end
end
y1=y1(1,l1-l2+2:l1);
end
