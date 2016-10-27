function [strc]=conc(precursor_position,intrinsic_sensitivity,precursor_array,cflaw,maximum_stress,stress_relief_distance,left_end_clamp,right_end_clamp,total_number_or_precursors)

%MW: The stress_relief_distance cannot equal 0 due to the calculations
%cosh(x/interference_distance) and sinh(x/interference_distance) since you
%may end up doing a calculation 0/0 which gives NaN
if stress_relief_distance<0.001
    %MW: we refer to 'strc' as the local crossover potential (LCP) value
    strc=maximum_stress*intrinsic_sensitivity;
    return
end


ncracks=0;
for i=1:total_number_or_precursors
    if cflaw(i)==1
        ncracks=ncracks+1;
        xc(ncracks)=precursor_array(i);
    end
end


if ncracks==0
    a1=left_end_clamp*stress_relief_distance*tanh(0.5/stress_relief_distance)+(1-left_end_clamp);
    a2=right_end_clamp*stress_relief_distance+(1-right_end_clamp)*tanh(0.5/stress_relief_distance);
    a3=left_end_clamp*stress_relief_distance+(1-left_end_clamp)*tanh(0.5/stress_relief_distance);
    a4=right_end_clamp*stress_relief_distance*tanh(0.5/stress_relief_distance)+(1-right_end_clamp);
    det=-a1*a2-a3*a4;
    c1=((1-left_end_clamp)*a2+(1-right_end_clamp)*a3)/det;
    c2=(-(1-left_end_clamp)*a4+(1-right_end_clamp)*a1)/det;
    x=precursor_position-0.5;
    strc=1+c1*cosh(x/stress_relief_distance)/cosh(0.5/stress_relief_distance)+c2*sinh(x/stress_relief_distance)/cosh(0.5/stress_relief_distance);
    strc=strc*maximum_stress*intrinsic_sensitivity;
    if isnan(strc)
        strc=maximum_stress*intrinsic_sensitivity;
    end
    return
end
if ncracks==1
    if precursor_position<=xc(1)
        a=xc(1);
        b=a/2;
        a1=left_end_clamp*stress_relief_distance*tanh(b/stress_relief_distance)+(1-left_end_clamp);
        a2=left_end_clamp*stress_relief_distance+(1-left_end_clamp)*tanh(b/stress_relief_distance);
        a4=tanh(b/stress_relief_distance);
        det=-(a1*a4+a2);
        c1=((1-left_end_clamp)*a4+a2)/det;
        c2=(-(1-left_end_clamp)+a1)/det;
        x=precursor_position-b;
        strc=1+c1*cosh(x/stress_relief_distance)/cosh(b/stress_relief_distance)+c2*sinh(x/stress_relief_distance)/cosh(b/stress_relief_distance);
        strc=strc*maximum_stress*intrinsic_sensitivity;
        if isnan(strc)
            strc=maximum_stress*intrinsic_sensitivity;
        end
        return
    end
    if precursor_position>xc(1)
        a=xc(1);
        b=(1-a)/2;
        a2=tanh(b/stress_relief_distance);
        a3=right_end_clamp*stress_relief_distance*tanh(b/stress_relief_distance)+(1-right_end_clamp);
        a4=right_end_clamp*stress_relief_distance+(1-right_end_clamp)*tanh(b/stress_relief_distance);
        det=a4+a2*a3;
        c1=(-a4-(1-right_end_clamp)*a2)/det;
        c2=(a3-(1-right_end_clamp))/det;
        x=(precursor_position-a)-b;
        strc=1+c1*cosh(x/stress_relief_distance)/cosh(b/stress_relief_distance)+c2*sinh(x/stress_relief_distance)/cosh(b/stress_relief_distance);
        strc=strc*maximum_stress*intrinsic_sensitivity;
        if isnan(strc)
            strc=maximum_stress*intrinsic_sensitivity;
        end
        return
    end
end

if precursor_position<=xc(1)
    a=xc(1);
    b=a/2;
    a1=left_end_clamp*stress_relief_distance*tanh(b/stress_relief_distance)+(1-left_end_clamp);
    a2=left_end_clamp*stress_relief_distance+(1-left_end_clamp)*tanh(b/stress_relief_distance);
    a4=tanh(b/stress_relief_distance);
    det=-(a1*a4+a2);
    c1=((1-left_end_clamp)*a4+a2)/det;
    c2=(-(1-left_end_clamp)+a1)/det;
    x=precursor_position-b;
    strc=1+c1*cosh(x/stress_relief_distance)/cosh(b/stress_relief_distance)+c2*sinh(x/stress_relief_distance)/cosh(b/stress_relief_distance);
    strc=strc*maximum_stress*intrinsic_sensitivity;
    if isnan(strc)
        strc=maximum_stress*intrinsic_sensitivity;
    end
    return
end

if precursor_position>=xc(ncracks)
    a=xc(ncracks);
    b=(1-a)/2;
    a2=tanh(b/stress_relief_distance);
    a3=right_end_clamp*stress_relief_distance*tanh(b/stress_relief_distance)+(1-right_end_clamp);
    a4=right_end_clamp*stress_relief_distance+(1-right_end_clamp)*tanh(b/stress_relief_distance);
    det=a4+a2*a3;
    c1=(-a4-(1-right_end_clamp)*a2)/det;
    c2=(a3-(1-right_end_clamp))/det;
    x=(precursor_position-a)-b;
    strc=1+c1*cosh(x/stress_relief_distance)/cosh(b/stress_relief_distance)+c2*sinh(x/stress_relief_distance)/cosh(b/stress_relief_distance);
    strc=strc*maximum_stress*intrinsic_sensitivity;
    if isnan(strc)
        strc=maximum_stress*intrinsic_sensitivity;
    end
    return
end
for i=2:ncracks
    if precursor_position<=xc(i)
        a=xc(i-1);
        b=xc(i);
        break
    end
end
c=(b-a)/2;
x=(precursor_position-a)-c;
strc=(1-cosh(x/stress_relief_distance)/cosh(c/stress_relief_distance))*maximum_stress*intrinsic_sensitivity;
if isnan(strc)
    strc=maximum_stress*intrinsic_sensitivity;
end
return
end