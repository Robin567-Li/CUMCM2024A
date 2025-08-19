function isOverlap = sat_rect_overlap(rect1, rect2)
    % 输入参数：
    %   rect1: 4x2矩阵，表示矩形1的四个顶点坐标（顺时针或逆时针顺序）
    %   rect2: 4x2矩阵，表示矩形2的四个顶点坐标
    %   drawFlag: 可选参数，true时绘制图形（默认false）
    % 输出：
    %   isOverlap: 布尔值，true表示重叠

    % 获取所有边的法线方向（分离轴）
    axes = get_all_axes(rect1, rect2);
    
    % 检查所有分离轴上的投影是否重叠
    isOverlap = true;
    for i = 1:size(axes, 1)
        axis = axes(i, :);
        [min1, max1] = project_vertices(rect1, axis);
        [min2, max2] = project_vertices(rect2, axis);
        
        % 若存在投影不重叠，则不相交
        if max1 < min2 || max2 < min1
            isOverlap = false;
            break;
        end
    end
end

%% 子函数：获取所有边的法线方向（分离轴）
function axes = get_all_axes(verts1, verts2)
    axes = [];
    % 处理矩形1的边
    for i = 1:4
        v1 = verts1(i, :);
        v2 = verts1(mod(i,4)+1, :); % 循环连接最后一个顶点到第一个
        edge = v2 - v1;
        normal = [-edge(2), edge(1)]; % 法向量（垂直边）
        axes = [axes; normal / norm(normal)]; % 单位化
    end
    % 处理矩形2的边
    for i = 1:4
        v1 = verts2(i, :);
        v2 = verts2(mod(i,4)+1, :);
        edge = v2 - v1;
        normal = [-edge(2), edge(1)];
        axes = [axes; normal / norm(normal)];
    end
    % 去重（避免重复轴）
    axes = unique(axes, 'rows', 'stable');
end

%% 子函数：投影顶点到指定轴
function [minVal, maxVal] = project_vertices(verts, axis)
    proj = zeros(size(verts, 1), 1);
    for i = 1:size(verts, 1)
        proj(i) = dot(verts(i, :), axis); % 点积计算投影标量
    end
    minVal = min(proj);
    maxVal = max(proj);
end

