
clc;

figure(1);
graph_numbers = ['1', '2'];

% Choose which graph do you want to display
graph_number = graph_numbers(2);

url = get_camera_url();
snapshot = imread(url);

while(1)    
    snapshot  = imread(url);                
    if graph_number == graph_numbers(1)
        % first graph
        img_disp = image(snapshot);
        draw2DCircle(center,Rmin,'m');
        draw2DCircle(center,Rmax,'m');
        set(img_disp,'CData',snapshot);
        drawnow;
    else        
        % second graph        
        ud = unwrap_allimage(snapshot, center, Rmax, 1, 0);
        imagesc(ud);
        img_disp = image(ud);
        hold on;
        line( [0, size(ud,2) ], [ round(radius), round(radius) ] , 'Color', 'r', 'LineWidth', 2);
        line( [0, size(ud,2) ], [ round(Rmin), round(Rmin) ] , 'Color', 'm', 'LineWidth', 2);
        hold off;    
        set(img_disp,'CData',ud);
        drawnow;    
    end    
end









