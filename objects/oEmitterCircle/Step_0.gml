var _currentDirection = point_direction(centerX,centerY,x,y);
var _newDirection =  (_currentDirection + angularSpeed + 360) % 360;

x = lengthdir_x(radius,_newDirection) + centerX;
y = lengthdir_y(radius,_newDirection) + centerY;