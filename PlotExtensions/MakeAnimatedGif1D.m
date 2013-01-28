function [] = MakeAnimatedGif1D(HorizData,VertData,ParamData,FileName,Options)
    
    X = HorizData   ;
    Y = VertData    ;
    T = ParamData   ;
    
    Nframes = size(Y)                    ;
    [MaxX,MinX] = GetMaxMinOfCellArray(X);
    [MaxY,MinY] = GetMaxMinOfCellArray(Y);
    
%     figure();
%     
%     
%     f = getframe(gcf);
%     clf();
%     
%     [Image,Map] = rgb2ind(f.cdata,256,'nodither');
%     Image(1,1,1,Nframes) = 0;
%     Map(1,3,Nframes)     = 0;
    
    Handle = plot(X{1},Y{1});

    axis([MinX,MaxX,MinY,1.05*MaxY]);
    xlabel('x distance [-]','FontName','Times New Roman','FontSize',16);
    ylabel('y distance [-]','FontName','Times New Roman','FontSize',16);
    title(['Power: ',num2str(T(1)),' seconds'],'FontName','Times New Roman','FontSize',16);
    grid('on');
    set(gcf,'Color',[1,1,1]);

    Frame = getframe(gcf);
    [Image(:,:,1,1),Map] = rgb2ind(Frame.cdata,256);
    MapTemp = Map;
	Map     = zeros([size(MapTemp),Nframes]);
    Map(:,:,1) = MapTemp;
    clf;
    
    for k = 2:Nframes
        plot(X{k},Y{k});
        
        axis([MinX,MaxX,MinY,1.05*MaxY]);
        xlabel('x distance [-]','FontName','Times New Roman','FontSize',16);
        ylabel('y distance [-]','FontName','Times New Roman','FontSize',16);
        title(['Power: ',num2str(T(k)),' seconds'],'FontName','Times New Roman','FontSize',16);
        grid('on');
        set(gcf,'Color',[1,1,1]);
        
        Frame = getframe(gcf);
        [Image(:,:,1,k),Map(:,:,k)] = rgb2ind(Frame.cdata,Map(:,:,1));
        clf;
    end
    
	imwrite(Image,Map,FileName,'DelayTime',0.8,'LoopCount',Inf);
   
    close(gcf);
end

function [Max,Min] = GetMaxMinOfCellArray(CellArray)
    
    Size = size(CellArray)  ;
    Max  = -Inf             ;
    Min  =  Inf             ;
    
    for k = 1:Size(1)
        for m = 1:Size(2)
            Max = max(max(CellArray{k,m},Max));
            Min = min(min(CellArray{k,m},Min));
        end
    end
    
end


